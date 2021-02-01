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
  
  if (checkStartBits())
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
    
    // wait for half stop bit
    delayMicroseconds(BitDuration/2);

    dataReceived = true;
  }

  return dataReceived;
}


bool Receiver::checkStartBits()
{
  bool startDetected = false;
  
  if (digitalRead(dataPin))
  {
    // rising edge detected
    bool level = HIGH;

    // start time measurement
    unsigned long highLevelTime = 0;
    readTime = micros();

    // measure high level time
    while (level && (highLevelTime <= (2*BitDuration - 2*TransitionTime)))
    {
      // check level
      level = digitalRead(dataPin);

      // get high level time
      highLevelTime = micros() - readTime;
    }

    // check high level time
    if (highLevelTime > (BitDuration - TransitionTime))
    {
      // valid start bit detected
      startDetected = true;

      // calculate next read time
      readTime += (2*BitDuration + BitDuration/2 - TransitionTime);
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
  // wait for read time
  while(micros() < readTime);

  // get level
  bool receivedBit = digitalRead(dataPin);

  // next read time
  readTime += BitDuration;

  return receivedBit;
}


Transmitter::Transmitter(int dataPin) : dataPin(dataPin)
{
  // configure data pin
  pinMode(dataPin, OUTPUT);
  digitalWrite(dataPin,LOW);
}


void Transmitter::transmit(const uint8_t* data, int numberOfBytes)
{
  // start time measurement
  writeTime = micros();
  
  // start bits
  sendBit(true);
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

  // stop bits
  sendBit(false);
  sendBit(false);
}


void Transmitter::transmit(uint8_t data)
{
  // transmit 1 byte
  transmit(&data);
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
  // wait for write time
  while(micros() < writeTime);
  
  // set level
  digitalWrite(dataPin,data);

  // next write time
  writeTime += BitDuration;
}
