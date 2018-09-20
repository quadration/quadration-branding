local function cols(n)
  local bits = ''
  local nn = n
  for i = 1, 8 do
    bits = (nn % 2 < 1 and '0' or '1')..bits
    nn = nn / 2
  end
  local sci = string.format('%01.4e',2^n)
  sci = sci:sub(1,7)..sci:sub(9,10)
  return string.format('|%03d|%02x|%s|%s|',n,n,bits,sci)
end

local label = '|dec|hx|bytebits|powof2sci|'
local sep = '='
print(label..sep..label)
for i = 0, 127 do
  print(cols(i)..sep..cols(i+128))
end
print(label..sep..label)
