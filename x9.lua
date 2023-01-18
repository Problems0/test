function jsonum()
targetInfo = gg.getTargetInfo()
app = targetInfo.packageName
local utf8 = {}
local bit = {
  data32 = {}
}
do
  do
    for SRD1_5_ = 1, 32 do
      bit.data32[SRD1_5_] = 2 ^ (32 - SRD1_5_)
    end
  end
end
local toby = string.byte
function utf8.charbytes(s, i)
  i = i or 1
  local c = string.byte(s, i)
  if c > 0 and c <= 127 then
    do return 1 end
    return
  end
  if c >= 194 and c <= 223 then
    do return 2 end
    return
  end
  if c >= 224 and c <= 239 then
    do return 3 end
    return
  end
  if c >= 240 and c <= 244 then
    return 4
  end
  return 1
end

local ded
function bit:d2b(arg)
  if arg == nil then
    return
  end
  local tr, c = {}, arg < 0
  if c then
    arg = 0 - arg
  end
  do
    do
      for SRD1_7_ = 1, 32 do
        if arg >= self.data32[SRD1_7_] then
          tr[SRD1_7_] = 1
          arg = arg - self.data32[SRD1_7_]
        else
          tr[SRD1_7_] = 0
        end
      end
    end
  end
  if c then
    tr = self:_bnot(tr)
    tr = self:b2d(tr) + 1
    tr = self:d2b(tr)
  end
  return tr
end

function bit:b2d(arg, neg)
  local nr = 0
  if arg[1] == 1 and neg == true then
    arg = self:_bnot(arg)
    nr = self:b2d(arg) + 1
    nr = 0 - nr
  else
    do
      for SRD1_7_ = 1, 32 do
        if arg[SRD1_7_] == 1 then
          nr = nr + 2 ^ (32 - SRD1_7_)
        end
      end
    end
  end
  return nr
end

