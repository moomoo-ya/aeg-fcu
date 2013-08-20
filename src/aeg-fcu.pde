/*
  Original Fire Control Unit
 
 This Sketch is "Fire Control Unit" for AEG.
 
 The circuit:
 * Trigger SW:
   * ends to +5V(over diode) and digital pin 6(over 100ohm register)
 * FET:
   * Gate pin to digital pin 10(over 470ohm register)
   * Drain pin to motor(-)
   * Source pin to GND
 * 10K register:
   * ends to FET Source and FET Gate
 * Diode:
   * Motor(-) -> Motor(+)
   * +5V -> Triger SW
 * 10uF capacitor:
   * GND -> Trigger SW
 
 
 */

// Turn on duration(msec.):
const int DURATION = 55;
const int PRESS_DURATION = 2000;

// Set pin number:
const int TRIGGER_PIN = 6;
const int GATE_PIN = 10;

// variables:
int countDown = 0;
int triggerTime = 0;
int triggerState = LOW;

void setup() {
  pinMode(TRIGGER_PIN, INPUT);
  digitalWrite(TRIGGER_PIN, LOW);
  pinMode(GATE_PIN, OUTPUT);
  digitalWrite(GATE_PIN, LOW);
}

void loop() {
  triggerState = digitalRead(TRIGGER_PIN);

  if (countDown <= 0) {
    if (triggerState == HIGH) {
      countDown = DURATION;
      digitalWrite(GATE_PIN, HIGH);
    } else {
      digitalWrite(GATE_PIN, LOW);
    }
  } else {
    countDown--;
  }
  
  if (triggerState == HIGH) {
    triggerTime++;
    if (triggerTime > PRESS_DURATION) {
      
    }
  } else {
    triggerTime = 0;
  }

  delay(1);

}

    
