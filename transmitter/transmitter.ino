#include "src/communication/RF433.h"
#include "src/communication/radio.h"


enum
{
  joystickXPin = 1,
  joystickYPin = 0,
  dataPin = 6,
  address = 25
};

enum
{
  middleJoystickXValue = 508,
  middleJoystickYValue = 512
};


RF433::Transmitter radioDevice(dataPin);
RADIO::Transmitter radio(radioDevice,address);


void setup()
{

}


void loop()
{ 
  unsigned joystickXValue = analogRead(joystickXPin);
  unsigned joystickYValue = analogRead(joystickYPin);
  int8_t value[2];

  if (joystickYValue >= middleJoystickYValue)
  {
    value[0] = map(joystickYValue, middleJoystickYValue, 1023, 0, 127);
  }
  else
  {
    value[0] = map(joystickYValue, 0, middleJoystickYValue, -128, 0);
  }

  if (joystickXValue >= middleJoystickXValue)
  {
    value[1] = map(joystickXValue, middleJoystickXValue, 1023, 0, 127);
  }
  else
  {
    value[1] = map(joystickXValue, 0, middleJoystickXValue, -128, 0);
  }

  for (int i = 0; i < 2; ++i)
  {
    radio.transmit(i,(uint8_t)value[i]);
  }

  delay(100);
}
