/*
  RotaryInterrupts - a port-read and interrupt based rotary encoder sketch
  Created by Joshua Layne (w15p), January 4, 2011.
  based largely on: http://www.circuitsathome.com/mcu/reading-rotary-encoder-on-arduino
  Released into the public domain.
*/

#define ENC_A 2
#define ENC_B 3
#define ENC_PORT PIND
uint8_t bitShift = 2; // change to suit your pins (offset from 0,1 per port)
// Note: You need to choose pins that have Interrupt capability.

int counter;
boolean ticToc;

void setup()
{
  pinMode(ENC_A, INPUT);
  digitalWrite(ENC_A, HIGH);
  pinMode(ENC_B, INPUT);
  digitalWrite(ENC_B, HIGH);
  Serial.begin (115200);
  Serial.println("Start");
  counter = 0;
  ticToc = false;
  // Attach ISR to both interrupts
  attachInterrupt(0, read_encoder, CHANGE);
  attachInterrupt(1, read_encoder, CHANGE);
}

void loop()
{
// do some stuff here - the joy of interrupts is that they take care of themselves
}

void read_encoder()
{
  int8_t enc_states[] = {0,-1,1,0,1,0,0,-1,-1,0,0,1,0,1,-1,0};
  static uint8_t encoderState = 0;
  static uint8_t stateIndex = 0;
  static uint8_t filteredPort = 0;
  uint8_t filter = 0x03; // base filter: 0b00000011
  filter <<= bitShift;

  Serial.print("raw port value: ");
  Serial.println(ENC_PORT, BIN);

  Serial.print("filter bitmask: ");
  Serial.println(filter, BIN);

  filteredPort = ENC_PORT & filter;
  Serial.print("filtered port state: ");
  Serial.println(filteredPort, BIN);

  Serial.print("old encoder state: ");
  Serial.println(encoderState, BIN);

  encoderState &= filter; // filter out everything except the rotary encoder pins
  Serial.print("filtered old encoder state: ");
  Serial.println(encoderState, BIN);

  encoderState <<= 2; // shift existing value two bits to the left
  Serial.print("filtered and shifted (<<2) old encoder state: ");
  Serial.println(encoderState, BIN);

  encoderState |= filteredPort; // add filteredport value
  Serial.print("old encoder state + port state: ");
  Serial.println(encoderState, BIN);

  stateIndex = encoderState >> bitShift;
  Serial.print("encoder state index: ");
  Serial.println(stateIndex, DEC);

  if (ticToc) {
  Serial.print("counter tic: ");
  Serial.println(enc_states[stateIndex], DEC);
  counter += enc_states[stateIndex];
  Serial.print("counter: ");
  Serial.println(counter, DEC);
  }
  ticToc = !ticToc;

  Serial.println("----------");
}
