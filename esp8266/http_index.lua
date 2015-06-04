-- garage_door_opener.lua
-- Part of nodemcu-httpserver, example.
-- Author: Marcos Kirsch

-- GPIO2
pin = 4

local function pushTheButton(connection, state)
    print(state)
    -- Send back JSON response.
    connection:send("HTTP/1.0 200 OK\r\nContent-Type: application/json\r\nCache-Control: private, no-store\r\n\r\n")
    connection:send('{"error":0, "message":"OK"}')
end

-- http://stackoverflow.com/questions/656199/search-for-an-item-in-a-lua-list
function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

return function (connection, args)
    local valid = Set {"open", "close", "startup", "stepAway", "unibeam"}
    if valid[args.state] then
        pushTheButton(connection, args.state)
    else
        connection:send("HTTP/1.0 400 OK\r\nContent-Type: application/json\r\nCache-Control: private, no-store\r\n\r\n")
        connection:send('{"error":-1, "message":"Bad state"}')
    end
end
