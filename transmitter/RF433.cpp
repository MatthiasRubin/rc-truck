#include "arduino.h"

#include "RF433.h"
using namespace RF433;

enum 
{
  BitDuration = 100,
  TransitionTime = 15
};

Receiver::Receiver(int dataPin) : dataPin(dataPin) {}

bool Receiver::receive(uint8_t* data, int numberOfBytes)
{
  bool dataReceived = false;
  
  if (checkStartBit())
  {
    // start bit detected

    // receive bytes
    while (numberOfBytes > 0)
    {
      // receive byte
      *data = receiveByte();

      // next byte
      --numberOfBytes;
      ++data;
    }

    dataReceived = true;
  }

  return dataReceived;
}


bool Receiver::checkStartBit()
{
  bool startDetected = false;
  
  if (digitalRead(dataPin))
  {
    // rising edge detected
    bool level = HIGH;
    unsigned long highLevelTime = 0;
    unsigned long riseTime = micros();

    // get high level time
    while (level && (highLevelTime <= (BitDuration - TransitionTime)))
    {
      // check level
      level = digitalRead(dataPin);

      // get time
      highLevelTime = micros() - riseTime;
    }

    // check high level time
    if (highLevelTime > (BitDuration - TransitionTime))
    {
      // valid start bit detected
      startDetected = true;
    }
  }

  return startDetected;
}


uint8_t Receiver::receiveByte()
{
  uint8_t receivedByte = 0;

  // get 8 bits
  for (int i = 0; i < 8; ++i)
  {
    // prepare for next bit
    receivedByte <<= 1;

    // receive bit
    if (receiveBit())
    {
      receivedByte |= 1;
    } 
  }

  return receivedByte;
}


bool Receiver::receiveBit()
{
  // wait for bit center
  delayMicroseconds(BitDuration/2);

  // get level
  bool receivedBit = digitalRead(dataPin);

  // wait for bit end
  delayMicroseconds(BitDuration/2);

  return receivedBit;
}


Transmitter::Transmitter(int dataPin) : dataPin(dataPin)
{
  // configure data pin
  pinMode(dataPin, OUTPUT);
  digitalWrite(dataPin,LOW);
}


bool Transmitter::transmit(uint8_t* data, int numberOfBytes)
{
  // start bit
  sendBit(true);
  
  // send bytes
  while (numberOfBytes > 0)
  {
    // send byte
    sendByte(*data);

    // next byte
    --numberOfBytes;
    ++data;
  }

  // stop bit
  sendBit(false);
}


bool Transmitter::transmit(uint8_t data)
{
  // start bit
  sendBit(true);

  // send byte
  sendByte(data);

  // stop bit
  sendBit(false);
}


void Transmitter::sendByte(uint8_t data)
{
  // msb first
  uint8_t mask = 0x80;

  // send all bits (msb first)
  while (mask != 0)
  {
    // send bit
    sendBit((data & mask) != 0);

    // next bit
    mask >>= 1;
  }
}


void Transmitter::sendBit(bool data)
{
  // set level
  digitalWrite(dataPin,data);

  // wait for bit end
  delayMicroseconds(BitDuration);
}
