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

// Cut off duration(msec.):
const int DURATION = 55;

// Mag off threashold(0-1024):
const int MAG_THREASHOLD = 512;

// Set pin number:
const int TRIGGER_PIN = 6;
const int GATE_PIN = 10;
const int MAGAZINE_PIN = 12;

// variables:
int cutOffTime = 0;
int triggerState = LOW;
int magazineState = 0;
boolean firing = false;
boolean magLoaded = false;

void setup() {

  pinMode(TRIGGER_PIN, INPUT);
  digitalWrite(TRIGGER_PIN, LOW);

  pinMode(MAGAZINE_PIN, INPUT);

  pinMode(GATE_PIN, OUTPUT);
  digitalWrite(GATE_PIN, LOW);
}

void loop() {

  magazineState = analogRead(MAGAZINE_PIN);
  triggerState = digitalRead(TRIGGER_PIN);

  if (magazineState < MAG_THREASHOLD) {
    digitalWrite(GATE_PIN, triggerState);
  } else {
    if (firing) {
      if (cutOffTime < mills()) {
        firing = false;
        digitalWrite(GATE_PIN, LOW);
      }
    } else {
      if (triggerState == HIGH) {
        cutOffTime = mills() + DURATION;
        digitalWrite(GATE_PIN, HIGH);
      }
    }
  }
}

}

    
