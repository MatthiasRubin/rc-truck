#include "arduino.h"

#include "testTransmitter.h"

enum
{
  transmitterPin = 6,
  radioAddress = 2,
  radioAddress2 = 8,
  radioAddress3 = 13
};


TestTransmitter::TestTransmitter() : radioDevice(transmitterPin), radio(radioDevice,radioAddress), radio2(radioDevice,radioAddress2), radio3(radioDevice,radioAddress3), number(0) 
{
  // initialize all channels
  for (int i = 0; i < (sizeof(data)/sizeof(data[0])); ++i)
  {
    data[i] = 0;
  }
}

void TestTransmitter::run()
{
  if (number >= 100)
  {
    // next byte
    number = 0;

    ++data[0];
  }

  data[1] = random(256);

  ++number;

  // transmit all channels
  for (int i = 0; i < (sizeof(data)/sizeof(data[0])); ++i)
  {
    radio.transmit(i,data[i]);
  }

  radio2.transmit(0,random(256));
  radio3.transmit(0,random(256));
  delay(6);
  radio3.transmit(1,random(256));
  
  delay(6);
}
