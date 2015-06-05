An example of using ESP8266 as a web server and access point. The ESP is connected
to an Arduino via Serial. Clicking links in the web page triggers specific code on
the arduino.

https://youtu.be/OSIEU3Mgy-E
A video showing a early version of the server. After recording I fixed the stylesheet.

Original nodemcu-httpserver: https://github.com/marcoskirsch/nodemcu-httpserver

# Wiring

 - ESP----UNO
 - TX-----10
 - RX-----11
 - GND----GND

Provide 3.3v 250ma+ to the ESP's vcc. **NOTE** Unless you are using something like the Adafruit Huzzah that explicitly says so, the ESP is not 5v tolerant. The ESP requires more power than most arduino's can provide so I wouldn't use the 3.3v from the arduino.

I am using a adafruit Huzza for my ESP8266. This simplifies the wireing setup, but this will work with a ESP8266-01, you just need to connect a 10k resistor between VCC and CH_PD to enable the wireless.

# Flashing the Esp8266

To flash th ESP you will need a USB to serial adapter.
If you havent installed NodeMCU on your Esp, you need to flash it. https://github.com/nodemcu/nodemcu-flasher

# Uploading the web server

Next you need to upload all of the files in the esp8266 folder other than http_index.css, LICENSE and README.md. I use ESPlorer http://esp8266.ru/esplorer/. Unfortunately this means you have to upload one file at a time.

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

# Updating the Stylesheet.

When running nodemcu-httpserver in SOFTAP mode, it appears to run out of memory if it has to serve the css and the web page at the same time. So I edit the css in http_index.css, then use http://cssminifier.com/ to minimize the css. I then paste the minimized css inside the ```<style type="text/css">``` tag.

If you can run in STATION mode this does not appear to be required and you can remove that tag and uncomment the ```<link rel="stylesheet" type="text/css" href="http_index.css">``` line. In this case you will need to upload http_index.css.

# iOS Web Application

http_index.html has all of the meta tags required so you can add the web page to your home screen from safari and when opened it appears to be a full screen app. I think Android has the same feature, but I don't have a device to test with.
