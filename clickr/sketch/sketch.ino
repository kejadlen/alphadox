#include <Arduino.h>
#include <SPI.h>
#include "Adafruit_BLE.h"
#include "Adafruit_BluefruitLE_SPI.h"
#include "Adafruit_BluefruitLE_UART.h"

#include "BluefruitConfig.h"

#if SOFTWARE_SERIAL_AVAILABLE
  #include <SoftwareSerial.h>
#endif

/*=========================================================================
    APPLICATION SETTINGS

    FACTORYRESET_ENABLE       Perform a factory reset when running this sketch
   
                              Enabling this will put your Bluefruit LE module
                              in a 'known good' state and clear any config
                              data set in previous sketches or projects, so
                              running this at least once is a good idea.
   
                              When deploying your project, however, you will
                              want to disable factory reset by setting this
                              value to 0.  If you are making changes to your
                              Bluefruit LE device via AT commands, and those
                              changes aren't persisting across resets, this
                              is the reason why.  Factory reset will erase
                              the non-volatile memory where config data is
                              stored, setting it back to factory default
                              values.
       
                              Some sketches that require you to bond to a
                              central device (HID mouse, keyboard, etc.)
                              won't work at all with this feature enabled
                              since the factory reset will clear all of the
                              bonding data stored on the chip, meaning the
                              central device won't be able to reconnect.
    MINIMUM_FIRMWARE_VERSION  Minimum firmware version to have some new features
    -----------------------------------------------------------------------*/
    #define FACTORYRESET_ENABLE         0
    #define MINIMUM_FIRMWARE_VERSION    "0.6.6"
/*=========================================================================*/

Adafruit_BluefruitLE_SPI ble(BLUEFRUIT_SPI_CS, BLUEFRUIT_SPI_IRQ, BLUEFRUIT_SPI_RST);

void error(const __FlashStringHelper*err) {
  Serial.println(err);
  while (1);
}

int rows[3] = { 5, 6, 9 };
int cols[2] = { 11, 10 };

#define MAX_CHECKS 5
#define NUM_KEYS 6
int debounced[NUM_KEYS];            // the debounced state
int state[NUM_KEYS];                // the previous state
int readings[MAX_CHECKS][NUM_KEYS]; // holds actual reads from the hardward
int bounceIndex = 0;

void setup(void) {
  while (!Serial);  // required for Flora & Micro
  delay(500);

  Serial.begin(115200);

  if (!ble.begin(VERBOSE_MODE)) {
    error(F("Couldn't find Bluefruit, make sure it's in CoMmanD mode & check wiring?"));
  }

  if (FACTORYRESET_ENABLE) {
    if (!ble.factoryReset()) {
      error(F("Couldn't factory reset"));
    }
  }

  ble.echo(false);
  ble.info();

  if (!ble.sendCommandCheckOK(F("AT+GAPDEVNAME=Clickr"))) {
    error(F("Could not set device name?"));
  }

  if (ble.isVersionAtLeast(MINIMUM_FIRMWARE_VERSION)) {
    if (!ble.sendCommandCheckOK(F("AT+BleHIDEn=On"))) {
      error(F("Could not enable Keyboard"));
    }
  } else {
    if (!ble.sendCommandCheckOK(F("AT+BleKeyboardEn=On"))) {
      error(F("Could not enable Keyboard"));
    }
  }

  if (!ble.reset()) {
    error(F("Couldn't reset??"));
  }

  pinMode( 5, INPUT_PULLUP);
  pinMode( 6, INPUT_PULLUP);
  pinMode( 9, INPUT_PULLUP);
  pinMode(10, OUTPUT);
  pinMode(11, OUTPUT);

  digitalWrite(10, HIGH);
  digitalWrite(11, HIGH);

  for (int i=0; i<NUM_KEYS; i++) {
    state[i] = HIGH;
    for (int j=0; j<MAX_CHECKS; j++) {
     readings[j][i] = HIGH;
    }
  }
}

void loop(void) {
  debounceSwitches();

  bool stateChanged = updateState();

  if (stateChanged) {
    String cmd = calculateCommand();

    ble.println(cmd);
    if (!ble.waitForOK()) {
      Serial.println(F("FAILED!"));
    }
  }
}

// https://pubweb.eng.utah.edu/~cs5780/debouncing.pdf
void debounceSwitches() {
  readSwitches(readings[bounceIndex]);
  
  bounceIndex++;
  if (bounceIndex >= MAX_CHECKS) {
    bounceIndex = 0;
  }

  for (int i=0; i<NUM_KEYS; i++) {
    debounced[i] = HIGH;
  }

  for (int i=0; i<MAX_CHECKS; i++) {
    for (int j=0; j<NUM_KEYS; j++) {
      debounced[j] = debounced[j] & readings[i][j];
    }
  }
}

bool updateState() {
  bool stateChanged = false;
  for (int i=0; i<NUM_KEYS; i++) { 
    if (i == 2) continue;
     
    if (debounced[i] != state[i]) {
      stateChanged = true;
      state[i] = debounced[i];
    }
  }
  return stateChanged;
}

String calculateCommand() {
  int numCodes = 0;
  String codes[NUM_KEYS];

  if (state[0] == LOW) codes[numCodes++] = String("4F");
  if (state[1] == LOW) codes[numCodes++] = String("50");
  if (state[3] == LOW) codes[numCodes++] = String("50");
  if (state[4] == LOW) codes[numCodes++] = String("50");
  if (state[5] == LOW) codes[numCodes++] = String("50");

  String cmd = String("AT+BLEKEYBOARDCODE=00-00");
  for (int i=0; i<numCodes; i++) {
    cmd += "-" + codes[i];
  }
  return cmd;
}

void readSwitches(int *reading) {
  for (int i=0; i<2; i++) {
    int col = cols[i];
    digitalWrite(col, LOW);
    for (int j=0; j<3; j++) {
      int row = rows[j];
      int index = j*2 + i;
      reading[index] = digitalRead(row);
    }
    digitalWrite(col, HIGH);
  }
}

