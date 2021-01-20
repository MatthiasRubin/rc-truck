#include <Servo.h>

Servo myservo;

int potpin = 0;
int val;
int val2;
int back = 4;
int fore = 2;
int speed = 3;

int sum = 0;
int buffer[8];
int index = 0;

void setup() {
  myservo.attach(9);

  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);

  digitalWrite(back,LOW);
  digitalWrite(fore,LOW);
  digitalWrite(speed,LOW);

  Serial.begin(9600);
}

void loop() {
  sum -= buffer[index];
  buffer[index] = analogRead(potpin);
  sum += buffer[index];
  index++;
  index &= 7;

  val2 = analogRead(1);

  val = (sum>>3);
  
  val -= 510;
  val2 -= 514;

  if (val > 0)
  {
    val = map(val, 0, 514, 110, 150);
  }
  else
  {
    val = map(-val, 0, 510, 110, 40);
  }

  if (val2 > 0)
  {
    val2 = map(val2, 0, 510, 0, 255);
    digitalWrite(back,LOW);
    digitalWrite(fore,HIGH);
  }
  else
  {
    val2 = map(-val2, 0, 514, 0, 255);
    digitalWrite(back,HIGH);
    digitalWrite(fore,LOW);
  }

  analogWrite(speed,70);
  Serial.println(val2);
  myservo.write(150);
  delay(15);
}
