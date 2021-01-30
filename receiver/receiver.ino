#include <Servo.h>
#include "src/communication/RF433.h"
#include "src/communication/radio.h"

enum
{
  dataPin = 12,
  address = 25,
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

  Serial.begin(9600);
}


void loop()
{
  static int8_t driveData[2] = {0};

  int voltage = analogRead(voltagePin);
  
  if (voltage <= minVoltageLevel)
  {
    // stop forever
    setSpeed(0);
    while(1);
  }

  for (int i = 0; i < 2; ++i)
  {
    while(!radio.receive(i,(uint8_t*)&driveData[i]));
  }
  
  drive(driveData[0]);
  steer(driveData[1]);

  delay(80);
}


void drive(int newSpeed)
{
  static int currentSpeed = 0;
  int speedDifference = newSpeed - currentSpeed;
  
  if (speedDifference > 20)
  {
    speedDifference = 20;
  }
  else if (speedDifference < -20)
  {
    speedDifference = -20;
  }

  currentSpeed += speedDifference;

  setSpeed(currentSpeed);
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
  static int currentAngle = 0;
  int angleDifference = newAngle - currentAngle;
  
  if (angleDifference > 40)
  {
    angleDifference = 40;
  }
  else if (angleDifference < -40)
  {
    angleDifference = -40;
  }

  currentAngle += angleDifference;

  setAngle(currentAngle);
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
