assert require 'src/Dependencies'

with love
  .load = (arg) ->
    Bino\watch "FPS",-> love.timer.getFPS!
    export gStateMachine = StateMachine {
      ['start']: -> StartState!
    }
    gStateMachine\change 'start'
    Keyboard.keysPressed = {}


  .update = () ->
    Bino\update!
    gStateMachine\update dt
    Keyboard.keysPressed = {}

  .draw = () ->
    Bino\draw!

  .keypressed = (key) ->
    Keyboard.keysPressed[key] = true

  Keyboard.wasPressed = (key) ->
    if Keyboard.keysPressed[key]
      return true
    else
      return false
