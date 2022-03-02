local fs=require('filesystem')
local fileEx={}

function fileEx.exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

return fileEx