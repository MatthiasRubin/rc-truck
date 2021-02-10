#ifndef _RF433_H_
#define _RF433_H_

#include <stdint.h>
#include "communication.h"

namespace RF433
{
  class Receiver: public COM::PhysicalReceiver
  {
    public:
      Receiver(int dataPin);
      bool receive(uint8_t* data, int numberOfBytes = 1);
      
    private:
      bool checkStartBits();
      bool receiveBit();
      uint8_t receiveByte();
      int dataPin;
      unsigned long readTime;
  };

  class Transmitter: public COM::PhysicalTransmitter
  {
    public:
      Transmitter(int dataPin);
      void transmit(const uint8_t* data, int numberOfBytes = 1);
      void transmit(uint8_t data);
      
    private:
      void sendByte(uint8_t data);
      void sendBit(bool data);
      int dataPin;
      unsigned long writeTime;
  };
}

#endif
