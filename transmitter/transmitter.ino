enum
{
  joystickXPin = 1,
  joystickYPin = 0,
  dataPin = 6
};

enum
{
  middleJoystickXValue = 508,
  middleJoystickYValue = 512
};

void setup()
{
  pinMode(dataPin, OUTPUT);
  digitalWrite(dataPin,LOW);

  Serial.begin(9600);
}

void loop()
{ 
  unsigned joystickXValue = analogRead(joystickXPin);
  unsigned joystickYValue = analogRead(joystickYPin);
  int8_t value;

  if (joystickYValue >= middleJoystickYValue)
  {
    value = map(joystickYValue, middleJoystickYValue, 1023, 0, 127);
  }
  else
  {
    value = map(joystickYValue, 0, middleJoystickYValue, -128, 0);
  }

  sendByte((uint8_t)value);
  Serial.print(value);
  Serial.print(" ");

  if (joystickXValue >= middleJoystickXValue)
  {
    value = map(joystickXValue, middleJoystickXValue, 1023, 0, 127);
  }
  else
  {
    value = map(joystickXValue, 0, middleJoystickXValue, -128, 0);
  }
  
  sendByte((uint8_t)value);
  Serial.println(value);

  delay(100);
}


void sendByte(uint8_t data)
{
  uint8_t mask = 0x80;
  
  // start bit
  sendBit(true);

  while(mask != 0)
  {
    sendBit((data & mask) != 0);
    
    mask >>= 1;
  }

  // stop bit
  sendBit(false);
}

void sendBit(bool data)
{
  digitalWrite(dataPin,data);
  delayMicroseconds(100);
}
