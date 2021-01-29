#ifndef _TESTTRANSMITTER_H_
#define _TESTTRANSMITTER_H_

#include <stdint.h>
#include "RF433.h"

class TestTransmitter
{
  public:
    TestTransmitter();
    void run();
    
  private:
    RF433::Transmitter radio;
    unsigned number;
    uint8_t data[2];
    
};

#endif
