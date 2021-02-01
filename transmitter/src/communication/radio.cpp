#include "arduino.h"

#include "radio.h"
using namespace RADIO;


enum
{
  CHANNEL_SIZE = 3,
  NOF_CHANNELS = 2<<CHANNEL_SIZE,
  CHANNEL_MASK = NOF_CHANNELS-1,
  ADDRESS_SIZE = 8 - CHANNEL_SIZE,
  NOF_ADDRESSES = 2<<ADDRESS_SIZE,
  ADDRESS_MASK = NOF_ADDRESSES-1
};


Receiver::Receiver(COM::PhysicalReceiver& device, uint8_t address) : unicast(device), address(address) {}


bool Receiver::receive(uint8_t channel, uint8_t* data)
{
  uint8_t combinedAddress = (((address & ADDRESS_MASK) << CHANNEL_SIZE) + (channel & CHANNEL_MASK));
  
  return unicast.receive(combinedAddress, data);
}


bool Receiver::receive(uint8_t* data)
{
  return unicast.receive(address, data);
}


Transmitter::Transmitter(COM::PhysicalTransmitter& device, uint8_t address) : unicast(device), address(address) {}


void Transmitter::transmit(uint8_t channel, uint8_t data)
{
  uint8_t combinedAddress = (((address & ADDRESS_MASK) << CHANNEL_SIZE) + (channel & CHANNEL_MASK));
  
  unicast.transmit(combinedAddress, data);
}


void Transmitter::transmit(uint8_t data)
{
  unicast.transmit(address, data);
}
