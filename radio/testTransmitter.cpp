#include "arduino.h"

#include "testTransmitter.h"

enum
{
  transmitterPin = 6
};


TestTransmitter::TestTransmitter() : radio(transmitterPin), number(0) 
{
  for (int i = 0; i < (sizeof(data)/sizeof(data[0])); ++i)
  {
    data[i] = 0;
  }
}

void TestTransmitter::run()
{
  if (number >= 40)
  {
    // next byte
    number = 0;

    ++data[1];

    if (data[1] == 0)
    {
      ++data[0];
    }
  }

  ++number;
  radio.transmit(data, 2);
  delay(4);
}