function bit:_and(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 and op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_or(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 or op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_xor(a, b)
  local op1 = self:d2b(a)
  if op1 == nil then
    return nil
  end
  local op2 = self:d2b(b)
  if op2 == nil then
    return nil
  end
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == op2[SRD1_9_] then
          r[SRD1_9_] = 0
        else
          r[SRD1_9_] = 1
        end
      end
    end
  end
  return self:b2d(r, true)
end

local switch = {
  [1] = function(s, pos)
    local c1 = toby(s, pos)
    return c1
  end
  ,
  [2] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local int1 = bit:_and(31, c1)
    local int2 = bit:_and(63, c2)
    return bit:_or(bit:_lshift(int1, 6), int2)
  end
  ,
  [3] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local o2 = bit:_or(bit:_lshift(int1, 12), bit:_lshift(int2, 6))
    local dt = bit:_or(o2, int3)
    return dt
  end
  ,
  [4] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local c4 = toby(s, pos + 3)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local int4 = bit:_and(63, c4)
    local o2 = bit:_or(bit:_lshift(int1, 18), bit:_lshift(int2, 12))
    local o3 = bit:_or(o2, bit:_lshift(int3, 6))
    local o4 = bit:_or(o3, int4)
    return o4
  end
  
}
function bit:_bnot(op1)
  local r = {}
  do
    do
      for SRD1_6_ = 1, 32 do
        if op1[SRD1_6_] == 1 then
          r[SRD1_6_] = 0
        else
          r[SRD1_6_] = 1
        end
      end
    end
  end
  return r
end

function bit:_not(a)
  local op1 = self:d2b(a)
  local r = self:_bnot(op1)
  return self:b2d(r, true)
end

function bit:charCodeAt(s)
  local pos, int, H, L = 1, 0, 0, 0
  local slen = string.len(s)
  local allByte = {}
  while pos <= slen do
    local tLen = utf8.charbytes(s, pos)
    if tLen >= 1 and tLen <= 4 then
      if tLen == 4 then
        int = switch[4](s, pos)
        H = math.floor((int - 65536) / 1024) + 55296
        L = (int - 65536) % 1024 + 56320
        table.insert(allByte, H)
        table.insert(allByte, L)
      else
        int = switch[tLen](s, pos)
        table.insert(allByte, int)
      end
    end
    pos = pos + tLen
  end
  return allByte
end

function bit:_rshift(a, n)
  local r = 0
  if a < 0 then
    r = 0 - self:_frshift(0 - a, n)
  elseif a >= 0 then
    r = self:_frshift(a, n)
  end
  return r
end

function bit:_frshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  local left = 32 - n
  if n < 32 and n > 0 then
    do
      for SRD1_9_ = left, 1, -1 do
        r[SRD1_9_ + n] = op1[SRD1_9_]
      end
    end
  end
  return self:b2d(r)
end

function bit:_lshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  if n < 32 and n > 0 then
    do
      for SRD1_8_ = n, 31 do
        r[SRD1_8_ - n + 1] = op1[SRD1_8_ + 1]
      end
    end
  end
  return self:b2d(r, true)
end

function trim(s)
  return s:match("^%s*(.*)"):match("(.-)%s*$")
end

local json = {}
local kind_of = function(obj)
  if type(obj) ~= "table" then
    return type(obj)
  end
  local i = 1
  do
    do
      for SRD1_5_ in pairs(obj) do
        if obj[i] ~= nil then
          i = i + 1
        else
          return "table"
        end
      end
    end
  end
  if i == 1 then
    do return "table" end
    return
  end
  return "array"
end

local escape_str = function(s)
  local in_char = {
    "\\",
    "\"",
    "/",
    "\b",
    "\f",
    "\n",
    "\r",
    "\t"
  }
  local out_char = {
    "\\",
    "\"",
    "/",
    "b",
    "f",
    "n",
    "r",
    "t"
  }
  do
    do
      for SRD1_6_, SRD1_7_ in ipairs(in_char) do
        s = s:gsub(SRD1_7_, "\\" .. out_char[SRD1_6_])
      end
    end
  end
  return s
end

local skip_delim = function(str, pos, delim, err_if_missing)
  pos = pos + #str:match("^%s*", pos)
  if str:sub(pos, pos) ~= delim then
    if err_if_missing then
      error("Esperado " .. delim .. " posição próxima " .. pos)
    end
    return pos, false
  end
  return pos + 1, true
end

local function parse_str_val(str, pos, val)
  val = val or ""
  local early_end_error = "Fim da entrada encontrado durante a análise da string."
  if pos > #str then
    error(early_end_error)
  end
  local c = str:sub(pos, pos)
  if c == "\"" then
    return val, pos + 1
  end
  if c ~= "\\" then
    return parse_str_val(str, pos + 1, val .. c)
  end
  local esc_map = {
    b = "\b",
    f = "\f",
    n = "\n",
    r = "\r",
    t = "\t"
  }
  local nextc = str:sub(pos + 1, pos + 1)
  if not nextc then
    error(early_end_error)
  end
  return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

local parse_num_val = function(str, pos)
  local num_str = str:match("^-?%d+%.?%d*[eE]?[+-]?%d*", pos)
  local val = tonumber(num_str)
  if not val then
    error("Erro ao analisar o número na posição " .. pos .. ".")
  end
  return val, pos + #num_str
end

function json.stringify(obj, as_key)
  local s = {}
  local kind = kind_of(obj)
  if kind == "array" then
    if as_key then
      error("Não é possível codificar array como chave.")
    end
    s[#s + 1] = "["
    do
      do
        for SRD1_7_, SRD1_8_ in ipairs(obj) do
          if SRD1_7_ > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "]"
  elseif kind == "table" then
    if as_key then
      error("Não é possível codificar a tabela como chave.")
    end
    s[#s + 1] = "{"
    do
      do
        for SRD1_7_, SRD1_8_ in pairs(obj) do
          if #s > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_7_, true)
          s[#s + 1] = ":"
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "}"
  else
    if kind == "string" then
      do return "\"" .. escape_str(obj) .. "\"" end
      return
    end
    if kind == "number" then
      if as_key then
        return "\"" .. tostring(obj) .. "\""
      end
      do return tostring(obj) end
      return
    end
    if kind == "boolean" then
      do return tostring(obj) end
      return
    end
    if kind == "nil" then
      do return "null" end
      return
    end
    error("tipo unjsonificável,: " .. kind .. ".")
  end
  return table.concat(s)
end

json.null = {}
function json.parse(str, pos, end_delim)
  pos = pos or 1
  if pos > #str then
    error("Atingiu o fim inesperado da entrada ")
  end
  local pos = pos + #str:match("^%s*", pos)
  local first = str:sub(pos, pos)
  if first == "{" then
    do
      local obj, key, delim_found = {}, true, true
      pos = pos + 1
      while true do
        key, pos = json.parse(str, pos, "}")
        if key == nil then
          return obj, pos
        end
        if not delim_found then
          error("Vírgula faltando entre os itens do objeto.")
        end
        pos = skip_delim(str, pos, ":", true)
        obj[key], pos = json.parse(str, pos)
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "[" then
    do
      local arr, val, delim_found = {}, true, true
      pos = pos + 1
      while true do
        val, pos = json.parse(str, pos, "]")
        if val == nil then
          return arr, pos
        end
        if not delim_found then
          error("Falta vírgula entre os itens do array.")
        end
        arr[#arr + 1] = val
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "\"" then
    do return parse_str_val(str, pos + 1) end
    return
  end
  if first == "-" or first:match("%d") then
    do return parse_num_val(str, pos) end
    return
  end
  if first == end_delim then
    do return nil, pos + 1 end
    return
  end
  do
    local literals = {
      ["true"] = true,
      ["false"] = false,
      null = json.null
    }
    do
      do
        for SRD1_9_, SRD1_10_ in pairs(literals) do
          local lit_end = pos + #SRD1_9_ - 1
          if str:sub(pos, lit_end) == SRD1_9_ then
            return SRD1_10_, lit_end + 1
          end
        end
      end
    end
    local pos_info_str = "position " .. pos .. ": " .. str:sub(pos, pos + 10)
    error("Sintaxe json inválida começando em " .. pos_info_str)
  end
end

function enc(data, b)
  return (data:gsub(".", function(x)
    local r, b = "", x:byte()
    do
      do
        for SRD1_6_ = 8, 1, -1 do
          r = r .. (b % 2 ^ SRD1_6_ - b % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
    if #x < 6 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 6 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (6 - SRD1_5_) or 0)
        end
      end
    end
    return b:sub(c + 1, c + 1)
  end
  ) .. ({
    "",
    "??",
    "?"
  })[#data % 3 + 1]
end

function dec(data, b)
  data = string.gsub(data, "[^" .. b .. "=]", "")
  return (data:gsub(".", function(x)
    if x == "?" then
      return ""
    end
    local r, f = "", b:find(x) - 1
    do
      do
        for SRD1_6_ = 6, 1, -1 do
          r = r .. (f % 2 ^ SRD1_6_ - f % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
    if #x ~= 8 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 8 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (8 - SRD1_5_) or 0)
        end
      end
    end
    return string.char(c)
  end
  ))
end
function rwmem(Address, SizeOrBuffer)
assert(Address ~= nil, "[rwmem]: error, endereço fornecido é nulo.")
_rw = {}
if type(SizeOrBuffer) == "number" then
_ = ""
for _ = 1, SizeOrBuffer do _rw[_] = {address = (Address - 1) + _, flags = gg.TYPE_BYTE} end
for v, __ in ipairs(gg.getValues(_rw)) do
 if __.value == 00 and limit == true then
 return _
 end
_ = _ .. string.format("%02X", __.value & 0xFF)
end
return _
end
Byte = {} SizeOrBuffer:gsub("..", function(x)
Byte[#Byte + 1] = x _rw[#Byte] = {address = (Address - 1) + #Byte, flags = gg.TYPE_BYTE, value = x .. "h"}
end)
gg.setValues(_rw)
end
local function hexdecode(hex)
return (hex:gsub("%x%x", function(digits) return string.char(tonumber(digits, 16)) end))
end
local function hexencode(str)
return (str:gsub(".", function(char) return string.format("%2x", char:byte()) end))
end
function Dec2Hex(nValue)
nHexVal = string.format("%X", nValue);
sHexVal = nHexVal.."";
return sHexVal;
end
function ToInteger(number)
return math.floor(tonumber(number) or error("Não foi possível transmitir '" .. tostring(number) .. "' enumerar.'"))
end

function save(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(data)
  gg.toast("te peguei Lionel Richie!")
end

function save2(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(json.stringify(data))
  gg.toast("te peguei Lionel Richie!")
end

function configjson(data)
  io.open(gg.EXT_STORAGE .. "/config.txt", "w"):write(data)
  gg.toast(data .. [[

copiou, farinha?]])
  print(data, false)
  gg.clearResults()

end

  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7B 0A 20 22 56 65 72 73 69", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado")
    json_2 = true
  end
  if json_2 then
    gg.searchNumber("h 7B 0A 20 22 56 65 72 73", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado")
      print([[

calma barboleta]])
      print("\nou vai ou racha?\n\n")
      os.exit()
    end
  end
  limit = true
  gg.searchNumber("h7B", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1000)
  readedMem = rwmem(r[1].address, 200000)
  configjson(hexdecode(readedMem))
  do
    do
      for SRD1_5_, SRD1_6_ in ipairs(r) do
        r[SRD1_5_].flags = gg.TYPE_FLOAT
        r[SRD1_5_].value = "1000"
      end
    end
  end
gg.setValues(r)
  gg.clearResults()
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/config.txt")
  gg.clearResults()
os.exit()
end
function revhunter()
targetInfo = gg.getTargetInfo()
app = targetInfo.packageName
local utf8 = {}
local bit = {
  data32 = {}
}
do
  do
    for SRD1_5_ = 1, 32 do
      bit.data32[SRD1_5_] = 2 ^ (32 - SRD1_5_)
    end
  end
end
local toby = string.byte
function utf8.charbytes(s, i)
  i = i or 1
  local c = string.byte(s, i)
  if c > 0 and c <= 127 then
    do return 1 end
    return
  end
  if c >= 194 and c <= 223 then
    do return 2 end
    return
  end
  if c >= 224 and c <= 239 then
    do return 3 end
    return
  end
  if c >= 240 and c <= 244 then
    return 4
  end
  return 1
end

local ded
function bit:d2b(arg)
  if arg == nil then
    return
  end
  local tr, c = {}, arg < 0
  if c then
    arg = 0 - arg
  end
  do
    do
      for SRD1_7_ = 1, 32 do
        if arg >= self.data32[SRD1_7_] then
          tr[SRD1_7_] = 1
          arg = arg - self.data32[SRD1_7_]
        else
          tr[SRD1_7_] = 0
        end
      end
    end
  end
  if c then
    tr = self:_bnot(tr)
    tr = self:b2d(tr) + 1
    tr = self:d2b(tr)
  end
  return tr
end

function bit:b2d(arg, neg)
  local nr = 0
  if arg[1] == 1 and neg == true then
    arg = self:_bnot(arg)
    nr = self:b2d(arg) + 1
    nr = 0 - nr
  else
    do
      for SRD1_7_ = 1, 32 do
        if arg[SRD1_7_] == 1 then
          nr = nr + 2 ^ (32 - SRD1_7_)
        end
      end
    end
  end
  return nr
end

function bit:_and(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 and op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_or(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 or op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_xor(a, b)
  local op1 = self:d2b(a)
  if op1 == nil then
    return nil
  end
  local op2 = self:d2b(b)
  if op2 == nil then
    return nil
  end
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == op2[SRD1_9_] then
          r[SRD1_9_] = 0
        else
          r[SRD1_9_] = 1
        end
      end
    end
  end
  return self:b2d(r, true)
end

local switch = {
  [1] = function(s, pos)
    local c1 = toby(s, pos)
    return c1
  end
  ,
  [2] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local int1 = bit:_and(31, c1)
    local int2 = bit:_and(63, c2)
    return bit:_or(bit:_lshift(int1, 6), int2)
  end
  ,
  [3] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local o2 = bit:_or(bit:_lshift(int1, 12), bit:_lshift(int2, 6))
    local dt = bit:_or(o2, int3)
    return dt
  end
  ,
  [4] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local c4 = toby(s, pos + 3)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local int4 = bit:_and(63, c4)
    local o2 = bit:_or(bit:_lshift(int1, 18), bit:_lshift(int2, 12))
    local o3 = bit:_or(o2, bit:_lshift(int3, 6))
    local o4 = bit:_or(o3, int4)
    return o4
  end
  
}
function bit:_bnot(op1)
  local r = {}
  do
    do
      for SRD1_6_ = 1, 32 do
        if op1[SRD1_6_] == 1 then
          r[SRD1_6_] = 0
        else
          r[SRD1_6_] = 1
        end
      end
    end
  end
  return r
end

function bit:_not(a)
  local op1 = self:d2b(a)
  local r = self:_bnot(op1)
  return self:b2d(r, true)
end

function bit:charCodeAt(s)
  local pos, int, H, L = 1, 0, 0, 0
  local slen = string.len(s)
  local allByte = {}
  while pos <= slen do
    local tLen = utf8.charbytes(s, pos)
    if tLen >= 1 and tLen <= 4 then
      if tLen == 4 then
        int = switch[4](s, pos)
        H = math.floor((int - 65536) / 1024) + 55296
        L = (int - 65536) % 1024 + 56320
        table.insert(allByte, H)
        table.insert(allByte, L)
      else
        int = switch[tLen](s, pos)
        table.insert(allByte, int)
      end
    end
    pos = pos + tLen
  end
  return allByte
end

function bit:_rshift(a, n)
  local r = 0
  if a < 0 then
    r = 0 - self:_frshift(0 - a, n)
  elseif a >= 0 then
    r = self:_frshift(a, n)
  end
  return r
end

function bit:_frshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  local left = 32 - n
  if n < 32 and n > 0 then
    do
      for SRD1_9_ = left, 1, -1 do
        r[SRD1_9_ + n] = op1[SRD1_9_]
      end
    end
  end
  return self:b2d(r)
end

function bit:_lshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  if n < 32 and n > 0 then
    do
      for SRD1_8_ = n, 31 do
        r[SRD1_8_ - n + 1] = op1[SRD1_8_ + 1]
      end
    end
  end
  return self:b2d(r, true)
end

function trim(s)
  return s:match("^%s*(.*)"):match("(.-)%s*$")
end

local json = {}
local kind_of = function(obj)
  if type(obj) ~= "table" then
    return type(obj)
  end
  local i = 1
  do
    do
      for SRD1_5_ in pairs(obj) do
        if obj[i] ~= nil then
          i = i + 1
        else
          return "table"
        end
      end
    end
  end
  if i == 1 then
    do return "table" end
    return
  end
  return "array"
end

local escape_str = function(s)
  local in_char = {
    "\\",
    "\"",
    "/",
    "\b",
    "\f",
    "\n",
    "\r",
    "\t"
  }
  local out_char = {
    "\\",
    "\"",
    "/",
    "b",
    "f",
    "n",
    "r",
    "t"
  }
  do
    do
      for SRD1_6_, SRD1_7_ in ipairs(in_char) do
        s = s:gsub(SRD1_7_, "\\" .. out_char[SRD1_6_])
      end
    end
  end
  return s
end

local skip_delim = function(str, pos, delim, err_if_missing)
  pos = pos + #str:match("^%s*", pos)
  if str:sub(pos, pos) ~= delim then
    if err_if_missing then
      error("Esperado " .. delim .. " posição próxima " .. pos)
    end
    return pos, false
  end
  return pos + 1, true
end

local function parse_str_val(str, pos, val)
  val = val or ""
  local early_end_error = "Fim da entrada encontrado durante a análise da string."
  if pos > #str then
    error(early_end_error)
  end
  local c = str:sub(pos, pos)
  if c == "\"" then
    return val, pos + 1
  end
  if c ~= "\\" then
    return parse_str_val(str, pos + 1, val .. c)
  end
  local esc_map = {
    b = "\b",
    f = "\f",
    n = "\n",
    r = "\r",
    t = "\t"
  }
  local nextc = str:sub(pos + 1, pos + 1)
  if not nextc then
    error(early_end_error)
  end
  return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

local parse_num_val = function(str, pos)
  local num_str = str:match("^-?%d+%.?%d*[eE]?[+-]?%d*", pos)
  local val = tonumber(num_str)
  if not val then
    error("Erro ao analisar o número na posição " .. pos .. ".")
  end
  return val, pos + #num_str
end

function json.stringify(obj, as_key)
  local s = {}
  local kind = kind_of(obj)
  if kind == "array" then
    if as_key then
      error("Não é possível codificar array como chave.")
    end
    s[#s + 1] = "["
    do
      do
        for SRD1_7_, SRD1_8_ in ipairs(obj) do
          if SRD1_7_ > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "]"
  elseif kind == "table" then
    if as_key then
      error("Não é possível codificar a tabela como chave.")
    end
    s[#s + 1] = "{"
    do
      do
        for SRD1_7_, SRD1_8_ in pairs(obj) do
          if #s > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_7_, true)
          s[#s + 1] = ":"
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "}"
  else
    if kind == "string" then
      do return "\"" .. escape_str(obj) .. "\"" end
      return
    end
    if kind == "number" then
      if as_key then
        return "\"" .. tostring(obj) .. "\""
      end
      do return tostring(obj) end
      return
    end
    if kind == "boolean" then
      do return tostring(obj) end
      return
    end
    if kind == "nil" then
      do return "null" end
      return
    end
    error("tipo unjsonificável,: " .. kind .. ".")
  end
  return table.concat(s)
end

json.null = {}
function json.parse(str, pos, end_delim)
  pos = pos or 1
  if pos > #str then
    error("Atingiu o fim inesperado da entrada ")
  end
  local pos = pos + #str:match("^%s*", pos)
  local first = str:sub(pos, pos)
  if first == "{" then
    do
      local obj, key, delim_found = {}, true, true
      pos = pos + 1
      while true do
        key, pos = json.parse(str, pos, "}")
        if key == nil then
          return obj, pos
        end
        if not delim_found then
          error("Vírgula faltando entre os itens do objeto.")
        end
        pos = skip_delim(str, pos, ":", true)
        obj[key], pos = json.parse(str, pos)
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "[" then
    do
      local arr, val, delim_found = {}, true, true
      pos = pos + 1
      while true do
        val, pos = json.parse(str, pos, "]")
        if val == nil then
          return arr, pos
        end
        if not delim_found then
          error("Falta vírgula entre os itens do array.")
        end
        arr[#arr + 1] = val
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "\"" then
    do return parse_str_val(str, pos + 1) end
    return
  end
  if first == "-" or first:match("%d") then
    do return parse_num_val(str, pos) end
    return
  end
  if first == end_delim then
    do return nil, pos + 1 end
    return
  end
  do
    local literals = {
      ["true"] = true,
      ["false"] = false,
      null = json.null
    }
    do
      do
        for SRD1_9_, SRD1_10_ in pairs(literals) do
          local lit_end = pos + #SRD1_9_ - 1
          if str:sub(pos, lit_end) == SRD1_9_ then
            return SRD1_10_, lit_end + 1
          end
        end
      end
    end
    local pos_info_str = "position " .. pos .. ": " .. str:sub(pos, pos + 10)
    error("Sintaxe json inválida começando em " .. pos_info_str)
  end
end

function enc(data, b)
  return (data:gsub(".", function(x)
    local r, b = "", x:byte()
    do
      do
        for SRD1_6_ = 8, 1, -1 do
          r = r .. (b % 2 ^ SRD1_6_ - b % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
    if #x < 6 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 6 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (6 - SRD1_5_) or 0)
        end
      end
    end
    return b:sub(c + 1, c + 1)
  end
  ) .. ({
    "",
    "??",
    "?"
  })[#data % 3 + 1]
end

function dec(data, b)
  data = string.gsub(data, "[^" .. b .. "=]", "")
  return (data:gsub(".", function(x)
    if x == "?" then
      return ""
    end
    local r, f = "", b:find(x) - 1
    do
      do
        for SRD1_6_ = 6, 1, -1 do
          r = r .. (f % 2 ^ SRD1_6_ - f % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
    if #x ~= 8 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 8 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (8 - SRD1_5_) or 0)
        end
      end
    end
    return string.char(c)
  end
  ))
end
function rwmem(Address, SizeOrBuffer)
assert(Address ~= nil, "[rwmem]: error, endereço fornecido é nulo.")
_rw = {}
if type(SizeOrBuffer) == "number" then
_ = ""
for _ = 1, SizeOrBuffer do _rw[_] = {address = (Address - 1) + _, flags = gg.TYPE_BYTE} end
for v, __ in ipairs(gg.getValues(_rw)) do
 if __.value == 00 and limit == true then
 return _
 end
_ = _ .. string.format("%02X", __.value & 0xFF)
end
return _
end
Byte = {} SizeOrBuffer:gsub("..", function(x)
Byte[#Byte + 1] = x _rw[#Byte] = {address = (Address - 1) + #Byte, flags = gg.TYPE_BYTE, value = x .. "h"}
end)
gg.setValues(_rw)
end
local function hexdecode(hex)
return (hex:gsub("%x%x", function(digits) return string.char(tonumber(digits, 16)) end))
end
local function hexencode(str)
return (str:gsub(".", function(char) return string.format("%2x", char:byte()) end))
end
function Dec2Hex(nValue)
nHexVal = string.format("%X", nValue);
sHexVal = nHexVal.."";
return sHexVal;
end
function ToInteger(number)
return math.floor(tonumber(number) or error("Não foi possível transmitir '" .. tostring(number) .. "' enumerar.'"))
end

function save(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(data)
  gg.toast("te peguei Lionel Richie!")
end

function save2(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(json.stringify(data))
  gg.toast("te peguei Lionel Richie!")
end

function configjson(data)
  io.open(gg.EXT_STORAGE .. "/config.txt", "w"):write(data)
  gg.toast(data .. [[

copiou, farinha?]])
  print(data, false)
  gg.clearResults()

end

  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7B 0A 20 20 20 20 22 56 65 72 73 69 6F 6E", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado")
    json_2 = true
  end
  if json_2 then
    gg.searchNumber("h 7B 0A 20 20 20 20 22 56 65 72 73 69", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado")
      print([[

calma barboleta]])
      print("\nou vai ou racha?\n\n")
      os.exit()
    end
  end
  limit = true
  gg.searchNumber("h7B", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1000)
  readedMem = rwmem(r[1].address, 200000)
  configjson(hexdecode(readedMem))
  do
    do
      for SRD1_5_, SRD1_6_ in ipairs(r) do
        r[SRD1_5_].flags = gg.TYPE_FLOAT
        r[SRD1_5_].value = "1000"
      end
    end
  end
gg.setValues(r)
  gg.clearResults()
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/config.txt")
  gg.clearResults()
os.exit()
end
function socksliteP()
targetInfo = gg.getTargetInfo()
app = targetInfo.packageName
local utf8 = {}
local bit = {
  data32 = {}
}
do
  do
    for SRD1_5_ = 1, 32 do
      bit.data32[SRD1_5_] = 2 ^ (32 - SRD1_5_)
    end
  end
end
local toby = string.byte
function utf8.charbytes(s, i)
  i = i or 1
  local c = string.byte(s, i)
  if c > 0 and c <= 127 then
    do return 1 end
    return
  end
  if c >= 194 and c <= 223 then
    do return 2 end
    return
  end
  if c >= 224 and c <= 239 then
    do return 3 end
    return
  end
  if c >= 240 and c <= 244 then
    return 4
  end
  return 1
end

local ded
function bit:d2b(arg)
  if arg == nil then
    return
  end
  local tr, c = {}, arg < 0
  if c then
    arg = 0 - arg
  end
  do
    do
      for SRD1_7_ = 1, 32 do
        if arg >= self.data32[SRD1_7_] then
          tr[SRD1_7_] = 1
          arg = arg - self.data32[SRD1_7_]
        else
          tr[SRD1_7_] = 0
        end
      end
    end
  end
  if c then
    tr = self:_bnot(tr)
    tr = self:b2d(tr) + 1
    tr = self:d2b(tr)
  end
  return tr
end

function bit:b2d(arg, neg)
  local nr = 0
  if arg[1] == 1 and neg == true then
    arg = self:_bnot(arg)
    nr = self:b2d(arg) + 1
    nr = 0 - nr
  else
    do
      for SRD1_7_ = 1, 32 do
        if arg[SRD1_7_] == 1 then
          nr = nr + 2 ^ (32 - SRD1_7_)
        end
      end
    end
  end
  return nr
end

function bit:_and(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 and op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_or(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 or op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_xor(a, b)
  local op1 = self:d2b(a)
  if op1 == nil then
    return nil
  end
  local op2 = self:d2b(b)
  if op2 == nil then
    return nil
  end
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == op2[SRD1_9_] then
          r[SRD1_9_] = 0
        else
          r[SRD1_9_] = 1
        end
      end
    end
  end
  return self:b2d(r, true)
end

local switch = {
  [1] = function(s, pos)
    local c1 = toby(s, pos)
    return c1
  end
  ,
  [2] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local int1 = bit:_and(31, c1)
    local int2 = bit:_and(63, c2)
    return bit:_or(bit:_lshift(int1, 6), int2)
  end
  ,
  [3] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local o2 = bit:_or(bit:_lshift(int1, 12), bit:_lshift(int2, 6))
    local dt = bit:_or(o2, int3)
    return dt
  end
  ,
  [4] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local c4 = toby(s, pos + 3)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local int4 = bit:_and(63, c4)
    local o2 = bit:_or(bit:_lshift(int1, 18), bit:_lshift(int2, 12))
    local o3 = bit:_or(o2, bit:_lshift(int3, 6))
    local o4 = bit:_or(o3, int4)
    return o4
  end
  
}
function bit:_bnot(op1)
  local r = {}
  do
    do
      for SRD1_6_ = 1, 32 do
        if op1[SRD1_6_] == 1 then
          r[SRD1_6_] = 0
        else
          r[SRD1_6_] = 1
        end
      end
    end
  end
  return r
end

function bit:_not(a)
  local op1 = self:d2b(a)
  local r = self:_bnot(op1)
  return self:b2d(r, true)
end

function bit:charCodeAt(s)
  local pos, int, H, L = 1, 0, 0, 0
  local slen = string.len(s)
  local allByte = {}
  while pos <= slen do
    local tLen = utf8.charbytes(s, pos)
    if tLen >= 1 and tLen <= 4 then
      if tLen == 4 then
        int = switch[4](s, pos)
        H = math.floor((int - 65536) / 1024) + 55296
        L = (int - 65536) % 1024 + 56320
        table.insert(allByte, H)
        table.insert(allByte, L)
      else
        int = switch[tLen](s, pos)
        table.insert(allByte, int)
      end
    end
    pos = pos + tLen
  end
  return allByte
end

function bit:_rshift(a, n)
  local r = 0
  if a < 0 then
    r = 0 - self:_frshift(0 - a, n)
  elseif a >= 0 then
    r = self:_frshift(a, n)
  end
  return r
end

function bit:_frshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  local left = 32 - n
  if n < 32 and n > 0 then
    do
      for SRD1_9_ = left, 1, -1 do
        r[SRD1_9_ + n] = op1[SRD1_9_]
      end
    end
  end
  return self:b2d(r)
end

function bit:_lshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  if n < 32 and n > 0 then
    do
      for SRD1_8_ = n, 31 do
        r[SRD1_8_ - n + 1] = op1[SRD1_8_ + 1]
      end
    end
  end
  return self:b2d(r, true)
end

function trim(s)
  return s:match("^%s*(.*)"):match("(.-)%s*$")
end

local json = {}
local kind_of = function(obj)
  if type(obj) ~= "table" then
    return type(obj)
  end
  local i = 1
  do
    do
      for SRD1_5_ in pairs(obj) do
        if obj[i] ~= nil then
          i = i + 1
        else
          return "table"
        end
      end
    end
  end
  if i == 1 then
    do return "table" end
    return
  end
  return "array"
end

local escape_str = function(s)
  local in_char = {
    "\\",
    "\"",
    "/",
    "\b",
    "\f",
    "\n",
    "\r",
    "\t"
  }
  local out_char = {
    "\\",
    "\"",
    "/",
    "b",
    "f",
    "n",
    "r",
    "t"
  }
  do
    do
      for SRD1_6_, SRD1_7_ in ipairs(in_char) do
        s = s:gsub(SRD1_7_, "\\" .. out_char[SRD1_6_])
      end
    end
  end
  return s
end

local skip_delim = function(str, pos, delim, err_if_missing)
  pos = pos + #str:match("^%s*", pos)
  if str:sub(pos, pos) ~= delim then
    if err_if_missing then
      error("Esperado " .. delim .. " posição próxima " .. pos)
    end
    return pos, false
  end
  return pos + 1, true
end

local function parse_str_val(str, pos, val)
  val = val or ""
  local early_end_error = "Fim da entrada encontrado durante a análise da string."
  if pos > #str then
    error(early_end_error)
  end
  local c = str:sub(pos, pos)
  if c == "\"" then
    return val, pos + 1
  end
  if c ~= "\\" then
    return parse_str_val(str, pos + 1, val .. c)
  end
  local esc_map = {
    b = "\b",
    f = "\f",
    n = "\n",
    r = "\r",
    t = "\t"
  }
  local nextc = str:sub(pos + 1, pos + 1)
  if not nextc then
    error(early_end_error)
  end
  return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

local parse_num_val = function(str, pos)
  local num_str = str:match("^-?%d+%.?%d*[eE]?[+-]?%d*", pos)
  local val = tonumber(num_str)
  if not val then
    error("Erro ao analisar o número na posição " .. pos .. ".")
  end
  return val, pos + #num_str
end

function json.stringify(obj, as_key)
  local s = {}
  local kind = kind_of(obj)
  if kind == "array" then
    if as_key then
      error("Não é possível codificar array como chave.")
    end
    s[#s + 1] = "["
    do
      do
        for SRD1_7_, SRD1_8_ in ipairs(obj) do
          if SRD1_7_ > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "]"
  elseif kind == "table" then
    if as_key then
      error("Não é possível codificar a tabela como chave.")
    end
    s[#s + 1] = "{"
    do
      do
        for SRD1_7_, SRD1_8_ in pairs(obj) do
          if #s > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_7_, true)
          s[#s + 1] = ":"
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "}"
  else
    if kind == "string" then
      do return "\"" .. escape_str(obj) .. "\"" end
      return
    end
    if kind == "number" then
      if as_key then
        return "\"" .. tostring(obj) .. "\""
      end
      do return tostring(obj) end
      return
    end
    if kind == "boolean" then
      do return tostring(obj) end
      return
    end
    if kind == "nil" then
      do return "null" end
      return
    end
    error("tipo unjsonificável,: " .. kind .. ".")
  end
  return table.concat(s)
end

json.null = {}
function json.parse(str, pos, end_delim)
  pos = pos or 1
  if pos > #str then
    error("Atingiu o fim inesperado da entrada ")
  end
  local pos = pos + #str:match("^%s*", pos)
  local first = str:sub(pos, pos)
  if first == "{" then
    do
      local obj, key, delim_found = {}, true, true
      pos = pos + 1
      while true do
        key, pos = json.parse(str, pos, "}")
        if key == nil then
          return obj, pos
        end
        if not delim_found then
          error("Vírgula faltando entre os itens do objeto.")
        end
        pos = skip_delim(str, pos, ":", true)
        obj[key], pos = json.parse(str, pos)
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "[" then
    do
      local arr, val, delim_found = {}, true, true
      pos = pos + 1
      while true do
        val, pos = json.parse(str, pos, "]")
        if val == nil then
          return arr, pos
        end
        if not delim_found then
          error("Falta vírgula entre os itens do array.")
        end
        arr[#arr + 1] = val
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "\"" then
    do return parse_str_val(str, pos + 1) end
    return
  end
  if first == "-" or first:match("%d") then
    do return parse_num_val(str, pos) end
    return
  end
  if first == end_delim then
    do return nil, pos + 1 end
    return
  end
  do
    local literals = {
      ["true"] = true,
      ["false"] = false,
      null = json.null
    }
    do
      do
        for SRD1_9_, SRD1_10_ in pairs(literals) do
          local lit_end = pos + #SRD1_9_ - 1
          if str:sub(pos, lit_end) == SRD1_9_ then
            return SRD1_10_, lit_end + 1
          end
        end
      end
    end
    local pos_info_str = "position " .. pos .. ": " .. str:sub(pos, pos + 10)
    error("Sintaxe json inválida começando em " .. pos_info_str)
  end
end

function enc(data, b)
  return (data:gsub(".", function(x)
    local r, b = "", x:byte()
    do
      do
        for SRD1_6_ = 8, 1, -1 do
          r = r .. (b % 2 ^ SRD1_6_ - b % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
    if #x < 6 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 6 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (6 - SRD1_5_) or 0)
        end
      end
    end
    return b:sub(c + 1, c + 1)
  end
  ) .. ({
    "",
    "??",
    "?"
  })[#data % 3 + 1]
end

function dec(data, b)
  data = string.gsub(data, "[^" .. b .. "=]", "")
  return (data:gsub(".", function(x)
    if x == "?" then
      return ""
    end
    local r, f = "", b:find(x) - 1
    do
      do
        for SRD1_6_ = 6, 1, -1 do
          r = r .. (f % 2 ^ SRD1_6_ - f % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
    if #x ~= 8 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 8 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (8 - SRD1_5_) or 0)
        end
      end
    end
    return string.char(c)
  end
  ))
end
function rwmem(Address, SizeOrBuffer)
assert(Address ~= nil, "[rwmem]: error, endereço fornecido é nulo.")
_rw = {}
if type(SizeOrBuffer) == "number" then
_ = ""
for _ = 1, SizeOrBuffer do _rw[_] = {address = (Address - 1) + _, flags = gg.TYPE_BYTE} end
for v, __ in ipairs(gg.getValues(_rw)) do
 if __.value == 00 and limit == true then
 return _
 end
_ = _ .. string.format("%02X", __.value & 0xFF)
end
return _
end
Byte = {} SizeOrBuffer:gsub("..", function(x)
Byte[#Byte + 1] = x _rw[#Byte] = {address = (Address - 1) + #Byte, flags = gg.TYPE_BYTE, value = x .. "h"}
end)
gg.setValues(_rw)
end
local function hexdecode(hex)
return (hex:gsub("%x%x", function(digits) return string.char(tonumber(digits, 16)) end))
end
local function hexencode(str)
return (str:gsub(".", function(char) return string.format("%2x", char:byte()) end))
end
function Dec2Hex(nValue)
nHexVal = string.format("%X", nValue);
sHexVal = nHexVal.."";
return sHexVal;
end
function ToInteger(number)
return math.floor(tonumber(number) or error("Não foi possível transmitir '" .. tostring(number) .. "' enumerar.'"))
end

function save(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(data)
  gg.toast("te peguei Lionel Richie!")
end

function save2(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(json.stringify(data))
  gg.toast("te peguei Lionel Richie!")
end

function configjson(data)
  io.open(gg.EXT_STORAGE .. "/config.txt", "w"):write(data)
  gg.toast(data .. [[

copiou, farinha?]])
  print(data, false)
  gg.clearResults()

end

  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7B 09 22 56 65 72 73 69 6F 6E 22 3A 20 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado")
    json_2 = true
  end
  if json_2 then
  gg.searchNumber("h 7B 09 22 56 65 72 73 69", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado")
      print([[

calma barboleta]])
      print("\nou vai ou racha?\n\n")
      os.exit()
    end
  end
  limit = true
  gg.searchNumber("h7B", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1000)
  readedMem = rwmem(r[1].address, 200000)
  configjson(hexdecode(readedMem))
  do
    do
      for SRD1_5_, SRD1_6_ in ipairs(r) do
        r[SRD1_5_].flags = gg.TYPE_FLOAT
        r[SRD1_5_].value = "1000"
      end
    end
  end
gg.setValues(r)
  gg.clearResults()
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/config.txt")
  gg.clearResults()
os.exit()
end
x9ok = 1
function x9on()
while (true) do
if gg.isVisible(true) then 
x9A= 1
gg.clearResults()
gg.setVisible(false) 
end

x9B = 1
function x9B()
menu = gg.choice({
" 💉 x9 HTTP Injector",
" 🇧🇷  x9 de Aplicativos",
" 🌐  x9 HTTP Custom",
" 🐝  x9 Payload",
" 🦋  x9 Usuário e Senha SSH",
" 🐱  x9 V2ray",
" 👀  x9 Dump",
" ❌  Sair, tenho medo "},nil, (_G["os"]["date"]([[
Versão 2.0 x9.lua
Hoje é %d/%m/%Y 
São %H:%M:%S

☠️  Raj, escolhe uma carta:]])))
 if menu == nil then x9P() end
 if menu == 1 then ehi() end
 if menu == 2 then x9C() end
 if menu == 3 then hc() end
 if menu == 4 then Payload() end
 if menu == 5 then login() end
 if menu == 6 then V2Ray() end
 if menu == 7 then Dump() end
 if menu == 8 then EXIT() end
 x9A = -1
end

function ehi()

limit = true
targetInfo = gg.getTargetInfo()
app = targetInfo.packageName
local utf8 = {}
local bit = {
  data32 = {}
}
do
  do
    for SRD1_5_ = 1, 32 do
      bit.data32[SRD1_5_] = 2 ^ (32 - SRD1_5_)
    end
  end
end
local toby = string.byte
function utf8.charbytes(s, i)
  i = i or 1
  local c = string.byte(s, i)
  if c > 0 and c <= 127 then
    do return 1 end
    return
  end
  if c >= 194 and c <= 223 then
    do return 2 end
    return
  end
  if c >= 224 and c <= 239 then
    do return 3 end
    return
  end
  if c >= 240 and c <= 244 then
    return 4
  end
  return 1
end

local ded
function bit:d2b(arg)
  if arg == nil then
    return
  end
  local tr, c = {}, arg < 0
  if c then
    arg = 0 - arg
  end
  do
    do
      for SRD1_7_ = 1, 32 do
        if arg >= self.data32[SRD1_7_] then
          tr[SRD1_7_] = 1
          arg = arg - self.data32[SRD1_7_]
        else
          tr[SRD1_7_] = 0
        end
      end
    end
  end
  if c then
    tr = self:_bnot(tr)
    tr = self:b2d(tr) + 1
    tr = self:d2b(tr)
  end
  return tr
end

function bit:b2d(arg, neg)
  local nr = 0
  if arg[1] == 1 and neg == true then
    arg = self:_bnot(arg)
    nr = self:b2d(arg) + 1
    nr = 0 - nr
  else
    do
      for SRD1_7_ = 1, 32 do
        if arg[SRD1_7_] == 1 then
          nr = nr + 2 ^ (32 - SRD1_7_)
        end
      end
    end
  end
  return nr
end

function bit:_and(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 and op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_or(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 or op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_xor(a, b)
  local op1 = self:d2b(a)
  if op1 == nil then
    return nil
  end
  local op2 = self:d2b(b)
  if op2 == nil then
    return nil
  end
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == op2[SRD1_9_] then
          r[SRD1_9_] = 0
        else
          r[SRD1_9_] = 1
        end
      end
    end
  end
  return self:b2d(r, true)
end

local switch = {
  [1] = function(s, pos)
    local c1 = toby(s, pos)
    return c1
  end
  ,
  [2] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local int1 = bit:_and(31, c1)
    local int2 = bit:_and(63, c2)
    return bit:_or(bit:_lshift(int1, 6), int2)
  end
  ,
  [3] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local o2 = bit:_or(bit:_lshift(int1, 12), bit:_lshift(int2, 6))
    local dt = bit:_or(o2, int3)
    return dt
  end
  ,
  [4] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local c4 = toby(s, pos + 3)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local int4 = bit:_and(63, c4)
    local o2 = bit:_or(bit:_lshift(int1, 18), bit:_lshift(int2, 12))
    local o3 = bit:_or(o2, bit:_lshift(int3, 6))
    local o4 = bit:_or(o3, int4)
    return o4
  end
  
}
function bit:_bnot(op1)
  local r = {}
  do
    do
      for SRD1_6_ = 1, 32 do
        if op1[SRD1_6_] == 1 then
          r[SRD1_6_] = 0
        else
          r[SRD1_6_] = 1
        end
      end
    end
  end
  return r
end

function bit:_not(a)
  local op1 = self:d2b(a)
  local r = self:_bnot(op1)
  return self:b2d(r, true)
end

function bit:charCodeAt(s)
  local pos, int, H, L = 1, 0, 0, 0
  local slen = string.len(s)
  local allByte = {}
  while pos <= slen do
    local tLen = utf8.charbytes(s, pos)
    if tLen >= 1 and tLen <= 4 then
      if tLen == 4 then
        int = switch[4](s, pos)
        H = math.floor((int - 65536) / 1024) + 55296
        L = (int - 65536) % 1024 + 56320
        table.insert(allByte, H)
        table.insert(allByte, L)
      else
        int = switch[tLen](s, pos)
        table.insert(allByte, int)
      end
    end
    pos = pos + tLen
  end
  return allByte
end

function bit:_rshift(a, n)
  local r = 0
  if a < 0 then
    r = 0 - self:_frshift(0 - a, n)
  elseif a >= 0 then
    r = self:_frshift(a, n)
  end
  return r
end

function bit:_frshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  local left = 32 - n
  if n < 32 and n > 0 then
    do
      for SRD1_9_ = left, 1, -1 do
        r[SRD1_9_ + n] = op1[SRD1_9_]
      end
    end
  end
  return self:b2d(r)
end

function bit:_lshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  if n < 32 and n > 0 then
    do
      for SRD1_8_ = n, 31 do
        r[SRD1_8_ - n + 1] = op1[SRD1_8_ + 1]
      end
    end
  end
  return self:b2d(r, true)
end

function trim(s)
  return s:match("^%s*(.*)"):match("(.-)%s*$")
end

local json = {}
local kind_of = function(obj)
  if type(obj) ~= "table" then
    return type(obj)
  end
  local i = 1
  do
    do
      for SRD1_5_ in pairs(obj) do
        if obj[i] ~= nil then
          i = i + 1
        else
          return "table"
        end
      end
    end
  end
  if i == 1 then
    do return "table" end
    return
  end
  return "array"
end

local escape_str = function(s)
  local in_char = {
    "\\",
    "\"",
    "/",
    "\b",
    "\f",
    "\n",
    "\r",
    "\t"
  }
  local out_char = {
    "\\",
    "\"",
    "/",
    "b",
    "f",
    "n",
    "r",
    "t"
  }
  do
    do
      for SRD1_6_, SRD1_7_ in ipairs(in_char) do
        s = s:gsub(SRD1_7_, "\\" .. out_char[SRD1_6_])
      end
    end
  end
  return s
end

local skip_delim = function(str, pos, delim, err_if_missing)
  pos = pos + #str:match("^%s*", pos)
  if str:sub(pos, pos) ~= delim then
    if err_if_missing then
      error("Esperado " .. delim .. " posição próxima " .. pos)
    end
    return pos, false
  end
  return pos + 1, true
end

local function parse_str_val(str, pos, val)
  val = val or ""
  local early_end_error = "Fim da entrada encontrado durante a análise da string."
  if pos > #str then
    error(early_end_error)
  end
  local c = str:sub(pos, pos)
  if c == "\"" then
    return val, pos + 1
  end
  if c ~= "\\" then
    return parse_str_val(str, pos + 1, val .. c)
  end
  local esc_map = {
    b = "\b",
    f = "\f",
    n = "\n",
    r = "\r",
    t = "\t"
  }
  local nextc = str:sub(pos + 1, pos + 1)
  if not nextc then
    error(early_end_error)
  end
  return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

local parse_num_val = function(str, pos)
  local num_str = str:match("^-?%d+%.?%d*[eE]?[+-]?%d*", pos)
  local val = tonumber(num_str)
  if not val then
    error("Erro ao analisar o número na posição " .. pos .. ".")
  end
  return val, pos + #num_str
end

function json.stringify(obj, as_key)
  local s = {}
  local kind = kind_of(obj)
  if kind == "array" then
    if as_key then
      error("Não é possível codificar array como chave.")
    end
    s[#s + 1] = "["
    do
      do
        for SRD1_7_, SRD1_8_ in ipairs(obj) do
          if SRD1_7_ > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "]"
  elseif kind == "table" then
    if as_key then
      error("Não é possível codificar a tabela como chave.")
    end
    s[#s + 1] = "{"
    do
      do
        for SRD1_7_, SRD1_8_ in pairs(obj) do
          if #s > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_7_, true)
          s[#s + 1] = ":"
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "}"
  else
    if kind == "string" then
      do return "\"" .. escape_str(obj) .. "\"" end
      return
    end
    if kind == "number" then
      if as_key then
        return "\"" .. tostring(obj) .. "\""
      end
      do return tostring(obj) end
      return
    end
    if kind == "boolean" then
      do return tostring(obj) end
      return
    end
    if kind == "nil" then
      do return "null" end
      return
    end
    error("tipo unjsonificável,: " .. kind .. ".")
  end
  return table.concat(s)
end

json.null = {}
function json.parse(str, pos, end_delim)
  pos = pos or 1
  if pos > #str then
    error("Atingiu o fim inesperado da entrada ")
  end
  local pos = pos + #str:match("^%s*", pos)
  local first = str:sub(pos, pos)
  if first == "{" then
    do
      local obj, key, delim_found = {}, true, true
      pos = pos + 1
      while true do
        key, pos = json.parse(str, pos, "}")
        if key == nil then
          return obj, pos
        end
        if not delim_found then
          error("Vírgula faltando entre os itens do objeto.")
        end
        pos = skip_delim(str, pos, ":", true)
        obj[key], pos = json.parse(str, pos)
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "[" then
    do
      local arr, val, delim_found = {}, true, true
      pos = pos + 1
      while true do
        val, pos = json.parse(str, pos, "]")
        if val == nil then
          return arr, pos
        end
        if not delim_found then
          error("Falta vírgula entre os itens do array.")
        end
        arr[#arr + 1] = val
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "\"" then
    do return parse_str_val(str, pos + 1) end
    return
  end
  if first == "-" or first:match("%d") then
    do return parse_num_val(str, pos) end
    return
  end
  if first == end_delim then
    do return nil, pos + 1 end
    return
  end
  do
    local literals = {
      ["true"] = true,
      ["false"] = false,
      null = json.null
    }
    do
      do
        for SRD1_9_, SRD1_10_ in pairs(literals) do
          local lit_end = pos + #SRD1_9_ - 1
          if str:sub(pos, lit_end) == SRD1_9_ then
            return SRD1_10_, lit_end + 1
          end
        end
      end
    end
    local pos_info_str = "position " .. pos .. ": " .. str:sub(pos, pos + 10)
    error("Sintaxe json inválida começando em " .. pos_info_str)
  end
end

function enc(data, b)
  return (data:gsub(".", function(x)
    local r, b = "", x:byte()
    do
      do
        for SRD1_6_ = 8, 1, -1 do
          r = r .. (b % 2 ^ SRD1_6_ - b % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
    if #x < 6 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 6 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (6 - SRD1_5_) or 0)
        end
      end
    end
    return b:sub(c + 1, c + 1)
  end
  ) .. ({
    "",
    "??",
    "?"
  })[#data % 3 + 1]
end

function dec(data, b)
  data = string.gsub(data, "[^" .. b .. "=]", "")
  return (data:gsub(".", function(x)
    if x == "?" then
      return ""
    end
    local r, f = "", b:find(x) - 1
    do
      do
        for SRD1_6_ = 6, 1, -1 do
          r = r .. (f % 2 ^ SRD1_6_ - f % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
    if #x ~= 8 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 8 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (8 - SRD1_5_) or 0)
        end
      end
    end
    return string.char(c)
  end
  ))
end

function ehix9(key, data)
  local preData, result
  preData = ""
  result = ""
  local bit_key = bit:charCodeAt(key)
  do
    local c = 0
    local c2 = 1
    while c < #data and not (c >= #data) do
      preData = preData .. string.char(tonumber(string.sub(data, c2, c + 2), 16))
      c = c + 2
      c2 = c2 + 2
    end
  end
  local bit_data = bit:charCodeAt(preData)
  do
    local a = 0
    local b = 0
    while a < #preData do
      if b >= #key then
        b = 0
      end
      a = a + 1
      b = b + 1
      local xor = bit:_xor(bit_data[a], bit_key[b])
      if xor ~= nil and xor < 256 then
        result = result .. string.char(bit:_xor(bit_data[a], bit_key[b]))
      end
    end
  end
  return result
end

function decryptEhi(salt, data)
  data = dec(string.reverse(data), "RkLC2QaVMPYgGJW/A4f7qzDb9e+t6Hr0Zp8OlNyjuxKcTw1o5EIimhBn3UvdSFXs?")
  return ehix9(salt, string.sub(data, 1, #data))
end

function decryptEhil(salt, data)
  data = dec(string.reverse(data), "t6uxKcTwhBn3UvRkLC2QaVM1o5A4f7Hr0Zp8OyjqzDb9e+dSFXsEIimPYgGJW/lN?")
  return ehix9(salt, string.sub(data, 1, #data))
end

function rwmem(Address, SizeOrBuffer)
  assert(Address ~= nil, "[rwmem]: error, endereço fornecido é nulo.")
  _rw = {}
  if type(SizeOrBuffer) == "number" then
    _ = ""
    do
      do
        for SRD1_5_ = 1, SizeOrBuffer do
          _rw[SRD1_5_] = {
            address = Address - 1 + SRD1_5_,
            flags = gg.TYPE_BYTE
          }
        end
      end
    end
    do
      do
        for SRD1_5_, SRD1_6_ in ipairs(gg.getValues(_rw)) do
          if SRD1_6_.value == 0 and limit == true then
            return _
          end
          _ = _ .. string.format("%02X", SRD1_6_.value & 255)
        end
      end
    end
    return _
  end
  Byte = {}
  SizeOrBuffer:gsub("..", function(x)
    Byte[#Byte + 1] = x
    _rw[#Byte] = {
      address = Address - 1 + #Byte,
      flags = gg.TYPE_BYTE,
      value = x .. "h"
    }
  end
  )
  gg.setValues(_rw)
end

function hexdecode(hex)
  return (hex:gsub("%x%x", function(digits)
    return string.char(tonumber(digits, 16))
  end
  ))
end

function hexencode(str)
  return (str:gsub(".", function(char)
    return string.format("%2x", char:byte())
  end
  ))
end

function Dec2Hex(nValue)
  nHexVal = string.format("%X", nValue)
  sHexVal = nHexVal .. ""
  return sHexVal
end

function ToInteger(number)
  return math.floor(tonumber(number) or error("Não foi possível transmitir '" .. tostring(number) .. "' enumerar.'"))
end

function save(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(data)
  gg.toast("te peguei Lionel Richie!")
end

function save2(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(json.stringify(data))
  gg.toast("te peguei Lionel Richie!")
end

function v2json(data)
  io.open(gg.EXT_STORAGE .. "/v2ray.txt", "w"):write(data)
end

function saveEhi(data)
  io.open(gg.EXT_STORAGE .. "/ehi.txt", "w"):write(data)
end

local ehi, configSalt
local Http = {}
function Http:New(data)
  ehi = data
  if data.configSalt == "" then
    configSalt = "EVZJNI"
  else
    configSalt = data.configSalt
  end
end

function Http:Dec(key)
  if ehi.configVersionCode > 10000 then
    if ehi[key] then
      do return decryptEhil(configSalt, ehi[key]) end
      return
    end
    do return "N/A" end
    return
  end
  if ehi[key] then
    do return decryptEhi(configSalt, ehi[key]) end
    return
  end
  return "N/A"
end

function Http:TunnelType()
  if ehi.tunnelType == "ssl_proxy_payload_ssh" then
    do return "SSH ➔ TLS/SSL + Proxy ➔ Custom Payload" end
    return
  end
  if ehi.tunnelType == "http_obfs_shadowsocks" then
    do return "HTTP (Obfs) ➔ Shadowsocks" end
    return
  end
  if ehi.tunnelType == "ssl_ssh" then
    do return "SSL/TLS ➔ SSH" end
    return
  end
  if ehi.tunnelType == "proxy_payload_ssh" then
    do return "SSH ➔ HTTP Proxy ➔ Custom Payload" end
    return
  end
  if ehi.tunnelType == "proxy_ssh" then
    do return "SSH ➔ HTTP Proxy" end
    return
  end
  if ehi.tunnelType == "direct_ssh" then
    do return "SSH (Direct)" end
    return
  end
  if ehi.tunnelType == "direct_shadowsocks" then
    do return "Shadowsocks (Direct)" end
    return
  end
  if ehi.tunnelType == "dnstt_ssh" then
    do return "DNS ➔ DNSTT ➔ SSH" end
    return
  end
  if ehi.tunnelType == "ssl_proxy_ssh" then
    do return "HTTP Proxy ➔ SSL ➔ SSH" end
    return
  end
  if ehi.tunnelType == "ssl_shadowsocks" then
    do return "SSL/TLS (Stunnel) ➔ Shadowsocks" end
    return
  end
  if ehi.tunnelType == "tls_obfs_shadowsocks" then
    do return "SSL/TLS (Obfs) ➔ Shadowsocks" end
    return
  end
  if ehi.tunnelType == "proxy_shadowsocks" then
    do return "HTTP Proxy ➔ Shadowsocks" end
    return
  end
  if ehi.tunnelType == "proxy_payload_shadowsocks" then
    do return "HTTP Proxy ➔ Shadowsocks (Custom Payload)" end
    return
  end
  if ehi.v2ray_all_settings == "v2ray_all_settings" then
    do return "V2Ray" end
    return
  end
  if ehi.tunnelType == "direct_dnsurgent" then
    do return "Direct Dnsurgent" end
    return
  end
  if ehi.tunnelType == "sni_host_port" then
    do return "SSL/TLS" end
    return
  end
  if ehi.tunnelType == "direct_v2r_vmess" then
    do return "V2Ray" end
    return
  end
  if ehi.tunnelType == "v2rRawJson" then
    do return "v2json ➔ V2ray" end
    return
  end
  if ehi.tunnelType == "lock_all" then
    do return "lock ➔ V2ray" end
    return
  end
  if ehi.tunnelType == "unknown" then
    do return "HTTP Proxy ➔ SSH (Custom Payload)" end
    return
  end
  if ehi.tunnelType == "http_obfs" then
    do return "Shadowsocks ➔ HTTP Obfs" end
    return
  end
  if ehi.tunnelType == "direct_payload_ssh" then
    do return "SSH ➔ Direct ➔ Custom Payload" end
    return
  end
  return ehi.tunnelType
end

local includes = function(tab, val)
  do
    do
      for SRD1_5_, SRD1_6_ in ipairs(tab) do
        if SRD1_6_ == val then
          return true
        end
      end
    end
  end
  return false
end

local ssh_mode = {
  "ssl_proxy_payload_ssh",
  "direct_payload_ssh",
  "proxy_payload_ssh",
  "proxy_ssh",
  "dnstt_ssh",
  "ssl_shadowsocks",
  "tls_obfs_shadowsocks",
  "proxy_shadowsocks",
  "proxy_payload_shadowsocks",
  "direct_dnsurgent",
  "direct_v2r_vmess",
  "unknown",
  "v2rRawJson",
  "v2ray_all_settings",
  "http_obfs_shadowsocks",
  "direct_shadowsocks",
  "ssl_proxy_ssh",
  "direct_ssh",
  "sni_host_port",
  "ssl_ssh",
  "lock_all",
  "http_obfs"
}
function parseHttpInjector(data)
  local jsonData = json.parse(hexdecode(data))
  gg.toast("é hora do show")
  
  Http:New(jsonData)
  if includes(ssh_mode, ehi.tunnelType) then
    message = ""
    if ehi.overwriteServerData ~= "" then
      serverData = json.parse(ehi.overwriteServerData)
      message = message .. "Substituir dados do servidor: " .. ehi.overwriteServerData .. [[


]]
      message = message .. "Sobrescrever porta proxy do servidor: " .. ehi.overwriteServerProxyPort .. [[


]]
      message = message .. "Sobrescrever Tipo Servidor: " .. ehi.overwriteServerType .. [[


]]
      message = message .. "Servidor Evozi: " .. serverData.name .. " (" .. serverData.ip .. [[
)

]]
elseif ehi.tunnelType == "direct_shadowsocks" then
      message = message .. "HTTP Obfs Settings: " .. Http:Dec("httpObfsSettings") .. [[


]]
      message = message .. "Shadowsocks Host: " .. Http:Dec("shadowsocksHost") .. "\n"
      message = message .. "Shadowsocks Porta: " .. ehi.shadowsocksPort .. "\n"
      message = message .. "Shadowsocks Senha: " .. Http:Dec("shadowsocksPassword") .. [[


]]
      message = message .. "EncryptMethod: " .. string.upper(ehi.shadowsocksEncryptionMethod) .. [[


]]
      message = message .. "V2rMuxConcurrency: " .. Http:Dec("v2rMuxConcurrency") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
elseif ehi.tunnelType == "tls_obfs_shadowsocks" then
      message = message .. "HTTP Obfs Settings: " .. Http:Dec("httpObfsSettings") .. [[


]]
message = message .. "Shadowsocks Host: " .. Http:Dec("shadowsocksHost") .. "\n"
      message = message .. "Shadowsocks Porta: " .. ehi.shadowsocksPort .. "\n"
      message = message .. "Shadowsocks Senha: " .. Http:Dec("shadowsocksPassword") .. [[


]]
      message = message .. "EncryptMethod: " .. string.upper(ehi.shadowsocksEncryptionMethod) .. [[


]]
      message = message .. "V2rMuxConcurrency: " .. Http:Dec("v2rMuxConcurrency") .. [[


]]
      message = message .. "SNI: " .. Http:Dec("sniHostname") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
elseif ehi.tunnelType == "http_obfs_shadowsocks" then
      message = message .. "HTTP Obfs Settings: " .. Http:Dec("httpObfsSettings") .. [[


]]
      message = message .. "Shadowsocks Host: " .. Http:Dec("shadowsocksHost") .. "\n"
      message = message .. "Shadowsocks Porta: " .. ehi.shadowsocksPort .. "\n"
      message = message .. "Shadowsocks Senha: " .. Http:Dec("shadowsocksPassword") .. [[


]]
      message = message .. "EncryptMethod: " .. string.upper(ehi.shadowsocksEncryptionMethod) .. [[


]]
      message = message .. "V2rMuxConcurrency: " .. Http:Dec("v2rMuxConcurrency") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
    else
      message = message .. "SSH Host: " .. Http:Dec("host") .. "\n"
      message = message .. "Porta: " .. ehi.port .. "\n"
      message = message .. "Usuário: " .. Http:Dec("user") .. "\n"
      message = message .. "Senha: " .. Http:Dec("password") .. [[


]]
 end
    if ehi.remoteProxy then
      if ehi.remoteProxyUsername and ehi.remoteProxyUsername ~= "" then
        message = message .. "Proxy: " .. Http:Dec("remoteProxy") .. "\n"
        message = message .. "Usuário e Senha Proxy Auth: " .. Http:Dec("remoteProxyUsername") .. ":" .. Http:Dec("remoteProxyPassword") .. [[


]]
      end
      elseif ehi.overwriteServerData ~= "" then
      if ehi.tunnelType == "proxy_payload_ssh" then
    message = message .. "Proxy: " .. Http:Dec("remoteProxy") .. [[


]]
end
      elseif ehi.overwriteServerData ~= "" then
      if ehi.tunnelType == "ssl_proxy_payload_ssh" then
    message = message .. "Proxy: " .. Http:Dec("remoteProxy") .. [[


]]
message = message .. "SNI: " .. Http:Dec("sniHostname") .. [[


]]
end
      elseif ehi.overwriteServerData ~= "" then
      if ehi.tunnelType == "proxy_ssh" then
    message = message .. "Proxy: " .. Http:Dec("remoteProxy") .. [[


]]
      end
    elseif ehi.overwriteServerData ~= "" then
    if ehi.tunnelType == "ssl_ssh" then
      message = message .. "SNI: " .. Http:Dec("sniHostname") .. [[


]]
end
    elseif ehi.overwriteServerData ~= "" then
    if ehi.tunnelType == "sni_host_port" then
      message = message .. "SNI: " .. Http:Dec("sniHostname") .. [[


]]

    end
    elseif ehi.tunnelType == "ssl_shadowsocks" then
    message = message .. "Shadowsocks Host: " .. Http:Dec("shadowsocksHost") .. "\n"
      message = message .. "Shadowsocks Porta: " .. ehi.shadowsocksPort .. "\n"
      message = message .. "Shadowsocks Senha: " .. Http:Dec("shadowsocksPassword") .. [[


]]
      message = message .. "EncryptMethod: " .. string.upper(ehi.shadowsocksEncryptionMethod) .. [[


]]
      message = message .. "SNI: " .. Http:Dec("sniHostname") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "direct_payload_ssh" then
      message = message .. "Payload: " .. Http:Dec("payload") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "ssl_proxy_ssh" then
    message = message .. "Proxy: " .. Http:Dec("remoteProxy") .. [[


]]
message = message .. "SNI: " .. Http:Dec("sniHostname") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "sni_host_port" then
    message = message .. "SNI: " .. Http:Dec("sniHostname") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "ssl_proxy_payload_ssh" then
    message = message .. "Proxy: " .. Http:Dec("remoteProxy") .. [[


]]
message = message .. "SNI: " .. Http:Dec("sniHostname") .. [[


]]
      message = message .. "Payload: " .. Http:Dec("payload") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "proxy_payload_ssh" then
    message = message .. "Proxy: " .. Http:Dec("remoteProxy") .. [[


]]
      message = message .. "Payload: " .. Http:Dec("payload") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "proxy_ssh" then
    message = message .. "Proxy: " .. Http:Dec("remoteProxy") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "ssl_ssh" then
    message = message .. "SNI: " .. Http:Dec("sniHostname") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "direct_ssh" then
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "direct_v2r_vmess" then
      message = "v2rRawJson: " .. Http:Dec("v2rRawJson") .. [[


]]
      if ehi.v2rRawJson then
        v2json = Http:Dec("v2rRawJson")
        saveEhi(v2json)
        gg.copyText(v2json, false)
        gg.toast("copiado para área de transferência")
        print(message)
        return
      end
      message = message .. "User Alter ID: " .. Http:Dec("v2rAlterId") .. "\n"
      message = message .. "V2Ray Host: " .. Http:Dec("v2rHost") .. "\n"
      message = message .. "v2rKcpHeaderType: " .. Http:Dec("v2rKcpHeaderType") .. "\n"
      message = message .. "v2rMuxConcurrency: " .. Http:Dec("v2rMuxConcurrency") .. "\n"
      message = message .. "v2rPassword: " .. Http:Dec("v2rPassword") .. "\n"
      message = message .. "v2rNetwork: " .. Http:Dec("v2rNetwork") .. "\n"
      message = message .. "v2rPort: " .. Http:Dec("v2rPort") .. "\n"
      message = message .. "v2rProtocol: " .. Http:Dec("v2rProtocol") .. "\n"
      message = message .. "v2rH2Host: " .. Http:Dec("v2rH2Host") .. "\n"
      message = message .. "v2rH2Path: " .. Http:Dec("v2rH2Path") .. "\n"
      message = message .. "v2rQuicHeaderType: " .. Http:Dec("v2rQuicHeaderType") .. "\n"
      message = message .. "v2rTcpHeaderType: " .. Http:Dec("v2rTcpHeaderType") .. "\n"
      message = message .. "v2rUserId: " .. Http:Dec("v2rUserId") .. "\n"
      message = message .. "v2rTlsSni: " .. Http:Dec("v2rTlsSni") .. "\n"
      message = message .. "v2rVlessSecurity: " .. Http:Dec("v2rVlessSecurity") .. "\n"
      message = message .. "v2rVmessSecurity: " .. Http:Dec("v2rVmessSecurity") .. "\n"
      message = message .. "v2rSsSecurity: " .. Http:Dec("v2rSsSecurity") .. "\n"
      message = message .. "v2rQuicSecurity: " .. Http:Dec("v2rQuicSecurity") .. "\n"
      message = message .. "Header Ws: " .. Http:Dec("v2rWsHeader") .. "\n"
      message = message .. "v2rWsPath: " .. Http:Dec("v2rWsPath") .. [[


]]
      message = message .. "v2rCoreType: " .. Http:Dec("v2rCoreType") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "dnstt_ssh" then
      message = message .. "Tipo de DNS: " .. ehi.dnsType .. "\n"
      message = message .. "DNS Resolver Address: " .. Http:Dec("dnsttDnsResolverAddr") .. "\n"
      message = message .. "DNSTT Nameserver: " .. Http:Dec("dnsttNameserver") .. "\n"
      message = message .. "DNSTT Public Key: " .. Http:Dec("dnsttPublicKey") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]

   end
    gg.copyText(message, false)
    gg.toast(message .. [[

copiou, farinha?]])
    print(message)
    saveEhi(message)
  end
  os.exit()
end

function ehievozi()
  limit = true
  gg.clearResults()
  gg.setVisible(false)
  gg.setRanges(gg.REGION_C_ALLOC)
  gg.searchNumber("h 7B 22 63 6F 6E 66 69 67 45 78 70 69 72 79 54 69 6D 65 73 74", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado: configExpiryTimest")
    ehi_2 = true
  end
  gg.searchNumber("h 7B 22 63 6F 6E 66 69 67 45 78 70 69 72 79 54 69 6D 65 73 74", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
        gg.toast("Pai não encontrado")
        ehi_2 = true
    end
    
    if ehi_2 then
        gg.searchNumber("h 7B 22 56 32 72 54 6C 73 41 6C 70 6E 22 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
        local r = gg.getResults(1)
        if #r < 1 then
        gg.toast("Pai não encontrado: V2rTlsAlpn")
      print([[

calma barboleta]])
        ehi_3 = true
        end
        end
  if ehi_3 then
    gg.searchNumber("h 7B 22 63 6F 6E 66 69 67 49 64 65 6E 74 69 66 69 65 72 22 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: configIdentifier")
      print([[

calma barboleta]])
      print("\nimporte o arquivo novamente, espere 3 segundos e inicie o script da diversão\n\n")
      os.exit()
    end
  end
  gg.searchNumber("h7B", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1000)
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  do
    do
      for SRD1_5_, SRD1_6_ in ipairs(r) do
        r[SRD1_5_].flags = gg.TYPE_FLOAT
        r[SRD1_5_].value = "1000"
      end
    end
  end
  gg.setValues(r)
  gg.clearResults()
  parseHttpInjector(readedMem)
end
  
if app == "com.evozi.injector" then
  ehievozi()
elseif app == "com.evozi.injector.lite" then
  ehievozi()
else
  gg.toast("não me deixe vê")
  print("\nhoje não é o seu dia de sorte\n\n")
end
gg.clearResults()
x9B()
end

function x9C()

limit = false
targetInfo = gg.getTargetInfo()
app = targetInfo.packageName
local utf8 = {}
local bit = {
  data32 = {}
}
do
  do
    for SRD1_5_ = 1, 32 do
      bit.data32[SRD1_5_] = 2 ^ (32 - SRD1_5_)
    end
  end
end
local toby = string.byte
function utf8.charbytes(s, i)
  i = i or 1
  local c = string.byte(s, i)
  if c > 0 and c <= 127 then
    do return 1 end
    return
  end
  if c >= 194 and c <= 223 then
    do return 2 end
    return
  end
  if c >= 224 and c <= 239 then
    do return 3 end
    return
  end
  if c >= 240 and c <= 244 then
    return 4
  end
  return 1
end

local ded
function bit:d2b(arg)
  if arg == nil then
    return
  end
  local tr, c = {}, arg < 0
  if c then
    arg = 0 - arg
  end
  do
    do
      for SRD1_7_ = 1, 32 do
        if arg >= self.data32[SRD1_7_] then
          tr[SRD1_7_] = 1
          arg = arg - self.data32[SRD1_7_]
        else
          tr[SRD1_7_] = 0
        end
      end
    end
  end
  if c then
    tr = self:_bnot(tr)
    tr = self:b2d(tr) + 1
    tr = self:d2b(tr)
  end
  return tr
end

function bit:b2d(arg, neg)
  local nr = 0
  if arg[1] == 1 and neg == true then
    arg = self:_bnot(arg)
    nr = self:b2d(arg) + 1
    nr = 0 - nr
  else
    do
      for SRD1_7_ = 1, 32 do
        if arg[SRD1_7_] == 1 then
          nr = nr + 2 ^ (32 - SRD1_7_)
        end
      end
    end
  end
  return nr
end

function bit:_and(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 and op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_or(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 or op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_xor(a, b)
  local op1 = self:d2b(a)
  if op1 == nil then
    return nil
  end
  local op2 = self:d2b(b)
  if op2 == nil then
    return nil
  end
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == op2[SRD1_9_] then
          r[SRD1_9_] = 0
        else
          r[SRD1_9_] = 1
        end
      end
    end
  end
  return self:b2d(r, true)
end

local switch = {
  [1] = function(s, pos)
    local c1 = toby(s, pos)
    return c1
  end
  ,
  [2] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local int1 = bit:_and(31, c1)
    local int2 = bit:_and(63, c2)
    return bit:_or(bit:_lshift(int1, 6), int2)
  end
  ,
  [3] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local o2 = bit:_or(bit:_lshift(int1, 12), bit:_lshift(int2, 6))
    local dt = bit:_or(o2, int3)
    return dt
  end
  ,
  [4] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local c4 = toby(s, pos + 3)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local int4 = bit:_and(63, c4)
    local o2 = bit:_or(bit:_lshift(int1, 18), bit:_lshift(int2, 12))
    local o3 = bit:_or(o2, bit:_lshift(int3, 6))
    local o4 = bit:_or(o3, int4)
    return o4
  end
  
}
function bit:_bnot(op1)
  local r = {}
  do
    do
      for SRD1_6_ = 1, 32 do
        if op1[SRD1_6_] == 1 then
          r[SRD1_6_] = 0
        else
          r[SRD1_6_] = 1
        end
      end
    end
  end
  return r
end

function bit:_not(a)
  local op1 = self:d2b(a)
  local r = self:_bnot(op1)
  return self:b2d(r, true)
end

function bit:charCodeAt(s)
  local pos, int, H, L = 1, 0, 0, 0
  local slen = string.len(s)
  local allByte = {}
  while pos <= slen do
    local tLen = utf8.charbytes(s, pos)
    if tLen >= 1 and tLen <= 4 then
      if tLen == 4 then
        int = switch[4](s, pos)
        H = math.floor((int - 65536) / 1024) + 55296
        L = (int - 65536) % 1024 + 56320
        table.insert(allByte, H)
        table.insert(allByte, L)
      else
        int = switch[tLen](s, pos)
        table.insert(allByte, int)
      end
    end
    pos = pos + tLen
  end
  return allByte
end

function bit:_rshift(a, n)
  local r = 0
  if a < 0 then
    r = 0 - self:_frshift(0 - a, n)
  elseif a >= 0 then
    r = self:_frshift(a, n)
  end
  return r
end

function bit:_frshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  local left = 32 - n
  if n < 32 and n > 0 then
    do
      for SRD1_9_ = left, 1, -1 do
        r[SRD1_9_ + n] = op1[SRD1_9_]
      end
    end
  end
  return self:b2d(r)
end

function bit:_lshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  if n < 32 and n > 0 then
    do
      for SRD1_8_ = n, 31 do
        r[SRD1_8_ - n + 1] = op1[SRD1_8_ + 1]
      end
    end
  end
  return self:b2d(r, true)
end

function trim(s)
  return s:match("^%s*(.*)"):match("(.-)%s*$")
end

local json = {}
local kind_of = function(obj)
  if type(obj) ~= "table" then
    return type(obj)
  end
  local i = 1
  do
    do
      for SRD1_5_ in pairs(obj) do
        if obj[i] ~= nil then
          i = i + 1
        else
          return "table"
        end
      end
    end
  end
  if i == 1 then
    do return "table" end
    return
  end
  return "array"
end

local escape_str = function(s)
  local in_char = {
    "\\",
    "\"",
    "/",
    "\b",
    "\f",
    "\n",
    "\r",
    "\t"
  }
  local out_char = {
    "\\",
    "\"",
    "/",
    "b",
    "f",
    "n",
    "r",
    "t"
  }
  do
    do
      for SRD1_6_, SRD1_7_ in ipairs(in_char) do
        s = s:gsub(SRD1_7_, "\\" .. out_char[SRD1_6_])
      end
    end
  end
  return s
end

local skip_delim = function(str, pos, delim, err_if_missing)
  pos = pos + #str:match("^%s*", pos)
  if str:sub(pos, pos) ~= delim then
    if err_if_missing then
      error("Esperado " .. delim .. " posição próxima " .. pos)
    end
    return pos, false
  end
  return pos + 1, true
end

local function parse_str_val(str, pos, val)
  val = val or ""
  local early_end_error = "Fim da entrada encontrado durante a análise da string."
  if pos > #str then
    error(early_end_error)
  end
  local c = str:sub(pos, pos)
  if c == "\"" then
    return val, pos + 1
  end
  if c ~= "\\" then
    return parse_str_val(str, pos + 1, val .. c)
  end
  local esc_map = {
    b = "\b",
    f = "\f",
    n = "\n",
    r = "\r",
    t = "\t"
  }
  local nextc = str:sub(pos + 1, pos + 1)
  if not nextc then
    error(early_end_error)
  end
  return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

local parse_num_val = function(str, pos)
  local num_str = str:match("^-?%d+%.?%d*[eE]?[+-]?%d*", pos)
  local val = tonumber(num_str)
  if not val then
    error("Erro ao analisar o número na posição " .. pos .. ".")
  end
  return val, pos + #num_str
end

function json.stringify(obj, as_key)
  local s = {}
  local kind = kind_of(obj)
  if kind == "array" then
    if as_key then
      error("Não é possível codificar array como chave.")
    end
    s[#s + 1] = "["
    do
      do
        for SRD1_7_, SRD1_8_ in ipairs(obj) do
          if SRD1_7_ > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "]"
  elseif kind == "table" then
    if as_key then
      error("Não é possível codificar a tabela como chave.")
    end
    s[#s + 1] = "{"
    do
      do
        for SRD1_7_, SRD1_8_ in pairs(obj) do
          if #s > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_7_, true)
          s[#s + 1] = ":"
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "}"
  else
    if kind == "string" then
      do return "\"" .. escape_str(obj) .. "\"" end
      return
    end
    if kind == "number" then
      if as_key then
        return "\"" .. tostring(obj) .. "\""
      end
      do return tostring(obj) end
      return
    end
    if kind == "boolean" then
      do return tostring(obj) end
      return
    end
    if kind == "nil" then
      do return "null" end
      return
    end
    error("tipo unjsonificável,: " .. kind .. ".")
  end
  return table.concat(s)
end

json.null = {}
function json.parse(str, pos, end_delim)
  pos = pos or 1
  if pos > #str then
    error("Atingiu o fim inesperado da entrada ")
  end
  local pos = pos + #str:match("^%s*", pos)
  local first = str:sub(pos, pos)
  if first == "{" then
    do
      local obj, key, delim_found = {}, true, true
      pos = pos + 1
      while true do
        key, pos = json.parse(str, pos, "}")
        if key == nil then
          return obj, pos
        end
        if not delim_found then
          error("Vírgula faltando entre os itens do objeto.")
        end
        pos = skip_delim(str, pos, ":", true)
        obj[key], pos = json.parse(str, pos)
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "[" then
    do
      local arr, val, delim_found = {}, true, true
      pos = pos + 1
      while true do
        val, pos = json.parse(str, pos, "]")
        if val == nil then
          return arr, pos
        end
        if not delim_found then
          error("Falta vírgula entre os itens do array.")
        end
        arr[#arr + 1] = val
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "\"" then
    do return parse_str_val(str, pos + 1) end
    return
  end
  if first == "-" or first:match("%d") then
    do return parse_num_val(str, pos) end
    return
  end
  if first == end_delim then
    do return nil, pos + 1 end
    return
  end
  do
    local literals = {
      ["true"] = true,
      ["false"] = false,
      null = json.null
    }
    do
      do
        for SRD1_9_, SRD1_10_ in pairs(literals) do
          local lit_end = pos + #SRD1_9_ - 1
          if str:sub(pos, lit_end) == SRD1_9_ then
            return SRD1_10_, lit_end + 1
          end
        end
      end
    end
    local pos_info_str = "position " .. pos .. ": " .. str:sub(pos, pos + 10)
    error("Sintaxe json inválida começando em " .. pos_info_str)
  end
end

function enc(data, b)
  return (data:gsub(".", function(x)
    local r, b = "", x:byte()
    do
      do
        for SRD1_6_ = 8, 1, -1 do
          r = r .. (b % 2 ^ SRD1_6_ - b % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
    if #x < 6 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 6 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (6 - SRD1_5_) or 0)
        end
      end
    end
    return b:sub(c + 1, c + 1)
  end
  ) .. ({
    "",
    "??",
    "?"
  })[#data % 3 + 1]
end

function dec(data, b)
  data = string.gsub(data, "[^" .. b .. "=]", "")
  return (data:gsub(".", function(x)
    if x == "?" then
      return ""
    end
    local r, f = "", b:find(x) - 1
    do
      do
        for SRD1_6_ = 6, 1, -1 do
          r = r .. (f % 2 ^ SRD1_6_ - f % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
    if #x ~= 8 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 8 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (8 - SRD1_5_) or 0)
        end
      end
    end
    return string.char(c)
  end
  ))
end

function ehix9(key, data)
  local preData, result
  preData = ""
  result = ""
  local bit_key = bit:charCodeAt(key)
  do
    local c = 0
    local c2 = 1
    while c < #data and not (c >= #data) do
      preData = preData .. string.char(tonumber(string.sub(data, c2, c + 2), 16))
      c = c + 2
      c2 = c2 + 2
    end
  end
  local bit_data = bit:charCodeAt(preData)
  do
    local a = 0
    local b = 0
    while a < #preData do
      if b >= #key then
        b = 0
      end
      a = a + 1
      b = b + 1
      local xor = bit:_xor(bit_data[a], bit_key[b])
      if xor ~= nil and xor < 256 then
        result = result .. string.char(bit:_xor(bit_data[a], bit_key[b]))
      end
    end
  end
  return result
end

function decryptEhi(salt, data)
  data = dec(string.reverse(data), "RkLC2QaVMPYgGJW/A4f7qzDb9e+t6Hr0Zp8OlNyjuxKcTw1o5EIimhBn3UvdSFXs?")
  return ehix9(salt, string.sub(data, 1, #data))
end

function decryptEhil(salt, data)
  data = dec(string.reverse(data), "t6uxKcTwhBn3UvRkLC2QaVM1o5A4f7Hr0Zp8OyjqzDb9e+dSFXsEIimPYgGJW/lN?")
  return ehix9(salt, string.sub(data, 1, #data))
end

function rwmem(Address, SizeOrBuffer)
  assert(Address ~= nil, "[rwmem]: error, endereço fornecido é nulo.")
  _rw = {}
  if type(SizeOrBuffer) == "number" then
    _ = ""
    do
      do
        for SRD1_5_ = 1, SizeOrBuffer do
          _rw[SRD1_5_] = {
            address = Address - 1 + SRD1_5_,
            flags = gg.TYPE_BYTE
          }
        end
      end
    end
    do
      do
        for SRD1_5_, SRD1_6_ in ipairs(gg.getValues(_rw)) do
          if SRD1_6_.value == 0 and limit == true then
            return _
          end
          _ = _ .. string.format("%02X", SRD1_6_.value & 255)
        end
      end
    end
    return _
  end
  Byte = {}
  SizeOrBuffer:gsub("..", function(x)
    Byte[#Byte + 1] = x
    _rw[#Byte] = {
      address = Address - 1 + #Byte,
      flags = gg.TYPE_BYTE,
      value = x .. "h"
    }
  end
  )
  gg.setValues(_rw)
end

function hexdecode(hex)
  return (hex:gsub("%x%x", function(digits)
    return string.char(tonumber(digits, 16))
  end
  ))
end

function hexencode(str)
  return (str:gsub(".", function(char)
    return string.format("%2x", char:byte())
  end
  ))
end

function Dec2Hex(nValue)
  nHexVal = string.format("%X", nValue)
  sHexVal = nHexVal .. ""
  return sHexVal
end

function ToInteger(number)
  return math.floor(tonumber(number) or error("Não foi possível transmitir '" .. tostring(number) .. "' enumerar.'"))
end

function save(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(data)
  gg.toast("te peguei Lionel Richie!")
end

function save2(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(json.stringify(data))
  gg.toast("te peguei Lionel Richie!")
end

function hc(data)
  io.open(gg.EXT_STORAGE .. "/hc.txt", "w"):write(data)
  gg.toast("te peguei Lionel Richie!")
end

function v2json(data)
  io.open(gg.EXT_STORAGE .. "/v2ray.txt", "w"):write(data)
end

function saveEhi(data)
  io.open(gg.EXT_STORAGE .. "/ehi.txt", "w"):write(data)
end

local ehi, configSalt
local Http = {}
function Http:New(data)
  ehi = data
  if data.configSalt == "" then
    configSalt = "EVZJNI"
  else
    configSalt = data.configSalt
  end
end

function Http:Dec(key)
  if ehi.configVersionCode > 10000 then
    if ehi[key] then
      do return decryptEhil(configSalt, ehi[key]) end
      return
    end
    do return "N/A" end
    return
  end
  if ehi[key] then
    do return decryptEhi(configSalt, ehi[key]) end
    return
  end
  return "N/A"
end

function Http:TunnelType()
  if ehi.tunnelType == "ssl_proxy_payload_ssh" then
    do return "SSH ➔ TLS/SSL + Proxy ➔ Custom Payload" end
    return
  end
  if ehi.tunnelType == "http_obfs_shadowsocks" then
    do return "HTTP (Obfs) ➔ Shadowsocks" end
    return
  end
  if ehi.tunnelType == "ssl_ssh" then
    do return "SSL/TLS ➔ SSH" end
    return
  end
  if ehi.tunnelType == "proxy_payload_ssh" then
    do return "SSH ➔ HTTP Proxy ➔ Custom Payload" end
    return
  end
  if ehi.tunnelType == "proxy_ssh" then
    do return "SSH ➔ HTTP Proxy" end
    return
  end
  if ehi.tunnelType == "direct_ssh" then
    do return "SSH (Direct)" end
    return
  end
  if ehi.tunnelType == "direct_shadowsocks" then
    do return "Shadowsocks (Direct)" end
    return
  end
  if ehi.tunnelType == "dnstt_ssh" then
    do return "DNS ➔ DNSTT ➔ SSH" end
    return
  end
  if ehi.tunnelType == "ssl_proxy_ssh" then
    do return "HTTP Proxy ➔ SSL ➔ SSH" end
    return
  end
  if ehi.tunnelType == "ssl_shadowsocks" then
    do return "SSL/TLS (Stunnel) ➔ Shadowsocks" end
    return
  end
  if ehi.tunnelType == "tls_obfs_shadowsocks" then
    do return "SSL/TLS (Obfs) ➔ Shadowsocks" end
    return
  end
  if ehi.tunnelType == "proxy_shadowsocks" then
    do return "HTTP Proxy ➔ Shadowsocks" end
    return
  end
  if ehi.tunnelType == "proxy_payload_shadowsocks" then
    do return "HTTP Proxy ➔ Shadowsocks (Custom Payload)" end
    return
  end
  if ehi.v2ray_all_settings == "v2ray_all_settings" then
    do return "V2Ray" end
    return
  end
  if ehi.tunnelType == "direct_dnsurgent" then
    do return "Direct Dnsurgent" end
    return
  end
  if ehi.tunnelType == "sni_host_port" then
    do return "SSL/TLS" end
    return
  end
  if ehi.tunnelType == "direct_v2r_vmess" then
    do return "V2Ray" end
    return
  end
  if ehi.tunnelType == "v2rRawJson" then
    do return "v2json ➔ V2ray" end
    return
  end
  if ehi.tunnelType == "lock_all" then
    do return "lock ➔ V2ray" end
    return
  end
  if ehi.tunnelType == "unknown" then
    do return "HTTP Proxy ➔ SSH (Custom Payload)" end
    return
  end
  if ehi.tunnelType == "http_obfs" then
    do return "Shadowsocks ➔ HTTP Obfs" end
    return
  end
  if ehi.tunnelType == "direct_payload_ssh" then
    do return "SSH ➔ Direct ➔ Custom Payload" end
    return
  end
  return ehi.tunnelType
end

local includes = function(tab, val)
  do
    do
      for SRD1_5_, SRD1_6_ in ipairs(tab) do
        if SRD1_6_ == val then
          return true
        end
      end
    end
  end
  return false
end

local ssh_mode = {
  "ssl_proxy_payload_ssh",
  "direct_payload_ssh",
  "proxy_payload_ssh",
  "proxy_ssh",
  "dnstt_ssh",
  "ssl_shadowsocks",
  "tls_obfs_shadowsocks",
  "proxy_shadowsocks",
  "proxy_payload_shadowsocks",
  "direct_dnsurgent",
  "direct_v2r_vmess",
  "unknown",
  "v2rRawJson",
  "v2ray_all_settings",
  "http_obfs_shadowsocks",
  "direct_shadowsocks",
  "ssl_proxy_ssh",
  "direct_ssh",
  "sni_host_port",
  "ssl_ssh",
  "lock_all",
  "http_obfs"
}
function parseHttpInjector(data)
  local jsonData = json.parse(hexdecode(data))
  gg.toast("é hora do show")
  
  Http:New(jsonData)
  if includes(ssh_mode, ehi.tunnelType) then
    message = ""
    if ehi.overwriteServerData ~= "" then
      serverData = json.parse(ehi.overwriteServerData)
      message = message .. "Substituir dados do servidor: " .. ehi.overwriteServerData .. [[


]]
      message = message .. "Sobrescrever porta proxy do servidor: " .. ehi.overwriteServerProxyPort .. [[


]]
      message = message .. "Sobrescrever Tipo Servidor: " .. ehi.overwriteServerType .. [[


]]
      message = message .. "Servidor Evozi: " .. serverData.name .. " (" .. serverData.ip .. [[
)

]]
elseif ehi.tunnelType == "direct_shadowsocks" then
      message = message .. "HTTP Obfs Settings: " .. Http:Dec("httpObfsSettings") .. [[


]]
      message = message .. "Shadowsocks Host: " .. Http:Dec("shadowsocksHost") .. "\n"
      message = message .. "Shadowsocks Porta: " .. ehi.shadowsocksPort .. "\n"
      message = message .. "Shadowsocks Senha: " .. Http:Dec("shadowsocksPassword") .. [[


]]
      message = message .. "EncryptMethod: " .. string.upper(ehi.shadowsocksEncryptionMethod) .. [[


]]
      message = message .. "V2rMuxConcurrency: " .. Http:Dec("v2rMuxConcurrency") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
elseif ehi.tunnelType == "tls_obfs_shadowsocks" then
      message = message .. "HTTP Obfs Settings: " .. Http:Dec("httpObfsSettings") .. [[


]]
message = message .. "Shadowsocks Host: " .. Http:Dec("shadowsocksHost") .. "\n"
      message = message .. "Shadowsocks Porta: " .. ehi.shadowsocksPort .. "\n"
      message = message .. "Shadowsocks Senha: " .. Http:Dec("shadowsocksPassword") .. [[


]]
      message = message .. "EncryptMethod: " .. string.upper(ehi.shadowsocksEncryptionMethod) .. [[


]]
      message = message .. "V2rMuxConcurrency: " .. Http:Dec("v2rMuxConcurrency") .. [[


]]
      message = message .. "SNI: " .. Http:Dec("sniHostname") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
elseif ehi.tunnelType == "http_obfs_shadowsocks" then
      message = message .. "HTTP Obfs Settings: " .. Http:Dec("httpObfsSettings") .. [[


]]
      message = message .. "Shadowsocks Host: " .. Http:Dec("shadowsocksHost") .. "\n"
      message = message .. "Shadowsocks Porta: " .. ehi.shadowsocksPort .. "\n"
      message = message .. "Shadowsocks Senha: " .. Http:Dec("shadowsocksPassword") .. [[


]]
      message = message .. "EncryptMethod: " .. string.upper(ehi.shadowsocksEncryptionMethod) .. [[


]]
      message = message .. "V2rMuxConcurrency: " .. Http:Dec("v2rMuxConcurrency") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
    else
      message = message .. "SSH Host: " .. Http:Dec("host") .. "\n"
      message = message .. "Porta: " .. ehi.port .. "\n"
      message = message .. "Usuário: " .. Http:Dec("user") .. "\n"
      message = message .. "Senha: " .. Http:Dec("password") .. [[


]]
 end
    if ehi.remoteProxy then
      if ehi.remoteProxyUsername and ehi.remoteProxyUsername ~= "" then
        message = message .. "Proxy: " .. Http:Dec("remoteProxy") .. "\n"
        message = message .. "Usuário e Senha Proxy Auth: " .. Http:Dec("remoteProxyUsername") .. ":" .. Http:Dec("remoteProxyPassword") .. [[


]]
      end
      elseif ehi.overwriteServerData ~= "" then
      if ehi.tunnelType == "proxy_payload_ssh" then
    message = message .. "Proxy: " .. Http:Dec("remoteProxy") .. [[


]]
end
      elseif ehi.overwriteServerData ~= "" then
      if ehi.tunnelType == "ssl_proxy_payload_ssh" then
    message = message .. "Proxy: " .. Http:Dec("remoteProxy") .. [[


]]
message = message .. "SNI: " .. Http:Dec("sniHostname") .. [[


]]
end
      elseif ehi.overwriteServerData ~= "" then
      if ehi.tunnelType == "proxy_ssh" then
    message = message .. "Proxy: " .. Http:Dec("remoteProxy") .. [[


]]
      end
    elseif ehi.overwriteServerData ~= "" then
    if ehi.tunnelType == "ssl_ssh" then
      message = message .. "SNI: " .. Http:Dec("sniHostname") .. [[


]]
end
    elseif ehi.overwriteServerData ~= "" then
    if ehi.tunnelType == "sni_host_port" then
      message = message .. "SNI: " .. Http:Dec("sniHostname") .. [[


]]

    end
    elseif ehi.tunnelType == "ssl_shadowsocks" then
    message = message .. "Shadowsocks Host: " .. Http:Dec("shadowsocksHost") .. "\n"
      message = message .. "Shadowsocks Porta: " .. ehi.shadowsocksPort .. "\n"
      message = message .. "Shadowsocks Senha: " .. Http:Dec("shadowsocksPassword") .. [[


]]
      message = message .. "EncryptMethod: " .. string.upper(ehi.shadowsocksEncryptionMethod) .. [[


]]
      message = message .. "SNI: " .. Http:Dec("sniHostname") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "direct_payload_ssh" then
      message = message .. "Payload: " .. Http:Dec("payload") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "ssl_proxy_ssh" then
    message = message .. "Proxy: " .. Http:Dec("remoteProxy") .. [[


]]
message = message .. "SNI: " .. Http:Dec("sniHostname") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "sni_host_port" then
    message = message .. "SNI: " .. Http:Dec("sniHostname") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "ssl_proxy_payload_ssh" then
    message = message .. "Proxy: " .. Http:Dec("remoteProxy") .. [[


]]
message = message .. "SNI: " .. Http:Dec("sniHostname") .. [[


]]
      message = message .. "Payload: " .. Http:Dec("payload") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "proxy_payload_ssh" then
    message = message .. "Proxy: " .. Http:Dec("remoteProxy") .. [[


]]
      message = message .. "Payload: " .. Http:Dec("payload") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "proxy_ssh" then
    message = message .. "Proxy: " .. Http:Dec("remoteProxy") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "ssl_ssh" then
    message = message .. "SNI: " .. Http:Dec("sniHostname") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "direct_ssh" then
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "direct_v2r_vmess" then
      message = "v2rRawJson: " .. Http:Dec("v2rRawJson") .. [[


]]
      if ehi.v2rRawJson then
        v2json = Http:Dec("v2rRawJson")
        saveEhi(v2json)
        gg.copyText(v2json, false)
        gg.toast("copiado para área de transferência")
        print(message)
        return
      end
      message = message .. "User Alter ID: " .. Http:Dec("v2rAlterId") .. "\n"
      message = message .. "V2Ray Host: " .. Http:Dec("v2rHost") .. "\n"
      message = message .. "v2rKcpHeaderType: " .. Http:Dec("v2rKcpHeaderType") .. "\n"
      message = message .. "v2rMuxConcurrency: " .. Http:Dec("v2rMuxConcurrency") .. "\n"
      message = message .. "v2rPassword: " .. Http:Dec("v2rPassword") .. "\n"
      message = message .. "v2rNetwork: " .. Http:Dec("v2rNetwork") .. "\n"
      message = message .. "v2rPort: " .. Http:Dec("v2rPort") .. "\n"
      message = message .. "v2rProtocol: " .. Http:Dec("v2rProtocol") .. "\n"
      message = message .. "v2rH2Host: " .. Http:Dec("v2rH2Host") .. "\n"
      message = message .. "v2rH2Path: " .. Http:Dec("v2rH2Path") .. "\n"
      message = message .. "v2rQuicHeaderType: " .. Http:Dec("v2rQuicHeaderType") .. "\n"
      message = message .. "v2rTcpHeaderType: " .. Http:Dec("v2rTcpHeaderType") .. "\n"
      message = message .. "v2rUserId: " .. Http:Dec("v2rUserId") .. "\n"
      message = message .. "v2rTlsSni: " .. Http:Dec("v2rTlsSni") .. "\n"
      message = message .. "v2rVlessSecurity: " .. Http:Dec("v2rVlessSecurity") .. "\n"
      message = message .. "v2rVmessSecurity: " .. Http:Dec("v2rVmessSecurity") .. "\n"
      message = message .. "v2rSsSecurity: " .. Http:Dec("v2rSsSecurity") .. "\n"
      message = message .. "v2rQuicSecurity: " .. Http:Dec("v2rQuicSecurity") .. "\n"
      message = message .. "Header Ws: " .. Http:Dec("v2rWsHeader") .. "\n"
      message = message .. "v2rWsPath: " .. Http:Dec("v2rWsPath") .. [[


]]
      message = message .. "v2rCoreType: " .. Http:Dec("v2rCoreType") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "dnstt_ssh" then
      message = message .. "Tipo de DNS: " .. ehi.dnsType .. "\n"
      message = message .. "DNS Resolver Address: " .. Http:Dec("dnsttDnsResolverAddr") .. "\n"
      message = message .. "DNSTT Nameserver: " .. Http:Dec("dnsttNameserver") .. "\n"
      message = message .. "DNSTT Public Key: " .. Http:Dec("dnsttPublicKey") .. [[


]]
      message = message .. "Tipo de Túnel: " .. Http:TunnelType() .. [[


]]

   end
    gg.copyText(message, false)
    gg.toast(message .. [[

copiou, farinha?]])
    print(message)
    saveEhi(message)
  end
  os.exit()
end

function HttpInjector()
  limit = true
  gg.clearResults()
  gg.setVisible(false)
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC)
  gg.searchNumber("h 7B 22 63 6F 6E 66 69 67 45 78 70 69 72 79 54 69 6D 65 73 74", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado: configExpiryTimest")
    ehi_2 = true
  end
  if ehi_2 then
        gg.searchNumber("h 7B 22 56 32 72 54 6C 73 41 6C 70 6E 22 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
        local r = gg.getResults(1)
        if #r < 1 then
        gg.toast("Pai não encontrado: V2rTlsAlpn")
      print([[

calma barboleta]])
        ehi_3 = true
        end
        end
  if ehi_3 then
    gg.searchNumber("h 7B 22 63 6F 6E 66 69 67 49 64 65 6E 74 69 66 69 65 72 22 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: configIdentifier")
      print([[

calma barboleta]])
      print("\nimporte o arquivo novamente, espere 3 segundos e inicie o script da diversão\n\n")
      os.exit()
    end
  end
  gg.searchNumber("h7B", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1000)
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  do
    do
      for SRD1_5_, SRD1_6_ in ipairs(r) do
        r[SRD1_5_].flags = gg.TYPE_FLOAT
        r[SRD1_5_].value = "1000"
      end
    end
  end
  gg.setValues(r)
  gg.clearResults()
  parseHttpInjector(readedMem)
end

function HTTPCustom()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("::443@", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado: 443")
    hc_2 = true
  end
  if hc_2 then
    gg.searchNumber("h 3A 38 30 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 80")
      hc_3 = true
    end
  end
  if hc_3 then
    gg.searchNumber("h 3A 38 30 38 30 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 8080")
      hc_4 = true
    end
  end
  if hc_4 then
    gg.searchNumber("h 3a 32 32 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 22")
      hc_5 = true
    end
  end
  if hc_5 then
    limit = false
    gg.searchNumber("h 3a 32 32 32 32 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 2222")
      hc_6 = true
    end
  end
  if hc_6 then
    limit = false
    gg.searchNumber("h 3a 34 34 34 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 444")
      hc_7 = true
    end
  end
  if hc_7 then
    limit = false
    gg.searchNumber("h 3A 35 33 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 53")
      hc_8 = true
    end
  end
  if hc_8 then
    limit = false
    gg.searchNumber("h 55 70 67 72 61 64 65 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: Upgrade")
      hc_9 = true
    end
  end
  if hc_9 then
    limit = false
    gg.searchNumber("h 5B 73 70 6C 69 74 50 73 69 70 68 6F 6E 5D 5B 73 70 6C 69 74 50 73 69 70 68 6F 6E 5D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: splitPsiphon splitPsiphon")
      hc_10 = true
    end
  end
  if hc_10 then
    limit = false
    gg.searchNumber("h 23 20 43 6F 6E 66 69 67 20 66 6F 72 20 4F 70 65 6E 56 50 4E 20 32 2E 78", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: config for OpenVPN 2x")
      hc_11 = true
    end
  end
  if hc_11 then
    limit = false
    gg.searchNumber("h 5B 00 73 00 70 00 6C 00 69 00 74 00 43 00 6F 00 6E 00 66 00 69 00 67 00 5D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: splitConfig")
      hc_12 = true
    end
  end
  if hc_12 then
    limit = false
    gg.searchNumber("h 22 69 73 4c 6f 67 69 6e 48 77 69 64 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: isLoginHwid")
      hc_13 = true
    end
  end
  if hc_13 then
    limit = false
    gg.searchNumber("h 20 22 64 6e 73 22 3a 20 7b", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: dns")
      hc_14 = true
    end
  end
  if hc_14 then
    limit = false
    gg.searchNumber("h 5b 63 72 6c 66 5d 48 6f 73 74 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: crlf Host")
      hc_15 = true
    end
  end
  if hc_15 then
    limit = false
    gg.searchNumber("h 7B 0A 09 09 22 69 6E 62 6F 75 6E 64", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: inbound")
      hc_16 = true
    end
  end
  if hc_16 then
    limit = false
    gg.searchNumber("h 75 70 67 72 61 64 65 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: upgrade")
      hc_17 = true
    end
  end
  if hc_17 then
    limit = false
    gg.searchNumber("h 41 43 4c 20 2f 20 48 54 54 50 2f", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: ACL HTTP")
      hc_18 = true
    end
  end
  if hc_18 then
    limit = false
    gg.searchNumber("h 43 4f 4e 4e 45 43 54 20 5b", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: CONNECT")
      hc_19 = true
    end
  end
  if hc_19 then
    limit = false
    gg.searchNumber("h 48 6f 73 74 3a 5b 72 6f 74 61 74 65 3d", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: rotate")
      hc_20 = true
    end
  end
  if hc_20 then
    gg.toast("Pai não encontrado")
    print("edite a sua busca, use novas palavras chave ou recarregue o aplicativo e configuração novamente\n")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 68000)
  save(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/decrypt.txt")
  gg.clearResults()
end

function hc_ssc()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7B 22 61 62 22 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado: ab")
    ssc_2 = true
  end
  if ssc_2 then
    gg.searchNumber("h 55 70 67 72 61 64 65 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: Upgrade")
      ssc_3 = true
    end
  end
  if ssc_3 then
    gg.searchNumber("h 3A 38 30 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 80")
      ssc_4 = true
    end
  end
  if ssc_4 then
    gg.searchNumber("h 7B 0A 09 09 22 69 6E 62 6F 75 6E 64", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: inbound")
      ssc_5 = true
    end
  end
  if ssc_5 then
    gg.searchNumber("h 7B 0A 20 20 22 64 6E 73 22 3A 20 7B 0A 20 20 20 20 22 68 6F 73 74 73 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: dns hosts")
      ssc_6 = true
    end
  end
  if ssc_6 then
    gg.searchNumber("::443@", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 443")
      ssc_7 = true
    end
  end
  if ssc_7 then
    gg.searchNumber(":[crlf][crlf]", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: crlf")
      ssc_8 = true
    end
  end
  if ssc_8 then
    gg.searchNumber("h 48 6f 73 74 3a 5b 72 6f 74 61 74 65 3d", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: rotate")
      ssc_9 = true
    end
  end
  if ssc_9 then
    gg.toast("Pai não encontrado")
    print("edite a sua busca, use novas palavras chave ou recarregue o aplicativo e configuração novamente\n")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 40000)
  save(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/decrypt.txt")
  gg.clearResults()
end

function TLSTunnel()
  limit = false
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 3A 30 3A 30 3A 74 72 75 65 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado: versi")
    tls_2 = true
  end
  if tls_2 then
    limit = false
    gg.searchNumber("h 33 35 39 3A 30 3A 30", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 359 h")
      tls_3 = true
    end
  end
  if tls_3 then
    gg.searchNumber("h 00 00 7b 00 22 00 41 00 22 00 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: A")
      tls_4 = true
    end
  end
  if tls_4 then
    limit = false
    gg.searchNumber(":357:0:0:", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("357")
      tls_5 = true
    end
  end
  if tls_5 then
    gg.searchNumber("h 63 69 70 68 65 72 31 2e 64 6f 46 69 6e 61 6c 28 63 72 79 70 74 6f 29", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: cipher1 doFinal crypto")
      tls_6 = true
    end
  end
  if tls_6 then
    limit = false
    gg.searchNumber("h 75 00 70 00 77 00 73 00", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: upws")
      tls_7 = true
    end
  end
  if tls_7 then
    limit = false
    gg.searchNumber("h 55 70 67 72 61 64 65 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: Upgrade")
      tls_8 = true
    end
  end
  if tls_8 then
    limit = false
    gg.searchNumber("h 47 45 54 20 77 73", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: GET ws")
      tls_9 = true
    end
  end
  if tls_9 then
    limit = false
    gg.searchNumber("h 47 45 54 20 73 68 69", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: GET shi")
      tls_10 = true
    end
  end
  if tls_10 then
    limit = false
    gg.searchNumber("h 5b 68 6f 73 74 5d 5b 63 72 6c 66 5d", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: host crlf")
      tls_11 = true
    end
  end
  if tls_11 then
    gg.toast("Pai não encontrado")
    print("primeiro as primas.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/decrypt.txt")
  gg.clearResults()
end

function eV2ray()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7B 0A 20 20 22 69 6E 62 6F 75 6E 64", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado: inbound")
    epro_2 = true
  end
  if epro_2 then
    gg.searchNumber("h 64 6e 73 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: dns")
      epro_3 = true
    end
  end
  if epro_3 then
    gg.searchNumber("h 6f 75 74 62 6f 75 6e 64 73 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: aspas outbounds")
      epro_4 = true
    end
  end
  if epro_4 then
    gg.searchNumber("h 22 69 6e 62 6f 75 6e 64 73 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: apsas inbounds")
      epro_5 = true
    end
  end
  if epro_5 then
    gg.toast("Pai não encontrado")
    print("\ncalma, barboleta, refresque a memória, importe o arquivo novamente ou inicie a VPN se quiser")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 0x400
  end
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/decrypt.txt")
  gg.clearResults()
end

function NapsternetV()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 22 76 65 72 73 69 6f 6e 69 6e 67 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado: versioning")
    npv_2 = true
  end
  if npv_2 then
    gg.searchNumber("h 55 70 67 72 61 64 65 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: Upgrade")
      npv_3 = true
    end
  end
  if npv_3 then
    gg.searchNumber("h 7B 0A 09 09 22 69 6E 62 6F 75 6E 64", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: inbound")
      npv_4 = true
    end
  end
  if npv_4 then
    gg.searchNumber("h 70 73 69 70 68 6f 6e 43 6f 6e 66 69 67 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: psiphonConfig")
      npv_5 = true
    end
  end
  if npv_5 then
    limit = false
    gg.searchNumber("h 22 76 65 72 73 69 6f 6e 69 6e 67 22 65 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: versioning e")
      npv_6 = true
    end
  end
  if npv_6 then
    limit = false
    gg.searchNumber("h 7b 22 76 65 72 73 69 6f 6e 69 6e 67 22 3a 7b 22 63 6f 6e 66 69 67 54 79 70 65 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: versioning configType")
      npv_7 = true
    end
  end
  if npv_7 then
    gg.toast("Pai não encontrado")
    print("primeiro as primas.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/decrypt.txt")
  gg.clearResults()
end

function HATunnel()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7b 22 75 73 65 72 5f 69 64 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado: user id")
    hat_2 = true
  end
  if hat_2 then
    gg.searchNumber("h 7b 5c 22 63 6f 6e 6e 65 63 74 69 6f 6e 5f 6d 6f 64 65 5c 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: connecion mode")
      hat_3 = true
    end
  end
  if hat_3 then
    limit = false
    gg.searchNumber("h7b22757365725f696422", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: id")
      hat_4 = true
    end
  end
  if hat_4 then
    limit = false
    gg.searchNumber("h 5c 22 6f 76 65 72 72 69 64 65 5f 70 72 69 6d 61 72 79 5f 68 6f 73 74 5c", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: override primary host")
      hat_5 = true
    end
  end
  if hat_5 then
    limit = false
    gg.searchNumber("h 61 63 63 65 73 73 5f 63 6f 64 65 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: acess code")
      hat_6 = true
    end
  end
  if hat_6 then
    gg.toast("Pai não encontrado")
    print("primeiro as primas.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/decrypt.txt")
  gg.clearResults()
end

function SocksHttpPlus()
  limit = true
  gg.clearResults()
  gg.setVisible(false)
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.searchNumber("h 7b 22 69 64 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado")
    print("primeiro as primas.")
    os.exit()
  end
  gg.searchNumber("h7B", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1000)
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/decrypt.txt")
  gg.clearResults()
end

function DarkTunnel()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h537368436F6E6669674C6F636B6564C3A9537368436F6E666967", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado: SshConfigLockedeSshConfig")
    dark_2 = true
  end
  if dark_2 then
    gg.searchNumber(":SshConfigLockedéSshConfig", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: SshConfigLockedÃ©SshConfig")
      dark_3 = true
    end
  end
  if dark_3 then
    gg.searchNumber(":SshConfigLocked", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: SshConfigLocked")
      dark_4 = true
    end
  end
  if dark_4 then
    gg.searchNumber("h 53 73 68 43 6F 6E 66 69 67 4C 6F 63 6B 65 64 C3 A9 53 73 68 43 6F 6E 66 69 67", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: SshConfigLockedÃ©SshConfig")
      dark_5 = true
    end
  end
  if dark_5 then
    gg.searchNumber("h 53 73 68 43 6F 6E 66 69 67 4C 6F 63 6B 65 64 C3 A9 53 73 68 43 6F 6E 66 69 67", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: SshConfigLockedÃ©SshConfig")
      dark_6 = true
    end
  end
  if dark_6 then
    gg.searchNumber("h 53 73 68 43 6F 6E 66 69 67 4C 6F 63 6B 65 64 C3 A9 53 73 68 43 6F 6E 66 69 67", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: SshConfigLockedÃ©SshConfig")
      dark_7 = true
    end
  end
  if dark_7 then
    gg.searchNumber("h 4d 65 73 73 61 67 65 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: Message")
      dark_8 = true
    end
  end
  if dark_8 then
    gg.searchNumber("h 55 70 67 72 61 64 65 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: Upgrade")
      dark_9 = true
    end
  end
  if dark_9 then
    gg.searchNumber("h 7b 22 48 6f 73 74 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: Host")
      dark_10 = true
    end
  end
  if dark_10 then
    gg.searchNumber("h 69 6e 62 6f 75 6e 64 73", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: inbound")
      dark_11 = true
    end
  end
  if dark_11 then
    gg.toast("Pai não encontrado")
    print("primeiro as primas.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 0x400
  end
  readedMem = rwmem(r[1].address, 40000)
  save(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/decrypt.txt")
  gg.clearResults()
end

function SocksHttp()
  limit = true
  gg.clearResults()
  gg.setVisible(false)
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.searchNumber("h 7b 22 73 73 68 53 65 72 76 65 72 22 3a 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado")
    print("primeiro as primas.")
    os.exit()
  end
  gg.searchNumber("h7B", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 0x
    end
  readedMem = rwmem(r[1].address, 40000)
  save(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/decrypt.txt")
  gg.clearResults()
end

function NetModSyna()
  limit = true
  gg.clearResults()
  gg.setVisible(false)
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA )
  gg.searchNumber("h 7B 22 50 61 79 6C 6F 61 64 22 3A 7B 22 56 61 6C 75 65 22 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado")
    print("primeiro as primas.")
    os.exit()
  end
  gg.searchNumber("7Bh", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/decrypt.txt")
  gg.clearResults()
end

function RezTunnel()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7B 5C 22 50 53 49 6E 73 74 61 6C 6C 5C 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado: install")
    rez_2 = true
  end
  if rez_2 then
    gg.searchNumber("h 7b 22 50 53 49 6e 73 74 61 6c 6c 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: PSInstall 1")
      rez_3 = true
    end
  end
  if rez_3 then
    gg.searchNumber("h 50 53 49 6e 73 74 61 6c 6c 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: PSInstall 2")
      rez_4 = true
    end
  end
  if rez_4 then
    gg.searchNumber("h 48 6f 73 74 3a 5b 72 6f 74 61 74 65 3d", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado:  rotate")
      rez_5 = true
    end
  end
  if rez_5 then
    gg.searchNumber("h 7B 0A 20 20 20 20 22 56 65 72 73 69 6F 6E 22 3A 20", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: Version Config full")
      rez_6 = true
    end
  end
  if rez_6 then
    gg.searchNumber("h 53 53 48 48 6f 73 74 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: SSHHost")
      rez_7 = true
    end
  end
  if rez_7 then
    gg.searchNumber("h 55 70 67 72 61 64 65 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: Version Upgrade")
      rez_8 = true
    end
  end
  if rez_8 then
    gg.toast("Pai não encontrado")
    print("primeiro as primas.")
    os.exit()
  end
  local r = gg.getResults(1)
  if limit == true then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/decrypt.txt")
  gg.clearResults()
end

function ApkCustom()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 3A 34 34 33 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado: 443")
    acm_2 = true
  end
  if acm_2 then
    gg.searchNumber("h 55 70 67 72 61 64 65 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: Upgrade")
      acm_3 = true
    end
  end
  if acm_3 then
    gg.searchNumber("h 3A 38 30 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 80")
      acm_4 = true
    end
  end
  if acm_4 then
    limit = true
    gg.searchNumber("h 7B 0A 09 09 22 69 6E 62 6F 75 6E 64", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: inbound")
      acm_5 = true
    end
  end
  if acm_5 then
    limit = false
    gg.searchNumber("h 7B 0A 20 20 22 64 6E 73 22 3A 20 7B 0A 20 20 20 20 22 68 6F 73 74 73 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: dns hosts")
      acm_6 = true
    end
  end
  if acm_6 then
    limit = false
    gg.searchNumber("h 3A 35 33 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 53")
      acm_7 = true
    end
  end
  if acm_7 then
    limit = false
    gg.searchNumber("h 5B 73 70 6C 69 74 50 73 69 70 68 6F 6E 5D 5B 73 70 6C 69 74 50 73 69 70 68 6F 6E 5D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: splitPsiphon")
      acm_8 = true
    end
  end
  if acm_8 then
    gg.toast("Pai não encontrado")
    print("primeiro as primas.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/decrypt.txt")
  gg.clearResults()
end

function SocksIP()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h6E6577746F6F6C73776F726B732E636F6D2E736F636B7369702E7574696C732E536572536F636B73495068", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado: network sip")
    sip_2 = true
  end
  if sip_2 then
    gg.searchNumber("h 55 70 67 72 61 64 65 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: Upgrade")
      sip_3 = true
    end
  end
  if sip_3 then
    gg.searchNumber("h 73 73 68 6f 63 65 61 6e", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: sshocean")
      sip_4 = true
    end
  end
  if sip_4 then
    gg.searchNumber("h 3A 38 30 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 80")
      sip_5 = true
    end
  end
  if sip_5 then
    limit = false
    gg.searchNumber("h 7B 0A 09 09 22 69 6E 62 6F 75 6E 64", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: inbound")
      sip_6 = true
    end
  end
  if sip_6 then
    limit = false
    gg.searchNumber("h 73 70 65 65 64 79 73 73 68 2e", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: dns hosts")
      sip_7 = true
    end
  end
  if sip_7 then
    limit = false
    gg.searchNumber("h 3A 35 33 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 53")
      sip_8 = true
    end
  end
  if sip_8 then
    limit = false
    gg.searchNumber("h 47 45 54 20 77", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: GET w")
      sip_9 = true
    end
  end
  if sip_9 then
    limit = false
    gg.searchNumber("h 5b 63 72 6c 66 5d 48 6f 73 74 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: crlf host")
      sip_10 = true
    end
  end
  if sip_10 then
    limit = false
    gg.searchNumber("h 48 6f 73 74 3a 5b 72 6f 74 61 74 65 3d", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: rotate")
      sip_11 = true
    end
  end
  if sip_11 then
    limit = false
    gg.searchNumber("h 3A 34 34 33 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 443")
      sip_12 = true
    end
  end
  if sip_12 then
    gg.toast("Pai não encontrado")
    print("primeiro as primas.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 20000)
  save(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/decrypt.txt")
  gg.clearResults()
end

function StarkVPN()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7B 5C 22 63 6F 6E 66 69 67 5C 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado: config barra")
    stk_2 = true
  end
  if stk_2 then
    gg.searchNumber("h 63 6f 6e 66 69 67 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: config aspas")
      stk_3 = true
    end
  end
  if stk_3 then
    limit = false
    gg.searchNumber("h 63 6f 6e 6e 65 63 74 69 6f 6e 5f 6d 6f 64 65 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: connection mode")
      stk_4 = true
    end
  end
  if stk_4 then
    gg.toast("Pai não encontrado")
    print("primeiro as primas.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/decrypt.txt")
  gg.clearResults()
end

function configjson()
limit = true
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7B 09 22 56 65 72 73 69 6F 6E 22 3A 20 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado: Version")
    json_2 = true
  end
  if json_2 then
    gg.searchNumber("h 7B 0A 20 20 20 20 22 56 65 72 73 69 6F 6E", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: Version")
      json_3 = true
    end
  end
  if json_3 then
    gg.searchNumber("h 7b a 9 22 56 65 72 73 69 6f 6e 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: Version")
      json_4 = true
    end
  end
  if json_4 then
    gg.searchNumber("h 7b a 20 20 22 56 65 72 73 69 6f 6e 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: Version")
      json_5 = true
    end
  end
  if json_5 then
    gg.searchNumber("h 22 56 65 72 73 69", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: Versi")
      json_6 = true
    end
  end
  if json_6 then
  limit = false
    gg.searchNumber("h 7B 0A 20 20 22 56 65 72 73 69 6F 6E 22 3A 20 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: version aspas")
      json_7 = true
    end
  end
  if json_7 then
    gg.searchNumber("h 7B 5C 22 56 65 72 73 69 6F 6E 5C 22 3A 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: version barra")
      json_8 = true
    end
  end
  if json_8 then
    gg.searchNumber("h 22 2c 22 52 65 6c 65 61 73 65 4e 6f 74 65 73 22 3a 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: ReleaseNotes")
      json_9 = true
    end
  end
  if json_9 then
    gg.toast("Pai não encontrado")
    print("primeiro as primas.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 0x
  end
  readedMem = rwmem(r[1].address, 150000)
  save(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/decrypt.txt")
  gg.clearResults()
end

function TunnelCat()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7B 5C 22 65 78 70 6F 72 74 44 65 74 61 69 6C 73 5C 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado: export D")
    cat_2 = true
  end
  if cat_2 then
    gg.searchNumber("h 7b 5c 22 65 78 70 6f 72 74 44 65 74 61 69 6c 73 5c 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: exportDetails")
      cat_3 = true
    end
  end
  if cat_3 then
    gg.searchNumber(";exportDetails", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: exportDe")
      cat_4 = true
    end
  end
  if cat_4 then
    gg.searchNumber("h 55 70 67 72 61 64 65 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: Upgrade")
      cat_5 = true
    end
  end
  if cat_5 then
    gg.searchNumber("h 69 6e 62 6f 75 6e 64 73", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: inbound")
      cat_6 = true
    end
  end
  if cat_6 then
    gg.toast("Pai não encontrado")
    print("primeiro as primas.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 20000)
  save(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/decrypt.txt")
  gg.clearResults()
end

function v2rayHybrid()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7B 5C 22 61 64 64 65 64 54 69 6D 65 5C 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado: addedtime")
    hy_2 = true
  end
  if hy_2 then
    gg.searchNumber("h 7b 5c 22 61 64 64 65 64 54 69 6d 65 5c 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: added Time")
      hy_3 = true
    end
  end
  if hy_3 then
    gg.searchNumber(";addedTime", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: addedTime")
      hy_4 = true
    end
  end
  if hy_4 then
    gg.searchNumber("h 55 70 67 72 61 64 65 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: Upgrade")
      cat_5 = true
    end
  end
  if hy_5 then
    gg.searchNumber("h 69 6e 62 6f 75 6e 64 73", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: inbound")
      hy_6 = true
    end
  end
  if hy_6 then
    gg.toast("Pai não encontrado")
    print("primeiro as primas.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 20000)
  save(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/decrypt.txt")
  gg.clearResults()
end

function ARMod()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber(":[{\"AlterID\"", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado: alter id")
    armo_2 = true
  end
  if armo_2 then
    gg.searchNumber("h 5b 7b 5c 22 41 6c 74 65 72 49 44 5c 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: alter")
      armo_3 = true
    end
  end
  if armo_3 then
    gg.searchNumber(";AlterID", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: addedTime")
      armo_4 = true
    end
  end
  if armo_4 then
    gg.searchNumber("h 55 70 67 72 61 64 65 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: Upgrade")
      armo_5 = true
    end
  end
  if armo_5 then
    gg.searchNumber("h 69 6e 62 6f 75 6e 64 73", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: inbound")
      armo_6 = true
    end
  end
  if armo_6 then
    gg.toast("Pai não encontrado")
    print("primeiro as primas.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 20000)
  save(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/decrypt.txt")
  gg.clearResults()
end

function WeTunnel()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7B 5C 22 50 53 49 6E 73 74 61 6C 6C 5C 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado: install")
    we_2 = true
  end
  if we_2 then
    gg.searchNumber("h 7b 22 50 53 49 6e 73 74 61 6c 6c 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: PSInstall 1")
      we_3 = true
    end
  end
  if we_3 then
    gg.searchNumber("h 50 53 49 6e 73 74 61 6c 6c 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: PSInstall 2")
      we_4 = true
    end
  end
  if we_4 then
    gg.searchNumber("h 7B 5C 22 50 53 49 6E 73 74 61 6C 6C 5C 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado:  install 2")
      we_5 = true
    end
  end
  if we_5 then
    gg.searchNumber("h 7B 0A 20 20 20 20 22 56 65 72 73 69 6F 6E 22 3A 20", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: Version Config full")
      we_6 = true
    end
  end
  if we_6 then
    gg.searchNumber("h 53 53 48 48 6f 73 74 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: SSHHost")
      we_7 = true
    end
  end
  if we_7 then
    gg.searchNumber("h 55 70 67 72 61 64 65 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: Version Upgrade")
      we_8 = true
    end
  end
  if we_8 then
    gg.toast("Pai não encontrado")
    print("primeiro as primas.")
    os.exit()
  end
  local r = gg.getResults(1)
  if limit == true then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/decrypt.txt")
  gg.clearResults()
end

function XrayPB()
  gg.clearResults()
  gg.setVisible(false)
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.searchNumber(";{\"addedTime\"", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado: addedTime")
    pb_2 = true
  end
  if pb_2 then
    gg.searchNumber("h 7B 5C 22 61 64 64 65 64 54 69 6D 65 5C 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: added")
      pb_3 = true
    end
  end
  if pb_3 then
    gg.toast("Pai não encontrado")
    print("primeiro as primas.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == true then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 20000)
  save(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/decrypt.txt")
  gg.clearResults()
end

function OpenTunnel()
  gg.clearResults()
  gg.setVisible(false)
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.searchNumber("h 3C 2F 65 6E 74 72 79 3E 0A 3C 65 6E 74 72 79 20 6B 65 79 3D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado: addedTime")
    tnl_2 = true
  end
  if tnl_2 then
    gg.searchNumber("h 3C 2F 65 6E 74 72 79 3E 0A 3C 65 6E 74 72 79 20 6B 65 79 3D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: added")
      tnl_3 = true
    end
  end
  if tnl_3 then
    gg.toast("Pai não encontrado")
    print("primeiro as primas.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == true then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 20000)
  save(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/decrypt.txt")
  gg.clearResults()
end

function sopass()
  gg.clearResults()
  gg.setVisible(false)
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.searchNumber(";{\"Password\"", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado: pass")
    efbd_2 = true
  end
  if efbd_2 then
    gg.searchNumber("h 7b 5c 22 50 61 73 73 77 6f 72 64 5c 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: Password barra")
      efbd_3 = true
    end
  end
  if efbd_3 then
    gg.toast("Pai não encontrado")
    print("primeiro as primas.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == true then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 40000)
  save(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/decrypt.txt")
  gg.clearResults()
end

function kobra()
  gg.clearResults()
  gg.setVisible(false)
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.searchNumber(":Servidores", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado: servidores")
    kobras_2 = true
  end
  if kobras_2 then
    gg.searchNumber(":Upgrade:", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: Upgrade")
      kobras_3 = true
    end
  end
  if kobras_3 then
    gg.toast("Pai não encontrado")
    print("primeiro as primas.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/decrypt.txt")
  gg.clearResults()
  end

function kobras()
  limit = true
  gg.clearResults()
  gg.setVisible(false)
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.searchNumber("h 7B 0A 20 20 20 20 22 53 65 72 76 69 64 6F 72 65 73 22 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado")
    print("primeiro as primas.")
    os.exit()
  end
  gg.searchNumber("h7B", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1000)
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/decrypt.txt")
  gg.clearResults()
end
  
if app == "com.evozi.injector" then
  HttpInjector()
elseif app == "com.evozi.injector.lite" then
  HttpInjector()
elseif app == "xyz.easypro.httpcustom" then
  HTTPCustom()
elseif app == "com.tlsvpn.tlstunnel" then
  TLSTunnel()
elseif app == "dev.epro.ssc" then
  hc_ssc()
elseif app == "dev.epro.e_v2ray" then
  eV2ray()
elseif app == "com.napsternetlabs.napsternetv" then
  NapsternetV()
elseif app == "com.newtoolsworks.sockstunnel" then
  SocksIP()
elseif app == "com.slipkprojects.sockshttp" then
  SocksHttp()
elseif app == "com.slipkprojects.sksplus" then
  SocksHttpPlus()
elseif app == "com.hatunnel.plus" then
  HATunnel()
elseif app == "team.dev.epro.apkcustom" then
  ApkCustom()
elseif app == "com.techoragontcptun" then
  RezTunnel()
elseif app == "net.darktunnel.app" then
  DarkTunnel()
elseif app == "com.tunnelcatvpn.android" then
  TunnelCat()
elseif app == "com.v2ray.hybrid" then
  v2rayHybrid()
elseif app == "com.one.vpnapp" then
  configjson()
  elseif app == "mau.miracle.mau" then
  configjson()
  elseif app == "onnet.miracle" then
  configjson()
  elseif app == "com.conecta4g.vpn" then
  configjson()
elseif app == "com.hybrid.tunnel" then
  configjson()
elseif app == "com.gdmnetpro.vpn" then
  jsonum()
elseif app == "com.trrorcloud.br" then
  configjson()
elseif app == "com.lockproig.vpn" then
  configjson()
elseif app == "app.hackkcah.xyz" then
  configjson()
elseif app == "com.handy.vpn" then
  configjson()
elseif app == "com.socketclay.http" then
  configjson()
elseif app == "com.internetinfinito.http" then
  configjson()
elseif app == "com.socketconexion.vps" then
  configjson()
elseif app == "com.fenix.vpn" then
  configjson()
elseif app == "com.turbovpn.app" then
  configjson()
elseif app == "com.mastercloudvpn.http" then
  configjson()
elseif app == "com.godiesan.vpn" then
  configjson()
elseif app == "com.cloud.focus" then
  configjson()
  elseif app == "com.upnet4gbr.telecom" then
  configjson()
  elseif app == "com.internetvpn.vpnff" then
  configjson()
elseif app == "com.doriaxvpn.http" then
  configjson()
elseif app == "com.sockslitepro.net" then
  socksliteP()
elseif app == "com.mnjnet.rev" then
  configjson()
elseif app == "br.com.litesshbrasil" then
  jsonum()
  elseif app == "com.hunter.net" then
  revhunter()
elseif app == "istark.vpn.starkreloaded" then
  StarkVPN()
elseif app == "com.Internetshub.socks" then
  WeTunnel()
elseif app == "com.sihiver.xraypb" then
  XrayPB()
elseif app == "com.opentunnel.app" then
  OpenTunnel()
elseif app == "com.artunnel57" then
  ARMod()
elseif app == "com.ar.dev.bdvpninject" then
  sopass()
elseif app == "com.ef.dev.eftunnel" then
  sopass()
  elseif app == "kobras.vpn.ultra.max.miguel.pro" then
  kobras()
elseif app == "com.netmod.syna" then
  NetModSyna()
else
  gg.toast("não me deixe vê")
  print("\nhoje não é o seu dia de sorte\n\n")
end
gg.clearResults()
os.exit()
pcall(load(x9C))
prima()
end

function hc()

limit = false
targetInfo = gg.getTargetInfo()
app = targetInfo.packageName
local utf8 = {}
local bit = {
  data32 = {}
}
do
  do
    for SRD1_5_ = 1, 32 do
      bit.data32[SRD1_5_] = 2 ^ (32 - SRD1_5_)
    end
  end
end
local toby = string.byte
function utf8.charbytes(s, i)
  i = i or 1
  local c = string.byte(s, i)
  if c > 0 and c <= 127 then
    do return 1 end
    return
  end
  if c >= 194 and c <= 223 then
    do return 2 end
    return
  end
  if c >= 224 and c <= 239 then
    do return 3 end
    return
  end
  if c >= 240 and c <= 244 then
    return 4
  end
  return 1
end

local ded
function bit:d2b(arg)
  if arg == nil then
    return
  end
  local tr, c = {}, arg < 0
  if c then
    arg = 0 - arg
  end
  do
    do
      for SRD1_7_ = 1, 32 do
        if arg >= self.data32[SRD1_7_] then
          tr[SRD1_7_] = 1
          arg = arg - self.data32[SRD1_7_]
        else
          tr[SRD1_7_] = 0
        end
      end
    end
  end
  if c then
    tr = self:_bnot(tr)
    tr = self:b2d(tr) + 1
    tr = self:d2b(tr)
  end
  return tr
end

function bit:b2d(arg, neg)
  local nr = 0
  if arg[1] == 1 and neg == true then
    arg = self:_bnot(arg)
    nr = self:b2d(arg) + 1
    nr = 0 - nr
  else
    do
      for SRD1_7_ = 1, 32 do
        if arg[SRD1_7_] == 1 then
          nr = nr + 2 ^ (32 - SRD1_7_)
        end
      end
    end
  end
  return nr
end

function bit:_and(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 and op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_or(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 or op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_xor(a, b)
  local op1 = self:d2b(a)
  if op1 == nil then
    return nil
  end
  local op2 = self:d2b(b)
  if op2 == nil then
    return nil
  end
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == op2[SRD1_9_] then
          r[SRD1_9_] = 0
        else
          r[SRD1_9_] = 1
        end
      end
    end
  end
  return self:b2d(r, true)
end

local switch = {
  [1] = function(s, pos)
    local c1 = toby(s, pos)
    return c1
  end
  ,
  [2] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local int1 = bit:_and(31, c1)
    local int2 = bit:_and(63, c2)
    return bit:_or(bit:_lshift(int1, 6), int2)
  end
  ,
  [3] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local o2 = bit:_or(bit:_lshift(int1, 12), bit:_lshift(int2, 6))
    local dt = bit:_or(o2, int3)
    return dt
  end
  ,
  [4] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local c4 = toby(s, pos + 3)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local int4 = bit:_and(63, c4)
    local o2 = bit:_or(bit:_lshift(int1, 18), bit:_lshift(int2, 12))
    local o3 = bit:_or(o2, bit:_lshift(int3, 6))
    local o4 = bit:_or(o3, int4)
    return o4
  end
  
}
function bit:_bnot(op1)
  local r = {}
  do
    do
      for SRD1_6_ = 1, 32 do
        if op1[SRD1_6_] == 1 then
          r[SRD1_6_] = 0
        else
          r[SRD1_6_] = 1
        end
      end
    end
  end
  return r
end

function bit:_not(a)
  local op1 = self:d2b(a)
  local r = self:_bnot(op1)
  return self:b2d(r, true)
end

function bit:charCodeAt(s)
  local pos, int, H, L = 1, 0, 0, 0
  local slen = string.len(s)
  local allByte = {}
  while pos <= slen do
    local tLen = utf8.charbytes(s, pos)
    if tLen >= 1 and tLen <= 4 then
      if tLen == 4 then
        int = switch[4](s, pos)
        H = math.floor((int - 65536) / 1024) + 55296
        L = (int - 65536) % 1024 + 56320
        table.insert(allByte, H)
        table.insert(allByte, L)
      else
        int = switch[tLen](s, pos)
        table.insert(allByte, int)
      end
    end
    pos = pos + tLen
  end
  return allByte
end

function bit:_rshift(a, n)
  local r = 0
  if a < 0 then
    r = 0 - self:_frshift(0 - a, n)
  elseif a >= 0 then
    r = self:_frshift(a, n)
  end
  return r
end

function bit:_frshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  local left = 32 - n
  if n < 32 and n > 0 then
    do
      for SRD1_9_ = left, 1, -1 do
        r[SRD1_9_ + n] = op1[SRD1_9_]
      end
    end
  end
  return self:b2d(r)
end

function bit:_lshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  if n < 32 and n > 0 then
    do
      for SRD1_8_ = n, 31 do
        r[SRD1_8_ - n + 1] = op1[SRD1_8_ + 1]
      end
    end
  end
  return self:b2d(r, true)
end

function trim(s)
  return s:match("^%s*(.*)"):match("(.-)%s*$")
end

local json = {}
local kind_of = function(obj)
  if type(obj) ~= "table" then
    return type(obj)
  end
  local i = 1
  do
    do
      for SRD1_5_ in pairs(obj) do
        if obj[i] ~= nil then
          i = i + 1
        else
          return "table"
        end
      end
    end
  end
  if i == 1 then
    do return "table" end
    return
  end
  return "array"
end

local escape_str = function(s)
  local in_char = {
    "\\",
    "\"",
    "/",
    "\b",
    "\f",
    "\n",
    "\r",
    "\t"
  }
  local out_char = {
    "\\",
    "\"",
    "/",
    "b",
    "f",
    "n",
    "r",
    "t"
  }
  do
    do
      for SRD1_6_, SRD1_7_ in ipairs(in_char) do
        s = s:gsub(SRD1_7_, "\\" .. out_char[SRD1_6_])
      end
    end
  end
  return s
end

local skip_delim = function(str, pos, delim, err_if_missing)
  pos = pos + #str:match("^%s*", pos)
  if str:sub(pos, pos) ~= delim then
    if err_if_missing then
      error("Esperado " .. delim .. " posição próxima " .. pos)
    end
    return pos, false
  end
  return pos + 1, true
end

local function parse_str_val(str, pos, val)
  val = val or ""
  local early_end_error = "Fim da entrada encontrado durante a análise da string."
  if pos > #str then
    error(early_end_error)
  end
  local c = str:sub(pos, pos)
  if c == "\"" then
    return val, pos + 1
  end
  if c ~= "\\" then
    return parse_str_val(str, pos + 1, val .. c)
  end
  local esc_map = {
    b = "\b",
    f = "\f",
    n = "\n",
    r = "\r",
    t = "\t"
  }
  local nextc = str:sub(pos + 1, pos + 1)
  if not nextc then
    error(early_end_error)
  end
  return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

local parse_num_val = function(str, pos)
  local num_str = str:match("^-?%d+%.?%d*[eE]?[+-]?%d*", pos)
  local val = tonumber(num_str)
  if not val then
    error("Erro ao analisar o número na posição " .. pos .. ".")
  end
  return val, pos + #num_str
end

function json.stringify(obj, as_key)
  local s = {}
  local kind = kind_of(obj)
  if kind == "array" then
    if as_key then
      error("Não é possível codificar array como chave.")
    end
    s[#s + 1] = "["
    do
      do
        for SRD1_7_, SRD1_8_ in ipairs(obj) do
          if SRD1_7_ > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "]"
  elseif kind == "table" then
    if as_key then
      error("Não é possível codificar a tabela como chave.")
    end
    s[#s + 1] = "{"
    do
      do
        for SRD1_7_, SRD1_8_ in pairs(obj) do
          if #s > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_7_, true)
          s[#s + 1] = ":"
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "}"
  else
    if kind == "string" then
      do return "\"" .. escape_str(obj) .. "\"" end
      return
    end
    if kind == "number" then
      if as_key then
        return "\"" .. tostring(obj) .. "\""
      end
      do return tostring(obj) end
      return
    end
    if kind == "boolean" then
      do return tostring(obj) end
      return
    end
    if kind == "nil" then
      do return "null" end
      return
    end
    error("tipo unjsonificável,: " .. kind .. ".")
  end
  return table.concat(s)
end

json.null = {}
function json.parse(str, pos, end_delim)
  pos = pos or 1
  if pos > #str then
    error("Atingiu o fim inesperado da entrada ")
  end
  local pos = pos + #str:match("^%s*", pos)
  local first = str:sub(pos, pos)
  if first == "{" then
    do
      local obj, key, delim_found = {}, true, true
      pos = pos + 1
      while true do
        key, pos = json.parse(str, pos, "}")
        if key == nil then
          return obj, pos
        end
        if not delim_found then
          error("Vírgula faltando entre os itens do objeto.")
        end
        pos = skip_delim(str, pos, ":", true)
        obj[key], pos = json.parse(str, pos)
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "[" then
    do
      local arr, val, delim_found = {}, true, true
      pos = pos + 1
      while true do
        val, pos = json.parse(str, pos, "]")
        if val == nil then
          return arr, pos
        end
        if not delim_found then
          error("Falta vírgula entre os itens do array.")
        end
        arr[#arr + 1] = val
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "\"" then
    do return parse_str_val(str, pos + 1) end
    return
  end
  if first == "-" or first:match("%d") then
    do return parse_num_val(str, pos) end
    return
  end
  if first == end_delim then
    do return nil, pos + 1 end
    return
  end
  do
    local literals = {
      ["true"] = true,
      ["false"] = false,
      null = json.null
    }
    do
      do
        for SRD1_9_, SRD1_10_ in pairs(literals) do
          local lit_end = pos + #SRD1_9_ - 1
          if str:sub(pos, lit_end) == SRD1_9_ then
            return SRD1_10_, lit_end + 1
          end
        end
      end
    end
    local pos_info_str = "position " .. pos .. ": " .. str:sub(pos, pos + 10)
    error("Sintaxe json inválida começando em " .. pos_info_str)
  end
end

function enc(data, b)
  return (data:gsub(".", function(x)
    local r, b = "", x:byte()
    do
      do
        for SRD1_6_ = 8, 1, -1 do
          r = r .. (b % 2 ^ SRD1_6_ - b % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
    if #x < 6 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 6 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (6 - SRD1_5_) or 0)
        end
      end
    end
    return b:sub(c + 1, c + 1)
  end
  ) .. ({
    "",
    "??",
    "?"
  })[#data % 3 + 1]
end

function dec(data, b)
  data = string.gsub(data, "[^" .. b .. "=]", "")
  return (data:gsub(".", function(x)
    if x == "?" then
      return ""
    end
    local r, f = "", b:find(x) - 1
    do
      do
        for SRD1_6_ = 6, 1, -1 do
          r = r .. (f % 2 ^ SRD1_6_ - f % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
    if #x ~= 8 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 8 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (8 - SRD1_5_) or 0)
        end
      end
    end
    return string.char(c)
  end
  ))
end

function rwmem(Address, SizeOrBuffer)
  assert(Address ~= nil, "[rwmem]: error, endereço fornecido é nulo.")
  _rw = {}
  if type(SizeOrBuffer) == "number" then
    _ = ""
    do
      do
        for SRD1_5_ = 1, SizeOrBuffer do
          _rw[SRD1_5_] = {
            address = Address - 1 + SRD1_5_,
            flags = gg.TYPE_BYTE
          }
        end
      end
    end
    do
      do
        for SRD1_5_, SRD1_6_ in ipairs(gg.getValues(_rw)) do
          if SRD1_6_.value == 0 and limit == true then
            return _
          end
          _ = _ .. string.format("%02X", SRD1_6_.value & 255)
        end
      end
    end
    return _
  end
  Byte = {}
  SizeOrBuffer:gsub("..", function(x)
    Byte[#Byte + 1] = x
    _rw[#Byte] = {
      address = Address - 1 + #Byte,
      flags = gg.TYPE_BYTE,
      value = x .. "h"
    }
  end
  )
  gg.setValues(_rw)
end

function hexdecode(hex)
  return (hex:gsub("%x%x", function(digits)
    return string.char(tonumber(digits, 16))
  end
  ))
end

function hexencode(str)
  return (str:gsub(".", function(char)
    return string.format("%2x", char:byte())
  end
  ))
end

function Dec2Hex(nValue)
  nHexVal = string.format("%X", nValue)
  sHexVal = nHexVal .. ""
  return sHexVal
end

function ToInteger(number)
  return math.floor(tonumber(number) or error("Não foi possível transmitir '" .. tostring(number) .. "' enumerar.'"))
end

function conta(data)
  io.open(gg.EXT_STORAGE .. "/conta_hc.txt", "w"):write(data)
  gg.toast("te peguei Lionel Richie!")
end

function save2(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(json.stringify(data))
  gg.toast("te peguei Lionel Richie!")
end

function hc(data)
  io.open(gg.EXT_STORAGE .. "/hc.txt", "w"):write(data)
  gg.toast("te peguei Lionel Richie!")
end

function v2json(data)
  io.open(gg.EXT_STORAGE .. "/v2ray.txt", "w"):write(data)
end

function contahc()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 3A 34 34 33 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado: 443")
    hc_2 = true
  end
  if hc_2 then
  limit = false
    gg.searchNumber("h 3A 38 30 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 80")
      hc_3 = true
    end
  end
  if hc_3 then
  limit = false
    gg.searchNumber("h 3A 38 30 38 30 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 8080")
      hc_4 = true
    end
  end
  if hc_4 then
  limit = false
    gg.searchNumber("h 3a 32 32 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 22")
      hc_5 = true
    end
  end
  if hc_5 then
    limit = false
    gg.searchNumber("h 3a 32 32 32 32 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 2222")
      hc_6 = true
    end
  end
  if hc_6 then
    limit = false
    gg.searchNumber("h 3a 34 34 34 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 444")
      hc_7 = true
    end
  end
  if hc_7 then
    limit = false
    gg.searchNumber("h 3A 35 33 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 53")
      hc_8 = true
    end
  end
  if hc_8 then
    limit = false
    gg.searchNumber("h 3a 31 31 39 34 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 1194")
      hc_9 = true
    end
  end
  if hc_9 then
    limit = false
    gg.searchNumber("h 3a 38 37 39 39 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 8799")
      hc_10 = true
    end
  end
  if hc_10 then
    limit = false
    gg.searchNumber("h 3a 38 30 38 38 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 8088")
      hc_11 = true
    end
  end
  if hc_11 then
    limit = false
    gg.searchNumber("h 3a 32 30 35 32 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 2052")
      hc_12 = true
    end
  end
  if hc_12 then
    limit = false
    gg.searchNumber("h 3a 32 30 35 32 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 143")
      hc_13 = true
    end
  end
  if hc_13 then
    limit = false
    gg.searchNumber("h 3a 32 30 38 32 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 2082")
      hc_14 = true
    end
  end
  if hc_14 then
    limit = false
    gg.searchNumber("h 3a 34 34 32 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: 442")
      hc_15 = true
    end
  end
  if hc_15 then
    limit = false
    gg.searchNumber("h 2e 6d 79 2e 69 64 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: my id")
      hc_16 = true
    end
  end
  if hc_16 then
    limit = false
    gg.searchNumber("h 2e 6f 6e 6c 69 6e 65 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: online")
      hc_17 = true
    end
  end
  if hc_17 then
    limit = false
    gg.searchNumber("h 2e 6e 65 74 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: net")
      hc_18 = true
    end
  end
  if hc_18 then
    limit = false
    gg.searchNumber("h 2e 6d 6c 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: ml")
      hc_19 = true
    end
  end
  if hc_19 then
    limit = false
    gg.searchNumber("h 2e 63 6c 6f 75 64 66 72 6f 6e 74 2e 6e 65 74 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: cloudfront")
      hc_20 = true
    end
  end
  if hc_20 then
    gg.toast("Pai não encontrado")
    print("edite a sua busca, use novas palavras chave ou recarregue o aplicativo e configuração novamente\n")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 1000
  end
  readedMem = rwmem(r[1].address, 10000)
  conta(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/conta_hc.txt")
  gg.clearResults()
end
  
if app == "xyz.easypro.httpcustom" then
  contahc()
elseif app == "xyz.easypro.httpcustom" then
  contahc()
else
  gg.toast("kikou sem querer")
  print("\nqual será o meu desafio de hoje?\n\n")
end
gg.clearResults()
pcall(load(Payload))
prima()
end

function Payload()

limit = false

local utf8 = {}
local bit = {
  data32 = {}
}
do
  do
    for SRD1_5_ = 1, 32 do
      bit.data32[SRD1_5_] = 2 ^ (32 - SRD1_5_)
    end
  end
end
local toby = string.byte
function utf8.charbytes(s, i)
  i = i or 1
  local c = string.byte(s, i)
  if c > 0 and c <= 127 then
    do return 1 end
    return
  end
  if c >= 194 and c <= 223 then
    do return 2 end
    return
  end
  if c >= 224 and c <= 239 then
    do return 3 end
    return
  end
  if c >= 240 and c <= 244 then
    return 4
  end
  return 1
end

local ded
function bit:d2b(arg)
  if arg == nil then
    return
  end
  local tr, c = {}, arg < 0
  if c then
    arg = 0 - arg
  end
  do
    do
      for SRD1_7_ = 1, 32 do
        if arg >= self.data32[SRD1_7_] then
          tr[SRD1_7_] = 1
          arg = arg - self.data32[SRD1_7_]
        else
          tr[SRD1_7_] = 0
        end
      end
    end
  end
  if c then
    tr = self:_bnot(tr)
    tr = self:b2d(tr) + 1
    tr = self:d2b(tr)
  end
  return tr
end

function bit:b2d(arg, neg)
  local nr = 0
  if arg[1] == 1 and neg == true then
    arg = self:_bnot(arg)
    nr = self:b2d(arg) + 1
    nr = 0 - nr
  else
    do
      for SRD1_7_ = 1, 32 do
        if arg[SRD1_7_] == 1 then
          nr = nr + 2 ^ (32 - SRD1_7_)
        end
      end
    end
  end
  return nr
end

function bit:_and(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 and op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_or(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 or op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_xor(a, b)
  local op1 = self:d2b(a)
  if op1 == nil then
    return nil
  end
  local op2 = self:d2b(b)
  if op2 == nil then
    return nil
  end
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == op2[SRD1_9_] then
          r[SRD1_9_] = 0
        else
          r[SRD1_9_] = 1
        end
      end
    end
  end
  return self:b2d(r, true)
end

local switch = {
  [1] = function(s, pos)
    local c1 = toby(s, pos)
    return c1
  end
  ,
  [2] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local int1 = bit:_and(31, c1)
    local int2 = bit:_and(63, c2)
    return bit:_or(bit:_lshift(int1, 6), int2)
  end
  ,
  [3] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local o2 = bit:_or(bit:_lshift(int1, 12), bit:_lshift(int2, 6))
    local dt = bit:_or(o2, int3)
    return dt
  end
  ,
  [4] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local c4 = toby(s, pos + 3)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local int4 = bit:_and(63, c4)
    local o2 = bit:_or(bit:_lshift(int1, 18), bit:_lshift(int2, 12))
    local o3 = bit:_or(o2, bit:_lshift(int3, 6))
    local o4 = bit:_or(o3, int4)
    return o4
  end
  
}
function bit:_bnot(op1)
  local r = {}
  do
    do
      for SRD1_6_ = 1, 32 do
        if op1[SRD1_6_] == 1 then
          r[SRD1_6_] = 0
        else
          r[SRD1_6_] = 1
        end
      end
    end
  end
  return r
end

function bit:_not(a)
  local op1 = self:d2b(a)
  local r = self:_bnot(op1)
  return self:b2d(r, true)
end

function bit:charCodeAt(s)
  local pos, int, H, L = 1, 0, 0, 0
  local slen = string.len(s)
  local allByte = {}
  while pos <= slen do
    local tLen = utf8.charbytes(s, pos)
    if tLen >= 1 and tLen <= 4 then
      if tLen == 4 then
        int = switch[4](s, pos)
        H = math.floor((int - 65536) / 1024) + 55296
        L = (int - 65536) % 1024 + 56320
        table.insert(allByte, H)
        table.insert(allByte, L)
      else
        int = switch[tLen](s, pos)
        table.insert(allByte, int)
      end
    end
    pos = pos + tLen
  end
  return allByte
end

function bit:_rshift(a, n)
  local r = 0
  if a < 0 then
    r = 0 - self:_frshift(0 - a, n)
  elseif a >= 0 then
    r = self:_frshift(a, n)
  end
  return r
end

function bit:_frshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  local left = 32 - n
  if n < 32 and n > 0 then
    do
      for SRD1_9_ = left, 1, -1 do
        r[SRD1_9_ + n] = op1[SRD1_9_]
      end
    end
  end
  return self:b2d(r)
end

function bit:_lshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  if n < 32 and n > 0 then
    do
      for SRD1_8_ = n, 31 do
        r[SRD1_8_ - n + 1] = op1[SRD1_8_ + 1]
      end
    end
  end
  return self:b2d(r, true)
end

function trim(s)
  return s:match("^%s*(.*)"):match("(.-)%s*$")
end

local json = {}
local kind_of = function(obj)
  if type(obj) ~= "table" then
    return type(obj)
  end
  local i = 1
  do
    do
      for SRD1_5_ in pairs(obj) do
        if obj[i] ~= nil then
          i = i + 1
        else
          return "table"
        end
      end
    end
  end
  if i == 1 then
    do return "table" end
    return
  end
  return "array"
end

local escape_str = function(s)
  local in_char = {
    "\\",
    "\"",
    "/",
    "\b",
    "\f",
    "\n",
    "\r",
    "\t"
  }
  local out_char = {
    "\\",
    "\"",
    "/",
    "b",
    "f",
    "n",
    "r",
    "t"
  }
  do
    do
      for SRD1_6_, SRD1_7_ in ipairs(in_char) do
        s = s:gsub(SRD1_7_, "\\" .. out_char[SRD1_6_])
      end
    end
  end
  return s
end

local skip_delim = function(str, pos, delim, err_if_missing)
  pos = pos + #str:match("^%s*", pos)
  if str:sub(pos, pos) ~= delim then
    if err_if_missing then
      error("Esperado " .. delim .. " posição próxima " .. pos)
    end
    return pos, false
  end
  return pos + 1, true
end

local function parse_str_val(str, pos, val)
  val = val or ""
  local early_end_error = "Fim da entrada encontrado durante a análise da string."
  if pos > #str then
    error(early_end_error)
  end
  local c = str:sub(pos, pos)
  if c == "\"" then
    return val, pos + 1
  end
  if c ~= "\\" then
    return parse_str_val(str, pos + 1, val .. c)
  end
  local esc_map = {
    b = "\b",
    f = "\f",
    n = "\n",
    r = "\r",
    t = "\t"
  }
  local nextc = str:sub(pos + 1, pos + 1)
  if not nextc then
    error(early_end_error)
  end
  return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

local parse_num_val = function(str, pos)
  local num_str = str:match("^-?%d+%.?%d*[eE]?[+-]?%d*", pos)
  local val = tonumber(num_str)
  if not val then
    error("Erro ao analisar o número na posição " .. pos .. ".")
  end
  return val, pos + #num_str
end

function json.stringify(obj, as_key)
  local s = {}
  local kind = kind_of(obj)
  if kind == "array" then
    if as_key then
      error("Não é possível codificar array como chave.")
    end
    s[#s + 1] = "["
    do
      do
        for SRD1_7_, SRD1_8_ in ipairs(obj) do
          if SRD1_7_ > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "]"
  elseif kind == "table" then
    if as_key then
      error("Não é possível codificar a tabela como chave.")
    end
    s[#s + 1] = "{"
    do
      do
        for SRD1_7_, SRD1_8_ in pairs(obj) do
          if #s > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_7_, true)
          s[#s + 1] = ":"
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "}"
  else
    if kind == "string" then
      do return "\"" .. escape_str(obj) .. "\"" end
      return
    end
    if kind == "number" then
      if as_key then
        return "\"" .. tostring(obj) .. "\""
      end
      do return tostring(obj) end
      return
    end
    if kind == "boolean" then
      do return tostring(obj) end
      return
    end
    if kind == "nil" then
      do return "null" end
      return
    end
    error("tipo unjsonificável,: " .. kind .. ".")
  end
  return table.concat(s)
end

json.null = {}
function json.parse(str, pos, end_delim)
  pos = pos or 1
  if pos > #str then
    error("Atingiu o fim inesperado da entrada ")
  end
  local pos = pos + #str:match("^%s*", pos)
  local first = str:sub(pos, pos)
  if first == "{" then
    do
      local obj, key, delim_found = {}, true, true
      pos = pos + 1
      while true do
        key, pos = json.parse(str, pos, "}")
        if key == nil then
          return obj, pos
        end
        if not delim_found then
          error("Vírgula faltando entre os itens do objeto.")
        end
        pos = skip_delim(str, pos, ":", true)
        obj[key], pos = json.parse(str, pos)
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "[" then
    do
      local arr, val, delim_found = {}, true, true
      pos = pos + 1
      while true do
        val, pos = json.parse(str, pos, "]")
        if val == nil then
          return arr, pos
        end
        if not delim_found then
          error("Falta vírgula entre os itens do array.")
        end
        arr[#arr + 1] = val
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "\"" then
    do return parse_str_val(str, pos + 1) end
    return
  end
  if first == "-" or first:match("%d") then
    do return parse_num_val(str, pos) end
    return
  end
  if first == end_delim then
    do return nil, pos + 1 end
    return
  end
  do
    local literals = {
      ["true"] = true,
      ["false"] = false,
      null = json.null
    }
    do
      do
        for SRD1_9_, SRD1_10_ in pairs(literals) do
          local lit_end = pos + #SRD1_9_ - 1
          if str:sub(pos, lit_end) == SRD1_9_ then
            return SRD1_10_, lit_end + 1
          end
        end
      end
    end
    local pos_info_str = "position " .. pos .. ": " .. str:sub(pos, pos + 10)
    error("Sintaxe json inválida começando em " .. pos_info_str)
  end
end

function enc(data, b)
  return (data:gsub(".", function(x)
    local r, b = "", x:byte()
    do
      do
        for SRD1_6_ = 8, 1, -1 do
          r = r .. (b % 2 ^ SRD1_6_ - b % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
    if #x < 6 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 6 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (6 - SRD1_5_) or 0)
        end
      end
    end
    return b:sub(c + 1, c + 1)
  end
  ) .. ({
    "",
    "??",
    "?"
  })[#data % 3 + 1]
end

function dec(data, b)
  data = string.gsub(data, "[^" .. b .. "=]", "")
  return (data:gsub(".", function(x)
    if x == "?" then
      return ""
    end
    local r, f = "", b:find(x) - 1
    do
      do
        for SRD1_6_ = 6, 1, -1 do
          r = r .. (f % 2 ^ SRD1_6_ - f % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
    if #x ~= 8 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 8 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (8 - SRD1_5_) or 0)
        end
      end
    end
    return string.char(c)
  end
  ))
end

function rwmem(Address, SizeOrBuffer)
  assert(Address ~= nil, "[rwmem]: error, endereço fornecido é nulo.")
  _rw = {}
  if type(SizeOrBuffer) == "number" then
    _ = ""
    do
      do
        for SRD1_5_ = 1, SizeOrBuffer do
          _rw[SRD1_5_] = {
            address = Address - 1 + SRD1_5_,
            flags = gg.TYPE_BYTE
          }
        end
      end
    end
    do
      do
        for SRD1_5_, SRD1_6_ in ipairs(gg.getValues(_rw)) do
          if SRD1_6_.value == 0 and limit == true then
            return _
          end
          _ = _ .. string.format("%02X", SRD1_6_.value & 255)
        end
      end
    end
    return _
  end
  Byte = {}
  SizeOrBuffer:gsub("..", function(x)
    Byte[#Byte + 1] = x
    _rw[#Byte] = {
      address = Address - 1 + #Byte,
      flags = gg.TYPE_BYTE,
      value = x .. "h"
    }
  end
  )
  gg.setValues(_rw)
end

function hexdecode(hex)
  return (hex:gsub("%x%x", function(digits)
    return string.char(tonumber(digits, 16))
  end
  ))
end

function hexencode(str)
  return (str:gsub(".", function(char)
    return string.format("%2x", char:byte())
  end
  ))
end

function Dec2Hex(nValue)
  nHexVal = string.format("%X", nValue)
  sHexVal = nHexVal .. ""
  return sHexVal
end

function ToInteger(number)
  return math.floor(tonumber(number) or error("Não foi possível transmitir '" .. tostring(number) .. "' enumerar.'"))
end

function payload(data)
  io.open(gg.EXT_STORAGE .. "/payload.txt", "w"):write(data)
  gg.toast("te peguei Lionel Richie!")
end

function save2(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(json.stringify(data))
  gg.toast("te peguei Lionel Richie!")
end

function hc(data)
  io.open(gg.EXT_STORAGE .. "/hc.txt", "w"):write(data)
  gg.toast("te peguei Lionel Richie!")
end

function v2json(data)
  io.open(gg.EXT_STORAGE .. "/v2ray.txt", "w"):write(data)
end

limit = false

  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 55 70 67 72 61 64 65 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado: Upgrade")
    hc_2 = true
  end
  if hc_2 then
    gg.searchNumber("h 75 70 67 72 61 64 65 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: upgrade")
      hc_3 = true
    end
  end
  if hc_3 then
    gg.searchNumber("h 47 45 54 20 77 73", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: GET ws")
      hc_4 = true
    end
  end
  if hc_4 then
    gg.searchNumber("h 43 4F 4E 4E 45 43 54 20 5B 68 6F 73 74 5F 70 6F 72 74 5D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: connect crlf")
      hc_5 = true
    end
  end
  if hc_5 then
    gg.searchNumber("h 5B 72 6F 74 61 74 69 6F 6E 3D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: rotation")
      hc_6 = true
    end
  end
  if hc_6 then
    gg.searchNumber("h 5B 72 61 6E 64 6F 6D 3D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: random")
      hc_7 = true
    end
  end
  if hc_7 then
    gg.searchNumber("h 5B 63 72 6C 66 5D 50 72 6F 78 79 2D 43 6F 6E 6E 65 63 74 69 6F 6E", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: proxy connection")
      hc_8 = true
    end
  end
  if hc_8 then
    gg.searchNumber("h 5B 72 6F 74 61 74 65 3D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: rotate")
      hc_9 = true
    end
  end
  if hc_9 then
    gg.searchNumber("h 5B 63 72 6C 66 5D 20 5B 63 72 6C 66 5D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: crlf esp")
      hc_10 = true
    end
  end
  if hc_10 then
    gg.searchNumber("h 5B 70 72 6F 74 6F 63 6F 6C 5D 5B 63 72 6C 66 5D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: protocol crlf")
      hc_11 = true
    end
  end
  if hc_11 then
    gg.searchNumber("h 5B 63 72 6C 66 5D 48 6F 73 74 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: crlf host")
      hc_12 = true
    end
  end
  if hc_12 then
    gg.searchNumber("h 5C 6E 48 6F 73 74 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: n crlf")
      hc_13 = true
    end
  end
  if hc_13 then
    gg.searchNumber("h 50 55 54 20 2F 3F", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: p u int")
      hc_14 = true
    end
  end
  if hc_14 then
    gg.searchNumber("h 45 78 70 65 63 74 3A 20 31 30 30 2D 63 6F 6E 74 69 6E 75 65", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: exp 100 con")
      hc_15 = true
    end
  end
  if hc_15 then
    gg.searchNumber("h 5B 6C 66 5D 5B 73 70 6C 69 74 5D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: lf split")
      hc_16 = true
    end
  end
  if hc_16 then
    gg.searchNumber("h 58 2D 4F 6E 6C 69 6E 65 2D 48 6F 73 74 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: x online")
      hc_17 = true
    end
  end
  if hc_17 then
    gg.searchNumber("h 5C 6E 5C 6E", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: n n")
      hc_18 = true
    end
  end
  if hc_18 then
    gg.searchNumber("h 5B 6E 65 74 44 61 74 61 5D 5C 72 0A 5C 72", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: netdata r split")
      hc_19 = true
    end
  end
  if hc_19 then
    gg.searchNumber("h 2E 67 6F 76 5B 63 72 6C 66 5D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: gov crlf")
      hc_20 = true
    end
  end
  if hc_20 then
    gg.toast("Pai não encontrado")
    print("edite a sua busca, use novas palavras chave ou recarregue o aplicativo e configuração novamente\n")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 1000
  end
  readedMem = rwmem(r[1].address, 10000)
  payload(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/payoload.txt")
  gg.clearResults()
  gg.toast("não me deixe vê")
  print("\nhoje não é o seu dia de sorte\n\n")
gg.clearResults()
os.exit()
pcall(load(Payload))
prima()
end

function login()
limit = false

local utf8 = {}
local bit = {
  data32 = {}
}
do
  do
    for SRD1_5_ = 1, 32 do
      bit.data32[SRD1_5_] = 2 ^ (32 - SRD1_5_)
    end
  end
end
local toby = string.byte
function utf8.charbytes(s, i)
  i = i or 1
  local c = string.byte(s, i)
  if c > 0 and c <= 127 then
    do return 1 end
    return
  end
  if c >= 194 and c <= 223 then
    do return 2 end
    return
  end
  if c >= 224 and c <= 239 then
    do return 3 end
    return
  end
  if c >= 240 and c <= 244 then
    return 4
  end
  return 1
end

local ded
function bit:d2b(arg)
  if arg == nil then
    return
  end
  local tr, c = {}, arg < 0
  if c then
    arg = 0 - arg
  end
  do
    do
      for SRD1_7_ = 1, 32 do
        if arg >= self.data32[SRD1_7_] then
          tr[SRD1_7_] = 1
          arg = arg - self.data32[SRD1_7_]
        else
          tr[SRD1_7_] = 0
        end
      end
    end
  end
  if c then
    tr = self:_bnot(tr)
    tr = self:b2d(tr) + 1
    tr = self:d2b(tr)
  end
  return tr
end

function bit:b2d(arg, neg)
  local nr = 0
  if arg[1] == 1 and neg == true then
    arg = self:_bnot(arg)
    nr = self:b2d(arg) + 1
    nr = 0 - nr
  else
    do
      for SRD1_7_ = 1, 32 do
        if arg[SRD1_7_] == 1 then
          nr = nr + 2 ^ (32 - SRD1_7_)
        end
      end
    end
  end
  return nr
end

function bit:_and(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 and op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_or(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 or op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_xor(a, b)
  local op1 = self:d2b(a)
  if op1 == nil then
    return nil
  end
  local op2 = self:d2b(b)
  if op2 == nil then
    return nil
  end
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == op2[SRD1_9_] then
          r[SRD1_9_] = 0
        else
          r[SRD1_9_] = 1
        end
      end
    end
  end
  return self:b2d(r, true)
end

local switch = {
  [1] = function(s, pos)
    local c1 = toby(s, pos)
    return c1
  end
  ,
  [2] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local int1 = bit:_and(31, c1)
    local int2 = bit:_and(63, c2)
    return bit:_or(bit:_lshift(int1, 6), int2)
  end
  ,
  [3] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local o2 = bit:_or(bit:_lshift(int1, 12), bit:_lshift(int2, 6))
    local dt = bit:_or(o2, int3)
    return dt
  end
  ,
  [4] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local c4 = toby(s, pos + 3)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local int4 = bit:_and(63, c4)
    local o2 = bit:_or(bit:_lshift(int1, 18), bit:_lshift(int2, 12))
    local o3 = bit:_or(o2, bit:_lshift(int3, 6))
    local o4 = bit:_or(o3, int4)
    return o4
  end
  
}
function bit:_bnot(op1)
  local r = {}
  do
    do
      for SRD1_6_ = 1, 32 do
        if op1[SRD1_6_] == 1 then
          r[SRD1_6_] = 0
        else
          r[SRD1_6_] = 1
        end
      end
    end
  end
  return r
end

function bit:_not(a)
  local op1 = self:d2b(a)
  local r = self:_bnot(op1)
  return self:b2d(r, true)
end

function bit:charCodeAt(s)
  local pos, int, H, L = 1, 0, 0, 0
  local slen = string.len(s)
  local allByte = {}
  while pos <= slen do
    local tLen = utf8.charbytes(s, pos)
    if tLen >= 1 and tLen <= 4 then
      if tLen == 4 then
        int = switch[4](s, pos)
        H = math.floor((int - 65536) / 1024) + 55296
        L = (int - 65536) % 1024 + 56320
        table.insert(allByte, H)
        table.insert(allByte, L)
      else
        int = switch[tLen](s, pos)
        table.insert(allByte, int)
      end
    end
    pos = pos + tLen
  end
  return allByte
end

function bit:_rshift(a, n)
  local r = 0
  if a < 0 then
    r = 0 - self:_frshift(0 - a, n)
  elseif a >= 0 then
    r = self:_frshift(a, n)
  end
  return r
end

function bit:_frshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  local left = 32 - n
  if n < 32 and n > 0 then
    do
      for SRD1_9_ = left, 1, -1 do
        r[SRD1_9_ + n] = op1[SRD1_9_]
      end
    end
  end
  return self:b2d(r)
end

function bit:_lshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  if n < 32 and n > 0 then
    do
      for SRD1_8_ = n, 31 do
        r[SRD1_8_ - n + 1] = op1[SRD1_8_ + 1]
      end
    end
  end
  return self:b2d(r, true)
end

function trim(s)
  return s:match("^%s*(.*)"):match("(.-)%s*$")
end

local json = {}
local kind_of = function(obj)
  if type(obj) ~= "table" then
    return type(obj)
  end
  local i = 1
  do
    do
      for SRD1_5_ in pairs(obj) do
        if obj[i] ~= nil then
          i = i + 1
        else
          return "table"
        end
      end
    end
  end
  if i == 1 then
    do return "table" end
    return
  end
  return "array"
end

local escape_str = function(s)
  local in_char = {
    "\\",
    "\"",
    "/",
    "\b",
    "\f",
    "\n",
    "\r",
    "\t"
  }
  local out_char = {
    "\\",
    "\"",
    "/",
    "b",
    "f",
    "n",
    "r",
    "t"
  }
  do
    do
      for SRD1_6_, SRD1_7_ in ipairs(in_char) do
        s = s:gsub(SRD1_7_, "\\" .. out_char[SRD1_6_])
      end
    end
  end
  return s
end

local skip_delim = function(str, pos, delim, err_if_missing)
  pos = pos + #str:match("^%s*", pos)
  if str:sub(pos, pos) ~= delim then
    if err_if_missing then
      error("Esperado " .. delim .. " posição próxima " .. pos)
    end
    return pos, false
  end
  return pos + 1, true
end

local function parse_str_val(str, pos, val)
  val = val or ""
  local early_end_error = "Fim da entrada encontrado durante a análise da string."
  if pos > #str then
    error(early_end_error)
  end
  local c = str:sub(pos, pos)
  if c == "\"" then
    return val, pos + 1
  end
  if c ~= "\\" then
    return parse_str_val(str, pos + 1, val .. c)
  end
  local esc_map = {
    b = "\b",
    f = "\f",
    n = "\n",
    r = "\r",
    t = "\t"
  }
  local nextc = str:sub(pos + 1, pos + 1)
  if not nextc then
    error(early_end_error)
  end
  return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

local parse_num_val = function(str, pos)
  local num_str = str:match("^-?%d+%.?%d*[eE]?[+-]?%d*", pos)
  local val = tonumber(num_str)
  if not val then
    error("Erro ao analisar o número na posição " .. pos .. ".")
  end
  return val, pos + #num_str
end

function json.stringify(obj, as_key)
  local s = {}
  local kind = kind_of(obj)
  if kind == "array" then
    if as_key then
      error("Não é possível codificar array como chave.")
    end
    s[#s + 1] = "["
    do
      do
        for SRD1_7_, SRD1_8_ in ipairs(obj) do
          if SRD1_7_ > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "]"
  elseif kind == "table" then
    if as_key then
      error("Não é possível codificar a tabela como chave.")
    end
    s[#s + 1] = "{"
    do
      do
        for SRD1_7_, SRD1_8_ in pairs(obj) do
          if #s > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_7_, true)
          s[#s + 1] = ":"
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "}"
  else
    if kind == "string" then
      do return "\"" .. escape_str(obj) .. "\"" end
      return
    end
    if kind == "number" then
      if as_key then
        return "\"" .. tostring(obj) .. "\""
      end
      do return tostring(obj) end
      return
    end
    if kind == "boolean" then
      do return tostring(obj) end
      return
    end
    if kind == "nil" then
      do return "null" end
      return
    end
    error("tipo unjsonificável,: " .. kind .. ".")
  end
  return table.concat(s)
end

json.null = {}
function json.parse(str, pos, end_delim)
  pos = pos or 1
  if pos > #str then
    error("Atingiu o fim inesperado da entrada ")
  end
  local pos = pos + #str:match("^%s*", pos)
  local first = str:sub(pos, pos)
  if first == "{" then
    do
      local obj, key, delim_found = {}, true, true
      pos = pos + 1
      while true do
        key, pos = json.parse(str, pos, "}")
        if key == nil then
          return obj, pos
        end
        if not delim_found then
          error("Vírgula faltando entre os itens do objeto.")
        end
        pos = skip_delim(str, pos, ":", true)
        obj[key], pos = json.parse(str, pos)
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "[" then
    do
      local arr, val, delim_found = {}, true, true
      pos = pos + 1
      while true do
        val, pos = json.parse(str, pos, "]")
        if val == nil then
          return arr, pos
        end
        if not delim_found then
          error("Falta vírgula entre os itens do array.")
        end
        arr[#arr + 1] = val
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "\"" then
    do return parse_str_val(str, pos + 1) end
    return
  end
  if first == "-" or first:match("%d") then
    do return parse_num_val(str, pos) end
    return
  end
  if first == end_delim then
    do return nil, pos + 1 end
    return
  end
  do
    local literals = {
      ["true"] = true,
      ["false"] = false,
      null = json.null
    }
    do
      do
        for SRD1_9_, SRD1_10_ in pairs(literals) do
          local lit_end = pos + #SRD1_9_ - 1
          if str:sub(pos, lit_end) == SRD1_9_ then
            return SRD1_10_, lit_end + 1
          end
        end
      end
    end
    local pos_info_str = "position " .. pos .. ": " .. str:sub(pos, pos + 10)
    error("Sintaxe json inválida começando em " .. pos_info_str)
  end
end

function enc(data, b)
  return (data:gsub(".", function(x)
    local r, b = "", x:byte()
    do
      do
        for SRD1_6_ = 8, 1, -1 do
          r = r .. (b % 2 ^ SRD1_6_ - b % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
    if #x < 6 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 6 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (6 - SRD1_5_) or 0)
        end
      end
    end
    return b:sub(c + 1, c + 1)
  end
  ) .. ({
    "",
    "??",
    "?"
  })[#data % 3 + 1]
end

function dec(data, b)
  data = string.gsub(data, "[^" .. b .. "=]", "")
  return (data:gsub(".", function(x)
    if x == "?" then
      return ""
    end
    local r, f = "", b:find(x) - 1
    do
      do
        for SRD1_6_ = 6, 1, -1 do
          r = r .. (f % 2 ^ SRD1_6_ - f % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
    if #x ~= 8 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 8 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (8 - SRD1_5_) or 0)
        end
      end
    end
    return string.char(c)
  end
  ))
end

function rwmem(Address, SizeOrBuffer)
  assert(Address ~= nil, "[rwmem]: error, endereço fornecido é nulo.")
  _rw = {}
  if type(SizeOrBuffer) == "number" then
    _ = ""
    do
      do
        for SRD1_5_ = 1, SizeOrBuffer do
          _rw[SRD1_5_] = {
            address = Address - 1 + SRD1_5_,
            flags = gg.TYPE_BYTE
          }
        end
      end
    end
    do
      do
        for SRD1_5_, SRD1_6_ in ipairs(gg.getValues(_rw)) do
          if SRD1_6_.value == 0 and limit == true then
            return _
          end
          _ = _ .. string.format("%02X", SRD1_6_.value & 255)
        end
      end
    end
    return _
  end
  Byte = {}
  SizeOrBuffer:gsub("..", function(x)
    Byte[#Byte + 1] = x
    _rw[#Byte] = {
      address = Address - 1 + #Byte,
      flags = gg.TYPE_BYTE,
      value = x .. "h"
    }
  end
  )
  gg.setValues(_rw)
end

function hexdecode(hex)
  return (hex:gsub("%x%x", function(digits)
    return string.char(tonumber(digits, 16))
  end
  ))
end

function hexencode(str)
  return (str:gsub(".", function(char)
    return string.format("%2x", char:byte())
  end
  ))
end

function Dec2Hex(nValue)
  nHexVal = string.format("%X", nValue)
  sHexVal = nHexVal .. ""
  return sHexVal
end

function ToInteger(number)
  return math.floor(tonumber(number) or error("Não foi possível transmitir '" .. tostring(number) .. "' enumerar.'"))
end

function logins(data)
  io.open(gg.EXT_STORAGE .. "/login.txt", "w"):write(data)
  gg.toast("te peguei Lionel Richie!")
end

limit = false

  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.processPause()
  gg.searchNumber(":ssh-connection   password", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
  gg.processResume()
    gg.toast("Pai não encontrado: ssh-connection")
    logins_2 = true
  end
  if logins_2 then
  limit = false
    gg.searchNumber("h 0E 73 73 68 2D 63 6F 6E 6E 65 63 74 69 6F 6E 00 00 00 08 70 61 73 73 77 6F 72 64", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: ssh-connection")
  gg.processResume()
  return
  end
  x9B()
  end
  
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 0x400
  end
  readedMem = rwmem(r[1].address, 10000)
  logins(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/login.txt")
  gg.clearResults()
  gg.toast("não me deixe vê")
  print("\nhoje é o seu dia de sorte\n\n")
gg.clearResults()
gg.processResume()
return
x9B()
end
function V2Ray()

limit = true

local utf8 = {}
local bit = {
  data32 = {}
}
do
  do
    for SRD1_5_ = 1, 32 do
      bit.data32[SRD1_5_] = 2 ^ (32 - SRD1_5_)
    end
  end
end
local toby = string.byte
function utf8.charbytes(s, i)
  i = i or 1
  local c = string.byte(s, i)
  if c > 0 and c <= 127 then
    do return 1 end
    return
  end
  if c >= 194 and c <= 223 then
    do return 2 end
    return
  end
  if c >= 224 and c <= 239 then
    do return 3 end
    return
  end
  if c >= 240 and c <= 244 then
    return 4
  end
  return 1
end

local ded
function bit:d2b(arg)
  if arg == nil then
    return
  end
  local tr, c = {}, arg < 0
  if c then
    arg = 0 - arg
  end
  do
    do
      for SRD1_7_ = 1, 32 do
        if arg >= self.data32[SRD1_7_] then
          tr[SRD1_7_] = 1
          arg = arg - self.data32[SRD1_7_]
        else
          tr[SRD1_7_] = 0
        end
      end
    end
  end
  if c then
    tr = self:_bnot(tr)
    tr = self:b2d(tr) + 1
    tr = self:d2b(tr)
  end
  return tr
end

function bit:b2d(arg, neg)
  local nr = 0
  if arg[1] == 1 and neg == true then
    arg = self:_bnot(arg)
    nr = self:b2d(arg) + 1
    nr = 0 - nr
  else
    do
      for SRD1_7_ = 1, 32 do
        if arg[SRD1_7_] == 1 then
          nr = nr + 2 ^ (32 - SRD1_7_)
        end
      end
    end
  end
  return nr
end

function bit:_and(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 and op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_or(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 or op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_xor(a, b)
  local op1 = self:d2b(a)
  if op1 == nil then
    return nil
  end
  local op2 = self:d2b(b)
  if op2 == nil then
    return nil
  end
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == op2[SRD1_9_] then
          r[SRD1_9_] = 0
        else
          r[SRD1_9_] = 1
        end
      end
    end
  end
  return self:b2d(r, true)
end

local switch = {
  [1] = function(s, pos)
    local c1 = toby(s, pos)
    return c1
  end
  ,
  [2] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local int1 = bit:_and(31, c1)
    local int2 = bit:_and(63, c2)
    return bit:_or(bit:_lshift(int1, 6), int2)
  end
  ,
  [3] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local o2 = bit:_or(bit:_lshift(int1, 12), bit:_lshift(int2, 6))
    local dt = bit:_or(o2, int3)
    return dt
  end
  ,
  [4] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local c4 = toby(s, pos + 3)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local int4 = bit:_and(63, c4)
    local o2 = bit:_or(bit:_lshift(int1, 18), bit:_lshift(int2, 12))
    local o3 = bit:_or(o2, bit:_lshift(int3, 6))
    local o4 = bit:_or(o3, int4)
    return o4
  end
  
}
function bit:_bnot(op1)
  local r = {}
  do
    do
      for SRD1_6_ = 1, 32 do
        if op1[SRD1_6_] == 1 then
          r[SRD1_6_] = 0
        else
          r[SRD1_6_] = 1
        end
      end
    end
  end
  return r
end

function bit:_not(a)
  local op1 = self:d2b(a)
  local r = self:_bnot(op1)
  return self:b2d(r, true)
end

function bit:charCodeAt(s)
  local pos, int, H, L = 1, 0, 0, 0
  local slen = string.len(s)
  local allByte = {}
  while pos <= slen do
    local tLen = utf8.charbytes(s, pos)
    if tLen >= 1 and tLen <= 4 then
      if tLen == 4 then
        int = switch[4](s, pos)
        H = math.floor((int - 65536) / 1024) + 55296
        L = (int - 65536) % 1024 + 56320
        table.insert(allByte, H)
        table.insert(allByte, L)
      else
        int = switch[tLen](s, pos)
        table.insert(allByte, int)
      end
    end
    pos = pos + tLen
  end
  return allByte
end

function bit:_rshift(a, n)
  local r = 0
  if a < 0 then
    r = 0 - self:_frshift(0 - a, n)
  elseif a >= 0 then
    r = self:_frshift(a, n)
  end
  return r
end

function bit:_frshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  local left = 32 - n
  if n < 32 and n > 0 then
    do
      for SRD1_9_ = left, 1, -1 do
        r[SRD1_9_ + n] = op1[SRD1_9_]
      end
    end
  end
  return self:b2d(r)
end

function bit:_lshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  if n < 32 and n > 0 then
    do
      for SRD1_8_ = n, 31 do
        r[SRD1_8_ - n + 1] = op1[SRD1_8_ + 1]
      end
    end
  end
  return self:b2d(r, true)
end

function trim(s)
  return s:match("^%s*(.*)"):match("(.-)%s*$")
end

local json = {}
local kind_of = function(obj)
  if type(obj) ~= "table" then
    return type(obj)
  end
  local i = 1
  do
    do
      for SRD1_5_ in pairs(obj) do
        if obj[i] ~= nil then
          i = i + 1
        else
          return "table"
        end
      end
    end
  end
  if i == 1 then
    do return "table" end
    return
  end
  return "array"
end

local escape_str = function(s)
  local in_char = {
    "\\",
    "\"",
    "/",
    "\b",
    "\f",
    "\n",
    "\r",
    "\t"
  }
  local out_char = {
    "\\",
    "\"",
    "/",
    "b",
    "f",
    "n",
    "r",
    "t"
  }
  do
    do
      for SRD1_6_, SRD1_7_ in ipairs(in_char) do
        s = s:gsub(SRD1_7_, "\\" .. out_char[SRD1_6_])
      end
    end
  end
  return s
end

local skip_delim = function(str, pos, delim, err_if_missing)
  pos = pos + #str:match("^%s*", pos)
  if str:sub(pos, pos) ~= delim then
    if err_if_missing then
      error("Esperado " .. delim .. " posição próxima " .. pos)
    end
    return pos, false
  end
  return pos + 1, true
end

local function parse_str_val(str, pos, val)
  val = val or ""
  local early_end_error = "Fim da entrada encontrado durante a análise da string."
  if pos > #str then
    error(early_end_error)
  end
  local c = str:sub(pos, pos)
  if c == "\"" then
    return val, pos + 1
  end
  if c ~= "\\" then
    return parse_str_val(str, pos + 1, val .. c)
  end
  local esc_map = {
    b = "\b",
    f = "\f",
    n = "\n",
    r = "\r",
    t = "\t"
  }
  local nextc = str:sub(pos + 1, pos + 1)
  if not nextc then
    error(early_end_error)
  end
  return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

local parse_num_val = function(str, pos)
  local num_str = str:match("^-?%d+%.?%d*[eE]?[+-]?%d*", pos)
  local val = tonumber(num_str)
  if not val then
    error("Erro ao analisar o número na posição " .. pos .. ".")
  end
  return val, pos + #num_str
end

function json.stringify(obj, as_key)
  local s = {}
  local kind = kind_of(obj)
  if kind == "array" then
    if as_key then
      error("Não é possível codificar array como chave.")
    end
    s[#s + 1] = "["
    do
      do
        for SRD1_7_, SRD1_8_ in ipairs(obj) do
          if SRD1_7_ > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "]"
  elseif kind == "table" then
    if as_key then
      error("Não é possível codificar a tabela como chave.")
    end
    s[#s + 1] = "{"
    do
      do
        for SRD1_7_, SRD1_8_ in pairs(obj) do
          if #s > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_7_, true)
          s[#s + 1] = ":"
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "}"
  else
    if kind == "string" then
      do return "\"" .. escape_str(obj) .. "\"" end
      return
    end
    if kind == "number" then
      if as_key then
        return "\"" .. tostring(obj) .. "\""
      end
      do return tostring(obj) end
      return
    end
    if kind == "boolean" then
      do return tostring(obj) end
      return
    end
    if kind == "nil" then
      do return "null" end
      return
    end
    error("tipo unjsonificável,: " .. kind .. ".")
  end
  return table.concat(s)
end

json.null = {}
function json.parse(str, pos, end_delim)
  pos = pos or 1
  if pos > #str then
    error("Atingiu o fim inesperado da entrada ")
  end
  local pos = pos + #str:match("^%s*", pos)
  local first = str:sub(pos, pos)
  if first == "{" then
    do
      local obj, key, delim_found = {}, true, true
      pos = pos + 1
      while true do
        key, pos = json.parse(str, pos, "}")
        if key == nil then
          return obj, pos
        end
        if not delim_found then
          error("Vírgula faltando entre os itens do objeto.")
        end
        pos = skip_delim(str, pos, ":", true)
        obj[key], pos = json.parse(str, pos)
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "[" then
    do
      local arr, val, delim_found = {}, true, true
      pos = pos + 1
      while true do
        val, pos = json.parse(str, pos, "]")
        if val == nil then
          return arr, pos
        end
        if not delim_found then
          error("Falta vírgula entre os itens do array.")
        end
        arr[#arr + 1] = val
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "\"" then
    do return parse_str_val(str, pos + 1) end
    return
  end
  if first == "-" or first:match("%d") then
    do return parse_num_val(str, pos) end
    return
  end
  if first == end_delim then
    do return nil, pos + 1 end
    return
  end
  do
    local literals = {
      ["true"] = true,
      ["false"] = false,
      null = json.null
    }
    do
      do
        for SRD1_9_, SRD1_10_ in pairs(literals) do
          local lit_end = pos + #SRD1_9_ - 1
          if str:sub(pos, lit_end) == SRD1_9_ then
            return SRD1_10_, lit_end + 1
          end
        end
      end
    end
    local pos_info_str = "position " .. pos .. ": " .. str:sub(pos, pos + 10)
    error("Sintaxe json inválida começando em " .. pos_info_str)
  end
end

function enc(data, b)
  return (data:gsub(".", function(x)
    local r, b = "", x:byte()
    do
      do
        for SRD1_6_ = 8, 1, -1 do
          r = r .. (b % 2 ^ SRD1_6_ - b % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
    if #x < 6 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 6 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (6 - SRD1_5_) or 0)
        end
      end
    end
    return b:sub(c + 1, c + 1)
  end
  ) .. ({
    "",
    "??",
    "?"
  })[#data % 3 + 1]
end

function dec(data, b)
  data = string.gsub(data, "[^" .. b .. "=]", "")
  return (data:gsub(".", function(x)
    if x == "?" then
      return ""
    end
    local r, f = "", b:find(x) - 1
    do
      do
        for SRD1_6_ = 6, 1, -1 do
          r = r .. (f % 2 ^ SRD1_6_ - f % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
    if #x ~= 8 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 8 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (8 - SRD1_5_) or 0)
        end
      end
    end
    return string.char(c)
  end
  ))
end

function rwmem(Address, SizeOrBuffer)
  assert(Address ~= nil, "[rwmem]: error, endereço fornecido é nulo.")
  _rw = {}
  if type(SizeOrBuffer) == "number" then
    _ = ""
    do
      do
        for SRD1_5_ = 1, SizeOrBuffer do
          _rw[SRD1_5_] = {
            address = Address - 1 + SRD1_5_,
            flags = gg.TYPE_BYTE
          }
        end
      end
    end
    do
      do
        for SRD1_5_, SRD1_6_ in ipairs(gg.getValues(_rw)) do
          if SRD1_6_.value == 0 and limit == true then
            return _
          end
          _ = _ .. string.format("%02X", SRD1_6_.value & 255)
        end
      end
    end
    return _
  end
  Byte = {}
  SizeOrBuffer:gsub("..", function(x)
    Byte[#Byte + 1] = x
    _rw[#Byte] = {
      address = Address - 1 + #Byte,
      flags = gg.TYPE_BYTE,
      value = x .. "h"
    }
  end
  )
  gg.setValues(_rw)
end

function hexdecode(hex)
  return (hex:gsub("%x%x", function(digits)
    return string.char(tonumber(digits, 16))
  end
  ))
end

function hexencode(str)
  return (str:gsub(".", function(char)
    return string.format("%2x", char:byte())
  end
  ))
end

function Dec2Hex(nValue)
  nHexVal = string.format("%X", nValue)
  sHexVal = nHexVal .. ""
  return sHexVal
end

function ToInteger(number)
  return math.floor(tonumber(number) or error("Não foi possível transmitir '" .. tostring(number) .. "' enumerar.'"))
end

function v2ray(data)
  io.open(gg.EXT_STORAGE .. "/v2ray.txt", "w"):write(data)
  gg.toast("te peguei Lionel Richie!")
end

function save2(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(json.stringify(data))
  gg.toast("te peguei Lionel Richie!")
end

function hc(data)
  io.open(gg.EXT_STORAGE .. "/hc.txt", "w"):write(data)
  gg.toast("te peguei Lionel Richie!")
end

function v2json(data)
  io.open(gg.EXT_STORAGE .. "/v2ray.txt", "w"):write(data)
end

  limit = true
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7B 0A 09 09 22 69 6E 62 6F 75 6E 64", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("Pai não encontrado: inbounds")
    hc_2 = true
  end
  if hc_2 then 
    gg.searchNumber("h 7B 0A 09 09 22 64 6E 73 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: dns")
      hc_3 = true
    end
  end
  if hc_3 then
    gg.searchNumber("h 20 22 64 6e 73 22 3a 20 7b", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: dns t")
      hc_4 = true
    end
  end
  if hc_4 then
    gg.searchNumber("h 7B 0A 09 09 09 09 09 09 09 09 09 09 09 09 22 61 64 64 72 65 73 73 22 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("Pai não encontrado: address")
      hc_5 = true
    end
  end
  
  if hc_5 then
    gg.toast("Pai não encontrado")
    print("edite a sua busca, use novas palavras chave ou recarregue o aplicativo e configuração novamente\n")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 0x400
  end
  readedMem = rwmem(r[1].address, 50000)
  v2ray(hexdecode(readedMem))
  gg.toast("Pai encontrado")
  print("te peguei Lionel Richie!\n\no arquivo está em: /sdcard/v2ray.txt")
  gg.clearResults()
os.exit()
pcall(load(V2Ray))
prima()
end

function Dump()

function rwmem2(Address, SizeOrBuffer)
assert(Address ~= nil, "[rwmem]: error, endereço fornecido é nulo.")
_rw = {}
if type(SizeOrBuffer) == "number" then
_ = ""
for _ = 1, SizeOrBuffer do _rw[_] = {address = (Address - 1) + _, flags = gg.TYPE_BYTE} end
for v, __ in ipairs(gg.getValues(_rw)) do
 if __.value == 00 then  
end
_ = _ .. string.format("%02X", __.value & 0xFF)
end
return _
end
Byte = {} SizeOrBuffer:gsub("..", function(x)
Byte[#Byte + 1] = x _rw[#Byte] = {address = (Address - 1) + #Byte, flags = gg.TYPE_BYTE, value = x .. "h"}
end)
gg.setValues(_rw)
end
local function hexdecode2(hex)
return (hex:gsub("%x%x", function(digits) return string.char(tonumber(digits, 16)) end))
end
local function hexencode2(str)
return (str:gsub(".", function(char) return string.format("%2x", char:byte()) end))
end
function Dec2Hex2(nValue)
nHexVal = string.format("%X", nValue);
sHexVal = nHexVal.."";
return sHexVal;
end
function ToInteger2(number)
return math.floor(tonumber(number) or error("Não foi possível transmitir '" .. tostring(number) .. "' enumerar.'"))
end
gg.clearResults()
options = gg.prompt({ "Cole o endereço aqui abaixo:" }, {[1]=""}, {[1]='text'})

gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_JAVA_HEAP | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_PPSSPP | gg.REGION_C_DATA | gg.REGION_C_BSS | gg.REGION_STACK | gg.REGION_ASHMEM | gg.REGION_BAD | gg.REGION_OTHER)
readedMem2 = rwmem2("0x" .. options[1], 70000)
io.open(gg.EXT_STORAGE .. "/x9.txt", "w"):write(hexdecode2(readedMem2))
gg.toast("✅ Pai encontrado")
  print("✅ te peguei Lionel Richie!\n\no arquivo está em: /sdcard/x9.txt")
reconnect()
x9B()
prima()
end

function EXIT()

gg.clearResults()
t = gg.getListItems()
gg.removeListItems(t)
gg.toast("tá sentindo a energia?⚡")
os.exit()
end

function x9P()
gg.toast("👻 Calma, barboleta 🦋")
end

function reconnect()
x9B()
end

function prima()
end

if x9A == 1 then x9B() end
end
end
if x9ok == 1 then x9on() end