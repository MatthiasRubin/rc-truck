#ifndef _UNICAST_H_
#define _UNICAST_H_

#include <stdint.h>
#include "communication.h"

namespace UNICAST
{
  enum 
  {
    ADDRESS = 0,
    DATA,
    FRAME_SIZE
  };
  
  class Receiver
  {
    public:
      Receiver(COM::PhysicalReceiver& device);
      bool receive(uint8_t address, uint8_t* data);
      
    private:
      COM::PhysicalReceiver& physical;
      uint8_t frameBuffer[FRAME_SIZE];
      bool newData;
  };

  class Transmitter
  {
    public:
      Transmitter(COM::PhysicalTransmitter& device);
      void transmit(uint8_t address, uint8_t data);
      
    private:
      COM::PhysicalTransmitter& physical;
    
  };
}

#endif
