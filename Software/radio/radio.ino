#include "testTransmitter.h"
#include "testReceiver.h"

//TestTransmitter test;
TestReceiver test;

void setup()
{
  Serial.begin(9600);
}

void loop() 
{
  test.run();
}
