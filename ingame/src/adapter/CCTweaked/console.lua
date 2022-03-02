local function reset()
  term.clear()
  term.setCursorPos(1, 1)
end

local function log(text)
  print(text)
end

return { reset = reset, log = log }