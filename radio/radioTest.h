#ifndef _RADIOTEST_H_
#define _RADIOTEST_H_

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
    unsigned number;
    uint8_t data;
};

class TestTransmitter
{
  public:
    TestTransmitter();
    void run();
    
  private:
    RF433::Transmitter radio;
    unsigned number;
    uint8_t data;
    
};

#endif
