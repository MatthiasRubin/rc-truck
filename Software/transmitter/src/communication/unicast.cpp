#include "arduino.h"

#include "unicast.h"
using namespace UNICAST;


Receiver::Receiver(COM::PhysicalReceiver& device) : physical(device), newData(false) {}


bool Receiver::receive(uint8_t address, uint8_t* data)
{
  bool addressMatch = false;

  if (physical.receive(frameBuffer,FRAME_SIZE))
  {
    // new data received
    newData = true;
  }

  if (newData)
  {
    // check address
    if (frameBuffer[ADDRESS] == address)
    {
      // get data
      *data = frameBuffer[DATA];

      // update flags
      addressMatch = true;
      newData = false;
    }
  }

  return addressMatch;
}
      

Transmitter::Transmitter(COM::PhysicalTransmitter& device) : physical(device) {}


void Transmitter::transmit(uint8_t address, uint8_t data)
{
  uint8_t frameBuffer[FRAME_SIZE];
  frameBuffer[ADDRESS] = address;
  frameBuffer[DATA] = data;

  // transmit frame
  physical.transmit(frameBuffer,FRAME_SIZE);
}
