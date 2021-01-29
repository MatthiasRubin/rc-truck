#ifndef _TESTRECEIVER_H_
#define _TESTRECEIVER_H_

#include <stdint.h>
#include <Servo.h>
#include "RF433.h"

class TestReceiver
{
  public:
    TestReceiver();
    void run();
    
  private:
    RF433::Receiver radio;
    Servo servo;
    uint8_t data[2];
};

#endif
