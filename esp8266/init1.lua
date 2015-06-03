-- Begin WiFi configuration

cfg={}
cfg.ssid="HulkBuster"
cfg.pwd="password"
wifi.setmode(wifi.SOFTAP);
wifi.ap.config(cfg)
wifi.sta.connect()

-- End WiFi configuration

-- Compile server code and remove original .lua files.
-- This only happens the first time afer the .lua files are uploaded.

local compileAndRemoveIfNeeded = function(f)
   if file.open(f) then
      file.close()
      print('Compiling:', f)
      node.compile(f)
      file.remove(f)
      collectgarbage()
   end
end

local serverFiles = {'httpserver.lua', 'httpserver-request.lua', 'httpserver-static.lua', 'httpserver-header.lua', 'httpserver-error.lua'}
for i, f in ipairs(serverFiles) do compileAndRemoveIfNeeded(f) end

compileAndRemoveIfNeeded = nil
serverFiles = nil
collectgarbage()

-- Connect to the WiFi access point.
-- Once the device is connected, you may start the HTTP server.

local joinCounter = 0
local joinMaxAttempts = 5
tmr.alarm(0, 3000, 1, function()
   if wifi.ap.getip() == nil and joinCounter < joinMaxAttempts then
      print('Connecting to WiFi Access Point ...')
      joinCounter = joinCounter +1
   else
      if joinCounter == joinMaxAttempts then
         print('Faild to connect to WiFi Access Point.')
      else
         print('IP: ',wifi.ap.getip())
         -- Uncomment to automatically start the server in port 80
         dofile("httpserver.lc")(80)
      end
      tmr.stop(0)
      joinCounter = nil
      joinMaxAttempts = nil
      collectgarbage()
   end

end)

