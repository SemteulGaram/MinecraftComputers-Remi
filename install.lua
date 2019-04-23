local Comp = require("component")
local Inet = nil;

function setup()
  if not Inet.isAvailable() then
    print("Internet component not available. Please insert internet card.")
    return 1
  end
  Inet = Comp.internet
  if not Inet.isHttpEnabled() {
    print("This server didn't allow http access. Please download script manually(via pastebin or wget).")
    return 2
  }
  return 0
end

function install()
  local req = Inet.request("https://raw.githubusercontent.com/SemteulGaram/OpenComputers-Remi/master/src/main/autorun.lua")
  local file = io.open("autorun.lua", "w")
  local data = req.read()
  while data do
    file:write(data)
    data = req.read()
  end
  file:close()
  return true
end

if setup()>0 then
  install()
end