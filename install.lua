local URLROOT='https://raw.githubusercontent.com/SemteulGaram/OpenComputers-Remi/master/'

local comp = require 'component'
local inet = nil;

function setup()
  if not comp.isAvailable('internet') then
    print('Internet component not available. Please insert internet card.')
    return 1
  end
  inet = comp.getPrimary('internet')
  if not inet.isHttpEnabled() then
    print('This server didn\'t allow http access. Please download script manually(via pastebin or wget).')
    return 2
  end
  return 0
end

function install()
  local req=inet.request(URLROOT..'dirlist.json')
  local file=io.open("autorun.lua", "w")
  local data=req.read()
  while data do
    file:write(data)
    data=req.read()
  end
  file:close()
  return true
end

if setup()==0 then
  install()
end
