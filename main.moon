assert require 'src/Dependencies'

import ceil from math

with love
  .load = (arg) ->
    Bino\watch "FPS",-> love.timer.getFPS!

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
    Bino\draw!

  .keypressed = (key) ->
    Keyboard.keysPressed[key] = true

  Keyboard.wasPressed = (key) ->
    if Keyboard.keysPressed[key]
      return true
    else
      return false
