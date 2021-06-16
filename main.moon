assert require 'src/Dependencies'

with love
  .load = (arg) ->
    Bino\watch "FPS",-> love.timer.getFPS!
    Graphics.setDefaultFilter 'nearest', 'nearest'
    math.randomseed os.time!
    Window.setTitle "Doomed Bricks"
    Graphics.setFont Res.Fonts['small']
    Push\setupScreen VIRTUAL_WIDTH, VIRTUAL_HEIGHT,
      WINDOW_WIDTH, WINDOW_HEIGHT, WinS

    export gStateMachine = StateMachine {
      ['start']: -> StartState!
    }
    gStateMachine\change 'start'
    Keyboard.keysPressed = {}


  .update = () ->
    Bino\update!
    gStateMachine\update dt
    Keyboard.keysPressed = {}

  .resize = (w, h) ->
    Push\resize w, h

  .draw = () ->
    Bino\draw!
    Push\apply 'start'
    gStateMachine\draw!
    Push\apply 'end'
  .keypressed = (key) ->
    Keyboard.keysPressed[key] = true

  Keyboard.wasPressed = (key) ->
    if Keyboard.keysPressed[key]
      return true
    else
      return false
