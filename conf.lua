--io.stdout:setvbuf("no")

function love.conf(t)
  t.identity = "CurseOfTheArrow"
  t.version = "11.1"
  t.accelerometerjoystick = false
  t.externalstorage = true
  t.gammacorrect = false

  t.window.width = 192 * 5
  t.window.height = 128 * 5
  t.window.resizable = true
  t.window.minwidth = 192
  t.window.minheight = 128
  t.window.msaa = 0
  t.window.title = "Curse of the Arrow v1.6 - by @egordorichev"
  t.window.vsync = true

  t.modules.video = false
  t.modules.physics = false
  t.modules.thread = false
end