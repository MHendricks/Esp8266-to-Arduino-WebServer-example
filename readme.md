An example of using ESP8266 as a web server and access point. The ESP is connected
to an Arduino via Serial. Clicking links in the web page triggers specific code on
the arduino.

Original nodemcu-httpserver: https://github.com/marcoskirsch/nodemcu-httpserver

# Wiring

 - Provide 3.3v 250ma+ to the ESP's vcc. **NOTE** Unless you are using something like the Adafruit Huzzah that explicitly says so, the ESP is not 5v tolerant.
 - Connect the TX line of the esp to pin 10 on the Arduino Uno. Note: The TX pin is shared with your USB-serial cable.
 - Connect the ESP's Ground to the Arduino's Ground.

I am using a adafruit Huzza for my ESP8266. This simplifies the wireing setup, but this will work with a ESP8266-01, you just need to connect a resistor between VCC and CH_PD to ensure the wireless device is powered up.

# Flashing the Esp8266

To flash th ESP you will need a USB to serial adapter.
If you havent installed NodeMCU on your Esp, you need to flash it. https://github.com/nodemcu/nodemcu-flasher

# Uploading the web server

Next you need to upload all of the files in the esp8266 folder other than LICENSE and README.md. I use ESPlorer http://esp8266.ru/esplorer/. Unfortunately this means you have to upload one file at a time.

To test run **init1.lua** by clicking the refresh button on the left side of Esplorer then click on the init1.lua button. After you are sure everything is working correctly, you can rename this to init.lua so it is run as soon as the Esp gets power. I do this because if you cause a error in init.lua to fix it you will need to reflash the esp.

# Programming the Arduino

Open the SuitArduino.ino file in the Arduino ide and upload the scetch.

# Testing

 - Power up the ESP and run init1.lua if you haven't renamed it to init.lua.
 - Power up the arduino and open the serial monitor.
 - Connect to the new wireless network on your phone or computer. The default network is "HulkBuster" and the password is "password". You can change this by modifying the Wifi configuration at the top of init1.lua.
 - In a web browser open http://192.168.4.1. You should see several links. If you press open the LED on pin 13 of the arduino should light up. Pressing Close should turn the LED off. If you are connected to the arduino using the serial monitor you should see a message printed for each button press.
 
 # Editing the web page
To add more buttons you need to add them to the body in esp8266\http_index.html. If you change the value passed to pushTheButton you need to update the valid Set in esp8266\http_index.lua to match. I use the valid set to limit what is sent to the arduino.
 