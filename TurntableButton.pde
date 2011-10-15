#define buttonPin 2 // analog input pin to use as a digital input
#define debounce 20 // ms debounce period to prevent flickering when pressing or releasing the button
#define holdTime 700 // ms hold period: how long to wait for press+hold event

// Button variables
int buttonVal = 0; // value read from button
int buttonLast = 0; // buffered value of the button's previous state
long btnDnTime; // time the button was pressed down
long btnUpTime; // time the button was released
boolean ignoreUp = false; // whether to ignore the button release because the click+hold was triggered
int RGBLpins[] = {6,5,3}; //blue = 3, green = 5, red 6
//=================================================

void setup() {
  pinMode(buttonPin, INPUT);
  digitalWrite(buttonPin, HIGH);
  Serial.begin(9600);
  RESET_PINS();
}

void loop() {
  // Read the state of the button
  buttonVal = digitalRead(buttonPin);
  // Test for button pressed and store the down time
  if (buttonVal == LOW && buttonLast == HIGH && (millis() - btnUpTime) > long(debounce)) {
    btnDnTime = millis();
  }
  // Test for button release and store the up time
  if (buttonVal == HIGH && buttonLast == LOW && (millis() - btnDnTime) > long(debounce)) {
    if (ignoreUp == false) event1();
    else ignoreUp = false;
    btnUpTime = millis();
  }
  // Test for button held down for longer than the hold time
  if (buttonVal == LOW && (millis() - btnDnTime) > long(holdTime)) {
    event2();
    ignoreUp = true;
    btnDnTime = millis();
  }
  buttonLast = buttonVal;
}

void RESET_PINS() {
  pinMode(RGBLpins[0], OUTPUT);
  pinMode(RGBLpins[1], OUTPUT);
  pinMode(RGBLpins[2], OUTPUT);
  analogWrite(RGBLpins[0], 255);
  analogWrite(RGBLpins[1], 255);
  analogWrite(RGBLpins[2], 255);
}

//=================================================
void event1() {
  Serial.println("up");
  int i=0;
  while(i<4) { //blink green
    analogWrite(RGBLpins[0], 255);
    analogWrite(RGBLpins[1], 0);
    analogWrite(RGBLpins[2], 255);
    delay(300);
    analogWrite(RGBLpins[0], 255);
    analogWrite(RGBLpins[1], 255);
    analogWrite(RGBLpins[2], 255);
    delay(300);
    i++;
  }
}
void event2() {
  Serial.println("down");
  int i=0;
  while(i<4) { //blink red
    analogWrite(RGBLpins[0], 0);
    analogWrite(RGBLpins[1], 255);
    analogWrite(RGBLpins[2], 255);
    delay(300);
    analogWrite(RGBLpins[0], 255);
    analogWrite(RGBLpins[1], 255);
    analogWrite(RGBLpins[2], 255);
    delay(300);
    i++;
  }
}
