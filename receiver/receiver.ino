#include <Servo.h>

Servo myservo;

enum
{
  dataPin = 12,
  servoPin = 9,
  forewardPin = 2,
  speedPin = 3,
  reversePin = 4
};

enum
{
  minSteeringAngle = 40,
  middleSteeringAngle = 108,
  maxSteeringAngle = 160
};

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
  int8_t driveData = (int8_t)receiveData();
  int8_t steerData = (int8_t)receiveData();
  
  drive(driveData);
  steer(steerData);

  delay(15);
}

uint8_t receiveData()
{
  unsigned long startTime = millis();
  bool level = LOW;
  unsigned long time = 0;
  uint8_t data = 0;

  // waiting for start bit
  do
  {
    level = digitalRead(dataPin);
    time = millis() - startTime;
  } while ((!level) && (time < 150));

  if (level)
  {
    delayMicroseconds(150);
    
    // receive data
    for (int i = 0; i < 8; ++i)
    {
      data <<= 1;
      
      if (digitalRead(dataPin))
      {
        data |= 1;
      }

      delayMicroseconds(100);
    }
  }
  return data;
}


void drive(int value)
{
  unsigned speed;

  if (value >= 0)
  {
    speed = map(value, 0, 127, 0, 255);

    digitalWrite(reversePin,LOW);
    digitalWrite(forewardPin,HIGH);

    Serial.print(speed);
  }
  else
  {
    speed = map(value, -128, 0, 150, 0);
    
    digitalWrite(forewardPin,LOW);
    digitalWrite(reversePin,HIGH);
    
    Serial.print(-((int)speed));
  }
  
  Serial.print(" ");

  analogWrite(speedPin,speed);
}


void steer(int value)
{
  unsigned angle;
  
  if (value >= 0)
  {
    angle = map(value, 0, 127, middleSteeringAngle, maxSteeringAngle);
  }
  else
  {
    angle = map(value, -128, 0, minSteeringAngle, middleSteeringAngle);
  }
  
  Serial.println(angle);
  
  myservo.write(angle);
}
