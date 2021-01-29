#include "arduino.h"

#include "radioTest.h"

enum
{
  receiverPin = 12,
  transmitterPin = 6,
  servoPin = 9,
  forewardPin = 2,
  speedPin = 3,
  reversePin = 4
};

TestReceiver::TestReceiver() : radio(receiverPin), number(0), data(0)
{
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
  uint8_t newData;
  
  if (radio.receive(&newData))
  {
    if (newData != data)
    {
      Serial.print(data);
      Serial.print(";");
      Serial.print(number);
      Serial.print(";");
      Serial.println(newData);
      
      data = newData;
      number = 0;
    }

    ++number;
  }
}

TestTransmitter::TestTransmitter() : radio(transmitterPin), number(0), data(0) {}

void TestTransmitter::run()
{
  if (number >= 10000)
  {
    // next byte
    number = 0;

    ++data;
  }

  ++number;
  radio.transmit(data);
  delay(4);
}
