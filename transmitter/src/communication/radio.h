#ifndef _RADIO_H_
#define _RADIO_H_

#include <stdint.h>
#include "communication.h"
#include "unicast.h"

namespace RADIO
{
  class Receiver
  {
    public:
      Receiver(COM::PhysicalReceiver& device, uint8_t address = 0);
      bool receive(uint8_t channel, uint8_t* data);
      bool receive(uint8_t* data);
      
    private:
      UNICAST::Receiver unicast;
      uint8_t address;
  };

  class Transmitter
  {
    public:
      Transmitter(COM::PhysicalTransmitter& device, uint8_t address = 0);
      void transmit(uint8_t channel, uint8_t data);
      void transmit(uint8_t data);
      
    private:
      UNICAST::Transmitter unicast;
      uint8_t address;
    
  };
}

#endif
