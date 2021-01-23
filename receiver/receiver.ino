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

  delay(80);
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
  } while ((!level) && (time < 40));

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

  Serial.print(speed);
  Serial.print(" ");

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
  
  Serial.println(angle);
  
  myservo.write(servoPos);
}
