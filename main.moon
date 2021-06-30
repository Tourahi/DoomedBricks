assert require 'src/Dependencies'

import ceil from math


with love
  .load = (arg) ->
    Bino\watch "FPS",-> love.timer.getFPS!

    export loveframes = assert require "luaLibs/loveframes"

    Graphics.setDefaultFilter 'nearest', 'nearest'

    assert require 'src/Resources'

    math.randomseed os.time!
    Window.setTitle "Doomed Bricks"
    Graphics.setFont Res.Fonts['small']

    Push\setupScreen VIRTUAL_WIDTH, VIRTUAL_HEIGHT,
      WINDOW_WIDTH, WINDOW_HEIGHT, WinS

    GStateMachine\change 'start'
    Keyboard.keysPressed = {}

  .update = (dt) ->
    loveframes.update dt
    Bino\update!
    GStateMachine\update dt
    Keyboard.keysPressed = {}


  .resize = (w, h) ->
    Window.setMode w, h,{resizable: false}

  .draw = () ->
    Push\start!
    GStateMachine\draw!
    Push\finish!
    Graphics.setFont Res.Fonts['medium']
    loveframes.draw!
    Bino\draw!


  .keypressed = (key, is_r) ->
    Keyboard.keysPressed[key] = true
    loveframes.keypressed key, is_r
    if key == "$"
      dbg = loveframes.config["DEBUG"]
      loveframes.config["DEBUG"] = not dbg

  .mousepressed = (x, y, button) ->
    loveframes.mousepressed x, y, button

  .mousereleased = (x, y, button) ->
    loveframes.mousereleased x, y, button

  .wheelmoved = (x, y) ->
    loveframes.wheelmoved x, y

  .keyreleased = (key) ->
    loveframes.keyreleased key

  .textinput = (text) ->
    loveframes.textinput text
  Keyboard.wasPressed = (key) ->
    if Keyboard.keysPressed[key]
      return true
    else
      return false
