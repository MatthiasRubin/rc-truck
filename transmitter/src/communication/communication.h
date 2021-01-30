#ifndef _COMMUNICATION_H_
#define _COMMUNICATION_H_

#include <stdint.h>

namespace COM
{
  class PhysicalReceiver
  {
    public:
      virtual bool receive(uint8_t* data, int numberOfBytes = 1) = 0;
  };

  class PhysicalTransmitter
  {
    public:
      virtual void transmit(const uint8_t* data, int numberOfBytes = 1) = 0;
      virtual void transmit(uint8_t data) = 0;
  };
}

#endif
