local comp=require("component")
local thread=require("thread")
local share={comp:{}}

-- DEBUG: 0 INFO: 1 WARN 2 ERROR 3
function log(...)
  local a={...}
  local t=nil
  local m=""
  for i,v in ipairs(a) do
    if i==0 then t=v
    elseif i==1 then m=m..v
    else m=m.." "..v
    end
  end
  -- TODO: add type
  print(m)
end

function setup()
  if not comp.isAvailable("internet") then
    log(2,"Internet component not available.")
  else
    share.comp.inet=comp.internet
    if not share.comp.inet.isHttpEnabled() then
      log(2,"This server didn't allow http access.")
      share.comp.inet=nil
    end
  end
end

function fileExists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

function main()
  if (fileExists("config.json"))
  share.tListener=thread.create(tListener)
end

function tListener()

end

setup()
main()
