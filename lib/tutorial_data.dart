const Map<String, Map<String, Map<String, String>>> tutorialPorts = {
  'Electronic Dice': {
    'Port 5': {'sensor': 'AXM0027', 'action': 'Show Dice Value'},
    'Port 6': {'sensor': 'AXM0007', 'action': 'Roll Dice Button'},
  },
  'RGB Mixer': {
    'Port 5': {'sensor': 'AXM0027', 'action': 'Show Color'},
    'Port 6': {'sensor': 'AXM0004', 'action': 'Red Value'},
    'Port 7': {'sensor': 'AXM0004', 'action': 'Green Value'},
    'Port 8': {'sensor': 'AXM0004', 'action': 'Blue Value'},
  },
};

// Prewritten code for tutorials
const Map<String, String> tutorialCodes = {
  'Electronic Dice': '''
const int sensorPin = A3; // Shake detection sensor pin
const int ledPins[6] = {17, 6, A1, A0, A10, 0}; // LED pins for dice display
int diceValue = 0;

void setup() {
  Serial.begin(9600);

  // Set all LED pins as output
  for (int i = 0; i < 6; i++) {
    pinMode(ledPins[i], OUTPUT);
  }

  pinMode(sensorPin, INPUT); // Set sensor pin as input
}

void loop() {
  int shakeValue = analogRead(sensorPin); // Read shake sensor value

  if (shakeValue > 512) { // Threshold for shake detection
    diceValue = random(1, 7); // Generate a random number between 1 and 6
    displayDice(diceValue);   // Display the dice value on LEDs
    delay(1000);              // Delay to prevent multiple readings
  }
}

// Function to display dice value on LEDs
void displayDice(int value) {
  // Turn off all LEDs
  for (int i = 0; i < 6; i++) {
    digitalWrite(ledPins[i], LOW);
  }

  // Turn on LEDs based on the dice value
  switch (value) {
    case 1:
      digitalWrite(ledPins[0], HIGH); // LED 1
      break;
    case 2:
      digitalWrite(ledPins[1], HIGH); // LED 2
      digitalWrite(ledPins[2], HIGH); // LED 3
      break;
    case 3:
      digitalWrite(ledPins[0], HIGH); // LED 1
      digitalWrite(ledPins[1], HIGH); // LED 2
      digitalWrite(ledPins[3], HIGH); // LED 4
      break;
    case 4:
      digitalWrite(ledPins[0], HIGH); // LED 1
      digitalWrite(ledPins[1], HIGH); // LED 2
      digitalWrite(ledPins[4], HIGH); // LED 5
      digitalWrite(ledPins[5], HIGH); // LED 6
      break;
    case 5:
      digitalWrite(ledPins[0], HIGH); // LED 1
      digitalWrite(ledPins[1], HIGH); // LED 2
      digitalWrite(ledPins[2], HIGH); // LED 3
      digitalWrite(ledPins[4], HIGH); // LED 5
      digitalWrite(ledPins[5], HIGH); // LED 6
      break;
    case 6:
      digitalWrite(ledPins[0], HIGH); // LED 1
      digitalWrite(ledPins[1], HIGH); // LED 2
      digitalWrite(ledPins[3], HIGH); // LED 4
      digitalWrite(ledPins[4], HIGH); // LED 5
      digitalWrite(ledPins[5], HIGH); // LED 6
      break;
  }
}

''',
};
