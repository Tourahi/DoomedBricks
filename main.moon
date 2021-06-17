assert require 'src/Dependencies'

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
    Push\start!
    backgroundW = Res.Textures['background']\getWidth!
    backgroundH = Res.Textures['background']\getHeight!
    Graphics.draw Res.Textures['background'], 0, 0, 0,
        VIRTUAL_WIDTH / (backgroundW - 1), VIRTUAL_HEIGHT / (backgroundH - 1)
    gStateMachine\draw!
    Push\finish!
    Bino\draw!
  .keypressed = (key) ->
    Keyboard.keysPressed[key] = true

  Keyboard.wasPressed = (key) ->
    if Keyboard.keysPressed[key]
      return true
    else
      return false
