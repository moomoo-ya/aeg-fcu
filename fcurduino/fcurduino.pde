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
const int MAG_THREASHOLD = 128;

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

  // for debug
  //Serial.begin(9600);
}

void loop() {

  magazineState = analogRead(MAGAZINE_PIN);
  triggerState = digitalRead(TRIGGER_PIN);

  if (magazineState < MAG_THREASHOLD) {
    firing = false;
    digitalWrite(GATE_PIN, LOW);
  } 
  else {
    if (firing) {
      if (cutOffTime < millis()) {
        firing = false;
        digitalWrite(GATE_PIN, LOW);
      }
    } 
    else {
      if (triggerState == HIGH) {
        cutOffTime = millis() + DURATION;
        firing = true;
        digitalWrite(GATE_PIN, HIGH);
      }
    }
  }
  /*
  Serial.print("magSts:");
  Serial.print(magazineState);
  Serial.print("/tgrSts:");
  Serial.print(triggerState);
  Serial.print("/firing:");
  Serial.println(firing);
  delay(1);
  */
}


