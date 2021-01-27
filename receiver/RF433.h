#ifndef _RF433_H_
#define _RF433_H_

#include <stdint.h>

namespace RF433
{
  class Receiver
  {
    public:
      Receiver(int dataPin);
      bool receive(uint8_t* data, int numberOfBytes = 1);
      
    private:
      bool checkStartBit();
      bool receiveBit();
      uint8_t receiveByte();
      int dataPin;
  };

  class Transmitter
  {
    public:
      Transmitter(int dataPin);
      bool transmit(uint8_t* data, int numberOfBytes = 1);
      bool transmit(uint8_t data);
      
    private:
      void sendByte(uint8_t data);
      void sendBit(bool data);
      int dataPin;
  };
}

#endif
