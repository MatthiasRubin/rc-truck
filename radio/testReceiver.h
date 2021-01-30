#ifndef _TESTRECEIVER_H_
#define _TESTRECEIVER_H_

#include <stdint.h>
#include <Servo.h>
#include "src/communication/radio.h"
#include "src/communication/RF433.h"

class TestReceiver
{
  public:
    TestReceiver();
    void run();
    
  private:
    RF433::Receiver radioDevice;
    RADIO::Receiver radio;
    Servo servo;
};

#endif
