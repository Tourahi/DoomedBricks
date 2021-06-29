Paddle = assert require 'src/Paddle'
LevelManager = assert require 'src/managers/LevelManager'
BallManager = assert require 'src/managers/BallManager'
Util = assert require 'src/Util'
Collisions = assert require 'src/Collisions'

export class DebugState extends BaseState
  new: =>
    @paddle = Paddle 'medium'
    @ballsM = BallManager!
    @levelManager = LevelManager!
    @level = 1
    @bricks = @levelManager\generate @level
    @score = 0
    @health = 3
    @collisions = Collisions!


  update: (dt) =>
    @paddle\update dt

    if Keyboard.wasPressed 'escape'
      Event.quit!

  draw: =>
    @paddle\draw!
