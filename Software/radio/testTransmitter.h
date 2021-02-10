#ifndef _TESTTRANSMITTER_H_
#define _TESTTRANSMITTER_H_

#include <stdint.h>
#include "src/communication/radio.h"
#include "src/communication/RF433.h"

class TestTransmitter
{
  public:
    TestTransmitter();
    void run();
    
  private:
    RF433::Transmitter radioDevice;
    RADIO::Transmitter radio;
    RADIO::Transmitter radio2;
    RADIO::Transmitter radio3;
    unsigned number;
    uint8_t data[2];
    
};

#endif
