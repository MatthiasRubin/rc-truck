#include <Servo.h>

Servo myservo;

int joystickX = 0;
int joystickY = 1;
int inputX;
int inputY;
int forewardPin = 2;
int speedPin = 3;
int reversePin = 4;

int sum = 0;
int buffer[8];
int index = 0;

void setup() {
  myservo.attach(9);

  pinMode(forewardPin, OUTPUT);
  pinMode(speedPin, OUTPUT);
  pinMode(reversePin, OUTPUT);

  digitalWrite(forewardPin,LOW);
  digitalWrite(speedPin,LOW);
  digitalWrite(reversePin,LOW);

  Serial.begin(9600);
}

void loop() {
  sum -= buffer[index];
  buffer[index] = analogRead(joystickX);
  sum += buffer[index];
  index++;
  index &= 7;

  inputY = analogRead(joystickY);

  inputX = (sum>>3);
  Serial.print(inputX);
  Serial.print(" ");
  Serial.println(inputY);
  
  inputX -= 507; // -507 to 516
  inputY -= 514; // -514 to 509

  if (inputX >= 0)
  {
    inputX = map(inputX, 0, 516, 108, 155);
  }
  else
  {
    inputX = map(-inputX, 0, 507, 108, 40);
  }

  if (inputY >= 0)
  {
    inputY = map(inputY, 0, 509, 0, 255);
    digitalWrite(reversePin,LOW);
    digitalWrite(forewardPin,HIGH);
  }
  else
  {
    inputY = map(-inputY, 0, 514, 0, 255);
    digitalWrite(reversePin,HIGH);
    digitalWrite(forewardPin,LOW);
  }

  analogWrite(speedPin,inputY);
  myservo.write(inputX);
  delay(15);
}
