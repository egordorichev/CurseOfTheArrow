
g_calpha = 255

--The game's font
local font

--The game's canvas
local canvas

--canvas_x, canvas_y -> The convas drawing position on the love's screen
--cavnas_scale -> The scale of the canvas
local canvas_x, canvas_y, canvas_scale = 0, 0, 5

--The spritesheet of the game, as an image object.
local sprites

--The quads for each sprite.
local sprites_quads = {}

--Rename classic console print,
--It will be replaced later by a graphical print
printh = print

--Initialized the API, load fonts, images, etc...
function initApi()
  love.graphics.setLineStyle("rough")
  -- love.mouse.setVisible(false)
  love.keyboard.setKeyRepeat(false)

  font = love.graphics.newFont("assets/font.ttf", 4)

  love.graphics.setFont(font)

  canvas = love.graphics.newCanvas(192, 128)

  sprites = love.graphics.newImage("assets/sprites.png")

  for i = 0, 256 * 256 - 1 do
    sprites_quads[i] = love.graphics.newQuad(flr(i % 32 * 8), flr(flr(i / 32) * 8), 8, 8, 256, 256)
  end

  color()
end

local sd, sm = 0, 0

function shake(d, m)
  if g_ess  then sd, sm = d, m end
end

function apiPreDraw()
  --love.graphics.setScissor()
  love.graphics.clear(10 / 255, 10 / 255, 10 / 255, 1)
  love.graphics.setCanvas{canvas, stencil=true}
  --love.graphics.push()

end

function apiPostDraw()
  love.graphics.setCanvas()
  love.graphics.setColor(1, 1, 1, 1)
  local dx, dy = 0, 0

  if sd > 0 then
    sd = sd - 1
    dx, dy = love.math.random(-sm, sm), love.math.random(-sm, sm)
  end

  love.graphics.draw(canvas, canvas_x + dx, canvas_y + dy, 0, canvas_scale, canvas_scale)
end

function apiResize()
  local w, h = love.graphics.getWidth(), love.graphics.getHeight()
  local s = math.min(
    w / 192,
    h / 128
  )

  if g_pix then
    s = flr(s)
  end

  cs = s
  canvas_x = (w - s * 192) / 2
  canvas_y = (h - s * 128) / 2
end

local clr = 7
palette = {
  [0] = { 0, 0, 0 },
  { 32 / 255, 51 / 255, 123 / 255 },
  { 126 / 255, 37 / 255, 83 / 255 },
  { 0 / 255, 131 / 255, 49 / 255 },
  { 171 / 255, 82 / 255, 54 / 255 },
  { 69 / 255, 69 / 255, 69 / 255 },
  { 194 / 255, 195 / 255, 199 / 255 },
  { 255 / 255, 241 / 255, 232 / 255 },
  { 255 / 255, 0 / 255, 77 / 255 },
  { 255 / 255, 163 / 255, 0 / 255 },
  { 255 / 255, 231 / 255, 39 / 255 },
  { 0 / 255, 226 / 255, 50 / 255 },
  { 41 / 255, 173 / 255, 255 / 255 },
  { 131 / 255, 118 / 255, 156 / 255 },
  { 255 / 255, 119 / 255, 168 / 255 },
  { 255 / 255, 204 / 255, 170 / 255 }
}

function color(c)
  if c then
    clr = c % 16

    local p = palette[clr]
    if g_calpha and c~=0 then
      love.graphics.setColor(g_calpha, g_calpha, g_calpha)
    else
      love.graphics.setColor(p)
    end
  else
    love.graphics.setColor(255, 255, 255, 255)
  end
end

function cls(c)
  color(c)
  love.graphics.clear(palette[clr])
end

function print(str, x, y, c)
  if c then color(c) end

  x = flr(x)
  y = flr(y) - 1
  if print_a then
    local r, g, b = love.graphics.getColor()
    love.graphics.setColor(r, g, b, print_a)
  end
  love.graphics.print(str, x, y)
end

function flip()
  apiPostDraw()
end

function flr(n)
  return math.floor(n or 0)
end

function sqrt(n)
  return math.sqrt(n or 0)
end

function ceil(n)
  return math.ceil(n or 0)
end

function cos(n)
  return math.cos(math.rad(n * 360))
end

function sin(n)
  return math.sin(math.rad(n * 360))
end

function atan2(x, y)
  x = x or 0
  y = y or 0

  return (0.75 + math.atan2(x, y) / (math.pi * 2)) % 1.0
end

function rnd(min, max)
  min = min or 1
  if max then
    return math.random(min, max)
  else
    return math.random() * min
  end
end

function srand(s)
  math.randomseed(s or 0)
end

function min(a, b)
  return a < b and a or b
end

function max(a, b)
  return a > b and a or b
end

function mid(x, y, z)
  x, y, z = x or 0, y or 0, z or 0
  if x > y then
    x, y = y, x
  end

  return max(x, min(y, z))
end

function abs(n)
  return n and math.abs(n) or 0
end

function sgn(n)
  if n == nil then
    return 1
  end

  return n < 0 and - 1 or 1
end

function add(a, v)
  if a == nil then
    return
  end
  table.insert(a, v)
end

function del(a, dv)
  if a == nil then
    return
  end
  for i, v in ipairs(a) do
    if v == dv then
      table.remove(a, i)
    end
  end
end

function foreach(a, f)
  if not a then
    return
  end
  for i, v in ipairs(a) do
    f(v)
  end
end

