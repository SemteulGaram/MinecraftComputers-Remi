--Very First install only script
--It will install "gitTrans" which download/upload manager from github code
local GITTRANSURL='https://raw.githubusercontent.com/SemteulGaram/OpenComputers-Remi/master/src/gitTrans.lua'

local comp = require 'component'
local fs = require 'filesystem'
local inet = nil

local function check()
  if not comp.isAvailable('internet') then
    print('Internet component not available. Please insert internet card.')
    return 1
  end
  inet=comp.getPrimary('internet')
  if not inet.isHttpEnabled() then
    print('This server didn\'t allow http access. Please download script manually(via pastebin or wget).')
    return 2
  end
  return 0
end

local function install()
	--Ensure Dir
  fs.makeDirectory('src')

  local req=inet.request(GITTRANSURL)
  local file=io.open("src/gitTrans.lua", "w")
  local byteCount = 1024
  local data=req.read(byteCount)
  while data do
    file:write(data)
    file:flush()
    data=req.read(byteCount)
  end
  file:close()
  return 0
end

print('Remi check...')
local code = check()
if code~=0 then
  print('setup process terminated with error code: '..code)
  return
end

print('Remi install...')
code=install()
if code~=0 then
  print('install process terminated with error code: '..code)
  return
end

print('gitTrans force pulling...')
local gitTrans=require 'src/gitTrans'
code=gitTrans.forcePull()
if code~=0 then
  print('gitTrans.forcePull() process terminated with error code: '..code)
  return
end
print('Remi installation SUCCESS')