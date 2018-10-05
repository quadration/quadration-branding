local font = {
  ['0'] = {
    2,2,2,2,2,2,2,
    2,1,1,0,1,1,2,
    2,1,1,0,1,1,2,
    2,1,1,0,1,1,2,
    2,2,2,2,2,2,2,
  },
  ['1'] = {
    2,2,2,2,1,0,0,
    0,0,1,2,1,0,0,
    0,0,1,2,1,0,0,
    0,0,1,2,1,0,0,
    2,2,2,2,2,2,2,
  },
  ['2'] = {
    2,2,2,2,2,2,2,
    0,0,0,0,1,1,2,
    2,2,2,2,2,2,2,
    2,1,1,0,0,0,0,
    2,2,2,2,2,2,2,
  },
  ['3'] = {
    2,2,2,2,2,2,2,
    0,0,0,0,1,1,2,
    2,2,2,2,2,2,2,
    0,0,0,0,1,1,2,
    2,2,2,2,2,2,2,
  },
  ['4'] = {
    2,1,1,0,1,1,2,
    2,1,1,0,1,1,2,
    2,2,2,2,2,2,2,
    0,0,0,0,1,1,2,
    0,0,0,0,1,1,2,
  },
  ['5'] = {
    2,2,2,2,2,2,2,
    2,1,1,0,0,0,0,
    2,2,2,2,2,2,2,
    0,0,0,0,1,1,2,
    2,2,2,2,2,2,2,
  },
  ['6'] = {
    2,2,2,2,2,2,2,
    2,1,1,0,0,0,0,
    2,2,2,2,2,2,2,
    2,1,1,0,1,1,2,
    2,2,2,2,2,2,2,
  },
  ['7'] = {
    2,2,2,2,2,2,2,
    0,0,0,0,1,1,2,
    0,0,0,0,1,1,2,
    0,0,0,0,1,1,2,
    0,0,0,0,1,1,2,
  },
  ['8'] = {
    2,2,2,2,2,2,2,
    2,1,1,0,1,1,2,
    2,2,2,2,2,2,2,
    2,1,1,0,1,1,2,
    2,2,2,2,2,2,2,
  },
  ['9'] = {
    2,2,2,2,2,2,2,
    2,1,1,0,1,1,2,
    2,2,2,2,2,2,2,
    0,0,0,0,1,1,2,
    2,2,2,2,2,2,2,
  },
  ['a'] = {
    2,2,2,2,2,2,2,
    2,1,1,0,1,1,2,
    2,2,2,2,2,2,2,
    2,1,1,0,1,1,2,
    2,1,1,0,1,1,2,
  },
  ['b'] = {
    2,1,1,0,0,0,0,
    2,1,1,0,0,0,0,
    2,2,2,2,2,2,2,
    2,1,1,0,1,1,2,
    2,2,2,2,2,2,2,
  },
  ['c'] = {
    2,2,2,2,2,2,2,
    2,1,1,0,0,0,0,
    2,1,1,0,0,0,0,
    2,1,1,0,0,0,0,
    2,2,2,2,2,2,2,
  },
  ['d'] = {
    0,0,0,0,1,1,2,
    0,0,0,0,1,1,2,
    2,2,2,2,2,2,2,
    2,1,1,0,1,1,2,
    2,2,2,2,2,2,2,
  },
  ['e'] = {
    2,2,2,2,2,2,2,
    2,1,1,0,0,0,0,
    2,2,2,2,2,2,2,
    2,1,1,0,0,0,0,
    2,2,2,2,2,2,2,
  },
  ['f'] = {
    2,2,2,2,2,2,2,
    2,1,1,0,0,0,0,
    2,2,2,2,2,2,2,
    2,1,1,0,0,0,0,
    2,1,1,0,0,0,0,
  },
  ['.'] = {
    0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,
    0,0,1,1,1,0,0,
    0,0,2,2,2,0,0,
    0,0,2,2,2,0,0,
  },
  ['|'] = {
    0,0,1,2,1,0,0,
    0,0,1,2,1,0,0,
    0,0,1,2,1,0,0,
    0,0,1,2,1,0,0,
    0,0,1,2,1,0,0,
  },
  ['='] = {
    1,1,1,1,1,1,1,
    2,2,2,2,2,2,2,
    0,0,0,0,0,0,0,
    2,2,2,2,2,2,2,
    1,1,1,1,1,1,1,
  },
}

-- local label = '|dec|hx|bytebits|powof2sci|'
local sep = '='

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

local function row(n)
  return cols(n) .. sep .. cols(n+128)
end

local linecw = (3+2+8+9+5)*2+1
local charw = 7
local charh = 5
local gapw = 1
local gaph = 1
local pxw = (charw + gapw) * linecw + gapw
local pxh = (charh + gaph) * 128 + gaph

local cmd = string.format(
  'convert -size %ix%i -depth 8 gray:- back.png', pxw, pxh)
local outs = io.popen(cmd, 'w')

local bg = string.char(255)
local lfg = string.char(192)
local hfg = string.char(128)

local function linespace()
  for i = 1, pxw * gaph do
    outs:write(bg)
  end
end
local function kernspace()
  for i = 1, gapw do
    outs:write(bg)
  end
end

local function lineout(n)
  local thresh = (n % 8 == 0) and 1 or 2
  local fg = thresh < 2 and hfg or lfg
  local chars = row(n)
  local glyphs = {}
  for c = 1, linecw do
    glyphs[c] = font[chars:sub(c,c)]
  end
  for y = 1, charh do
    kernspace()
    local start = (y - 1) * charw + 1
    for c = 1, linecw do
      local glyph = glyphs[c]
      for x = start, start + charw - 1 do
        outs:write(glyph[x] < thresh and bg or fg)
      end
      kernspace()
    end
  end
end

linespace()
for i = 0, 127 do
  lineout(i)
  linespace()
end