function all(a)
  local i = 0
  local n = table.getn(a)

  return function()
    i = i + 1
    if i <= n then return a[i] end
  end
end

local quadsCache = {}

g_sprc = nil
function spr(s, x, y, w, h, fx, fy, r)
  if not sprites_quads[s] then return end

  x = flr(x)
  y = flr(y)

  local sx = flr(fx and (fx == true and -1 or 1) or 1)
  local sy = flr(fy and (fy == true and -1 or 1) or 1)
  local w = flr(w or 1)
  local h = flr(h or 1)

  local quadName = w.."_"..h
  if not quadsCache[s] then quadsCache[s] = {} end
  if not quadsCache[s][quadName] then quadsCache[s][quadName] = love.graphics.newQuad(s % 32 * 8, flr(s / 32) * 8, w * 8, h * 8, 256, 256) end

  if g_sprc then color(g_sprc) g_sprc = nil
  else
    if g_index >= 80 and g_index < 100 then
      love.graphics.setColor(255 / 255, 200 / 255, 200 / 255, 1)

    else
      local c = (g_calpha or 255) / 255
      love.graphics.setColor(c, c, c, 1)

    end
  end
  love.graphics.draw(sprites, quadsCache[s][quadName], flr(x + 4 * w), flr(y + 4 * h), math.rad((r or 0) * 360), sx, sy, flr(4 * w), flr(4 * h))

  color(clr)
end

function bspr(s, x, y, w, h, fx, fy, r)
  if not sprites_quads[s] then return end

  x = flr(x)
  y = flr(y)

  local sx = (fx and (fx == true and -1 or 1) or 1)
  local sy = (fy and (fy == true and -1 or 1) or 1)
  local w = w or 1
  local h = h or 1

  local quadName = w.."_"..h
  if not quadsCache[s] then quadsCache[s] = {} end
  if not quadsCache[s][quadName] then quadsCache[s][quadName] = love.graphics.newQuad(s % 32 * 8, flr(s / 32) * 8, w * 8, h * 8, 256, 256) end

  color(0)
  love.graphics.draw(sprites, quadsCache[s][quadName], x + 4 * w, y + 4 * h, math.rad((r or 0) * 360), sx, sy, 4 * w, 4 * h)

  color(clr)
end

local map = {
  ["left"] = "dpleft",
  ["right"] = "dpright",
  ["up"] = "dpup",
  ["down"] = "dpdown",
  ["z"] = "a",
  ["x"] = "b",
  ["c"] = "y",
  ["v"] = "x"
}

joy_map = {}
for i, v in pairs(map) do
  joy_map[v] = i;
end
joy_map["start"] = "escape"
joyid = 1

function jdown(b)
  if not joystick then return false end
  if map[b] then
    return joystick:isGamepadDown(map[b])
  end
end

function btn(b)
  b = kmap[b] or b
  return (love.keyboard.isDown(b) or jdown(b) or _keys[b])
end

function rect(x, y, w, h, c)
  if c then color(c) end
  x = flr(x)
  y = flr(y)
  w = flr(w)
  h = flr(h)
  love.graphics.rectangle("line", x, y, w, h)
end

function rectfill(x, y, w, h, c)
  if c then color(c) end
  x = flr(x)
  y = flr(y)
  w = flr(w)
  h = flr(h)
  love.graphics.rectangle("fill", x, y, w, h)
end

function _plot4points(
	points, cx, cy, x, y
)
	_horizontal_line(points, cx - x,
		cy + y, cx + x)
	if y ~= 0 then
		_horizontal_line(points, cx - x,
			cy - y, cx + x)
	end
end

function _horizontal_line(
	points, x0, y, x1
)
	for x = x0, x1 do
		table.insert(points, {x, y})
	end
end

function circfill(cx, cy, r, c)
  love.graphics.setColor(palette[c % 16])-- color(c)
	cx = flr(cx) + 1
	cy = flr(cy) + 1
	r = flr(r)

	local x = r
	local y = 0
	local err = 1 - r

	local points = {}

	while y <= x do
		_plot4points(points, cx, cy, x, y)

		if err < 0 then
			err = err + 2 * y + 3
		else
			if x ~= y then
				_plot4points(points, cx, cy, y, x)
			end

			x = x - 1
			err = err + 2 * (y - x) + 3
		end
		y = y + 1
	end

	if #points > 0 then
    for i, p in ipairs(points) do
      love.graphics.rectangle("fill", p[1], p[2], 1, 1)
    end
    -- love.graphics.points(points)
	end
end

function circ(ox, oy, r, c)
	color(c)

	ox = flr(ox) + 1
	oy = flr(oy) + 1
	r = flr(r)

	local points = {}
	local x = r
	local y = 0
	local decisionOver2 = 1 - x

	while y <= x do
		table.insert(points, {ox + x, oy + y})
		table.insert(points, {ox + y, oy + x})
		table.insert(points, {ox - x, oy + y})
		table.insert(points, {ox - y, oy + x})

		table.insert(points, {ox - x, oy - y})
		table.insert(points, {ox - y, oy - x})
		table.insert(points, {ox + x, oy - y})
		table.insert(points, {ox + y, oy - x})

		y = y + 1
		if decisionOver2 < 0 then
			decisionOver2 = decisionOver2
				+ 2 * y + 1
		else
			x = x - 1
			decisionOver2 = decisionOver2
				+ 2 * (y - x) + 1
		end
	end
	if #points > 0 then
		love.graphics.points(points)
	end
end
