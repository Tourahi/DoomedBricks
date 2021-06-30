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

    -- flags
    @updateBalls = false


  update: (dt) =>
    @updateFlags!
    @paddle\update dt
    @resetBall!
    if @updateBalls
      @ballsM\update dt
    s,@bricks = @collisions\resolve_collisions @ballsM\getBalls!, @paddle, @bricks
    @score += s
    if Keyboard.wasPressed 'escape'
      Event.quit!

  updateFlags: () =>
    if Keyboard.wasPressed 'b'
      @updateBalls = not @updateBalls

  resetBall: () =>
    if Keyboard.wasPressed 'r'
      @ballsM\setAllPos @paddle.x + (@paddle.width / 2) - 4, @paddle.y - 8

  draw: =>
    @paddle\draw!
    @ballsM\draw!
    for _, brick in pairs @bricks
      brick\draw!
    Util.DrawHealth @health
    Util.DrawScore @score
    Util.DrawLevel @level
