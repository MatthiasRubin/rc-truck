#include "arduino.h"

#include "testReceiver.h"

enum
{
  receiverPin = 12,
  radioAddress = 2,
  servoPin = 9,
  forewardPin = 2,
  speedPin = 3,
  reversePin = 4
};

TestReceiver::TestReceiver() : radioDevice(receiverPin), radio(radioDevice,radioAddress)
{
  // initialize servo
  servo.attach(servoPin);

  // configure motor
  pinMode(forewardPin, OUTPUT);
  pinMode(speedPin, OUTPUT);
  pinMode(reversePin, OUTPUT);

  digitalWrite(forewardPin,LOW);
  digitalWrite(speedPin,LOW);
  digitalWrite(reversePin,LOW);
}

void TestReceiver::run()
{
  uint8_t data;
  
  if (radio.receive(0, &data))
  {
    Serial.println(data);
  }
}
