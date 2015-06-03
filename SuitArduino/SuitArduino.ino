/* Listenes to SoftwareSerial for specific command strings. 

Code mostly extracted from this web page.
http://stackoverflow.com/questions/5697047/convert-serial-read-into-a-useable-string-using-arduino
*/

char inData[20]; // Allocate some space for the string
char inChar=-1; // Where to store the character read
byte index = 0; // Index into array; where to store the character
int led = 13;

#include <SoftwareSerial.h>
// software serial #1: TX = digital pin 10, RX = digital pin 11
SoftwareSerial portOne(10,11);

void setup()
{
  // initialize the digital pin as an output.
  pinMode(led, OUTPUT);
 // Open serial communications and wait for port to open:
  Serial.begin(9600);
   while (!Serial) {
    ; // wait for serial port to connect. Needed for Leonardo only
  }

  // Start each software serial port
  portOne.begin(9600);
}

void loop()
{
   if (readData()) {
     if (!strcmp(inData, "open")) {
       Serial.println("Opening the Back");
       digitalWrite(led, HIGH);
     } else if (strcmp(inData, "close") == 0) {
       Serial.println("Closing the Back");
       digitalWrite(led, LOW);
     } else if (strcmp(inData, "startup") == 0) {
       Serial.println("Testing Startup sequences.");
     } else {
       Serial.print("Unknown:");
       Serial.print(inData);
       Serial.println(":");
     }
   }
   delay(100);
}

bool readData() {
    // By default, the last intialized port is listening.
    // when you want to listen on a port, explicitly select it:
    portOne.listen();
    bool hasData = portOne.available() > 1;
    for (int i=0;i<19;i++) {
        inData[i]=0;
    }
    while (portOne.available() > 0) // Don't read unless
                                   // there you know there is data
    {
        if(index < 19) // One less than the size of the array
        {
          inChar = portOne.read(); // Read a character
          if ((inChar == '\n') || (inChar == '\r')) {
            index = 0;
            return hasData;
          }
          inData[index] = inChar; // Store it
          index++; // Increment where to write next
          inData[index] = '\0'; // Null terminate the string
        }
    }
    //inData = inData.trim();
    index = 0;
    return hasData;
}

