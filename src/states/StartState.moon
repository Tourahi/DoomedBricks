Paddle = assert require 'src/Paddle'
LevelManager = assert require 'src/managers/LevelManager'
BallManager = assert require 'src/managers/BallManager'

import ceil from math

export class StartState extends BaseState
  new: (P) =>
    @highlighted = 1
    @opts = 3
    @loveframes = P.loveframes


  update: (dt) =>
    if Keyboard.wasPressed('up') or Keyboard.wasPressed('down')
      @highlighted += 1
      if @highlighted > @opts
        @highlighted = 1
      Res.Sounds['paddle-hit']\play!

    if @highlighted == 1 and (Keyboard.wasPressed('enter') or Keyboard.wasPressed('return'))
      Res.Sounds['confirm']\play!
      GStateMachine\change 'serve', {
        paddle: Paddle 'medium',
        levelManager: LevelManager!,
        ballsM: BallManager!
        health: 3,
        score: 0,
        level: 1,
        loveframes: @loveframes
      }

    if Keyboard.wasPressed('f5')
      GStateMachine\change 'debug', {
        loveframes: @loveframes
      }


    elseif @highlighted == 3 and (Keyboard.wasPressed('enter') or Keyboard.wasPressed('return'))
      Res.Sounds['confirm']\play!
      GStateMachine\change 'settings'

    if Keyboard.wasPressed('escape')
      Event.quit!

  draw: =>
    -- background
    backgroundW = Res.Textures['background']\getWidth!
    backgroundH = Res.Textures['background']\getHeight!
    Graphics.draw Res.Textures['background'], -80, 0, 0,
        ceil VIRTUAL_WIDTH / (backgroundW - 1), ceil VIRTUAL_HEIGHT / (backgroundH - 1)

    Graphics.setFont Res.Fonts['large']
    Graphics.printf "Doomed Bricks", 0,
      VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center'

    Graphics.setFont Res.Fonts['medium']
    if @highlighted == 1
      Graphics.setColor(Colors.blueviolet)

    Graphics.printf "Start", 0,
      ceil(VIRTUAL_HEIGHT / 2 + 65), VIRTUAL_WIDTH, 'center'

    Graphics.setColor(Colors.white)
    if @highlighted == 2
      Graphics.setColor(Colors.blueviolet)

    Graphics.printf "High Scores", 0,
      ceil(VIRTUAL_HEIGHT / 2 + 85), VIRTUAL_WIDTH, 'center'
    Graphics.setColor(Colors.white)

    if @highlighted == 3
      Graphics.setColor(Colors.blueviolet)

    Graphics.printf "Settings", 0,
      ceil(VIRTUAL_HEIGHT / 2 + 105), VIRTUAL_WIDTH, 'center'
    Graphics.setColor(Colors.white)


