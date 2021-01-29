#include "arduino.h"

#include "testReceiver.h"

enum
{
  receiverPin = 12,
  servoPin = 9,
  forewardPin = 2,
  speedPin = 3,
  reversePin = 4
};

TestReceiver::TestReceiver() : radio(receiverPin)
{
  for (int i = 0; i < (sizeof(data)/sizeof(data[0])); ++i)
  {
    data[i] = 0;
  }
  
  servo.attach(servoPin);

  pinMode(forewardPin, OUTPUT);
  pinMode(speedPin, OUTPUT);
  pinMode(reversePin, OUTPUT);

  digitalWrite(forewardPin,LOW);
  digitalWrite(speedPin,LOW);
  digitalWrite(reversePin,LOW);
}

void TestReceiver::run()
{
  uint8_t newData[2];
  
  if (radio.receive(newData, 2))
  {
    if (newData[0] != data[0] || newData[1] != data[1])
    {
      Serial.println((data[0]<<8) + (data[1]));
      
      data[0] = newData[0];
      data[1] = newData[1];
    }
  }
}
