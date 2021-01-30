#include <Servo.h>
#include "src/communication/RF433.h"
#include "src/communication/radio.h"

enum
{
  dataPin = 12,
  address = 25,
  nof_channels = 2,
  servoPin = 9,
  forewardPin = 2,
  speedPin = 3,
  reversePin = 4,
  voltagePin = 0
};

enum
{
  minSteeringAngle = 40,
  middleSteeringAngle = 108,
  maxSteeringAngle = 160,
  minVoltageLevel = 524
};


Servo myservo;
RF433::Receiver radioDevice(dataPin);
RADIO::Receiver radio(radioDevice,address);


void setup()
{
  myservo.attach(servoPin);

  pinMode(forewardPin, OUTPUT);
  pinMode(speedPin, OUTPUT);
  pinMode(reversePin, OUTPUT);

  digitalWrite(forewardPin,LOW);
  digitalWrite(speedPin,LOW);
  digitalWrite(reversePin,LOW);
}


void loop()
{
  static int8_t driveData[nof_channels] = {0};

  // check battery voltage
  readVoltage();

  // receive remote data
  receiveData(driveData);

  // drive and steer
  drive(driveData[0]);
  steer(driveData[1]);
}


void readVoltage()
{
  static unsigned long readTime = 0;

  if ((millis() - readTime) > 1000)
  {
    // read battery voltage
    int voltage = analogRead(voltagePin);
    
    if (voltage <= minVoltageLevel)
    {
      // stop forever
      setSpeed(0);
      while(1);
    }

    readTime = millis();
  }
}


void receiveData(int8_t* data)
{
  static unsigned long receiveTime[nof_channels] = {0};
  
  for (int i = 0; i < nof_channels; ++i)
  {
    if (radio.receive(i,(uint8_t*)data))
    {
      // new data received
      receiveTime[i] = millis();
    }

    if ((millis() - receiveTime[i]) > 300)
    {
      // reset on receive timeout
      *data = 0;
    }

    // next channel
    ++data;
  }
}


void drive(int newSpeed)
{
  static unsigned long setTime = 0;
  static int currentSpeed = 0;

  if ((millis() - setTime) > 10)
  {
    setTime = millis();
    
    int speedDifference = newSpeed - currentSpeed;
    
    if (speedDifference > 2)
    {
      speedDifference = 2;
    }
    else if (speedDifference < -2)
    {
      speedDifference = -2;
    }
  
    currentSpeed += speedDifference;
  
    setSpeed(currentSpeed);
  }
}


void setSpeed(int speed)
{
  unsigned dutycycle;

  if (speed >= 0)
  {
    dutycycle = map(speed, 0, 127, 0, 255);

    digitalWrite(reversePin,LOW);
    digitalWrite(forewardPin,HIGH);
  }
  else
  {
    dutycycle = map(speed, -128, 0, 150, 0);
    
    digitalWrite(forewardPin,LOW);
    digitalWrite(reversePin,HIGH);
  }

  analogWrite(speedPin,dutycycle);
}


void steer(int newAngle)
{
  static unsigned long setTime = 0;
  static int currentAngle = 0;

  if ((millis() - setTime) > 10)
  {
    setTime = millis();
    
    int angleDifference = newAngle - currentAngle;
    
    if (angleDifference > 4)
    {
      angleDifference = 4;
    }
    else if (angleDifference < -4)
    {
      angleDifference = -4;
    }
  
    currentAngle += angleDifference;
  
    setAngle(currentAngle);
  }
}


void setAngle(int angle)
{
  unsigned servoPos;
  
  if (angle >= 0)
  {
    servoPos = map(angle, 0, 127, middleSteeringAngle, maxSteeringAngle);
  }
  else
  {
    servoPos = map(angle, -128, 0, minSteeringAngle, middleSteeringAngle);
  }
  
  myservo.write(servoPos);
}
