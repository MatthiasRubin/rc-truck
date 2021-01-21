#include <Servo.h>

Servo myservo;

enum
{
  joystickXPin = 0,
  joystickYPin = 1,
  forewardPin = 2,
  speedPin = 3,
  reversePin = 4
};

enum
{
  middleJoystickValueX = 507,
  middleJoystickValueY = 514,
  minSteeringAngle = 40,
  middleSteeringAngle = 108,
  maxSteeringAngle = 160
};

void setup()
{
  myservo.attach(9);

  pinMode(forewardPin, OUTPUT);
  pinMode(speedPin, OUTPUT);
  pinMode(reversePin, OUTPUT);

  digitalWrite(forewardPin,LOW);
  digitalWrite(speedPin,LOW);
  digitalWrite(reversePin,LOW);
}

void loop()
{ 
  drive();
  steer();

  delay(15);
}


void drive()
{
  unsigned joystickValue = analogRead(joystickYPin);
  unsigned speed = 0;

  if (joystickValue >= middleJoystickValueY)
  {
    speed = map(joystickValue, middleJoystickValueY, 1023, 0, 255);

    digitalWrite(reversePin,LOW);
    digitalWrite(forewardPin,HIGH);
  }
  else
  {
    speed = map(joystickValue, 0, middleJoystickValueY, 150, 0);
    
    digitalWrite(forewardPin,LOW);
    digitalWrite(reversePin,HIGH);
  }

  analogWrite(speedPin,speed);
}


void steer()
{
  static unsigned buffer[8] = {0};
  static unsigned index = 0;
  static unsigned sum = 0;
  
  sum -= buffer[index];
  buffer[index] = analogRead(joystickXPin);
  sum += buffer[index];
  index++;
  index &= 7;
  
  unsigned joystickValue = (sum>>3);
  unsigned angle = 0;
  
  if (joystickValue >= middleJoystickValueX)
  {
    angle = map(joystickValue, middleJoystickValueX, 1023, middleSteeringAngle, maxSteeringAngle);
  }
  else
  {
    angle = map(joystickValue, 0, middleJoystickValueX, minSteeringAngle, middleSteeringAngle);
  }
  
  myservo.write(angle);
}
