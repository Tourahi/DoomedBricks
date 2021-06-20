Paddle = assert require 'src/Paddle'
Ball = assert require 'src/Ball'
LevelMaker = assert require 'src/LevelMaker'
Collisions = assert require 'src/Collisions'

import random from math

export class PlayState extends BaseState
  new: =>
    @paused = false
    @paddle = Paddle 'medium'
    @ball = Ball random 7
    @bricks = LevelMaker.createMap!
    @collisions = Collisions!


  update: (dt) =>
    if @paused
      if Keyboard.wasPressed 'space'
        @paused = false
        Res.Sounds['pause']\play!
      else
        return
    elseif Keyboard.wasPressed 'space'
      @paused = true
      Res.Sounds['pause']\play!
      return
    @paddle\update dt
    @ball\update dt

    @collisions\resolve_collisions @ball, @paddle, @bricks

    --if @ball\collides @paddle
     -- @ball.dy = -@ball.dy
      --Res.Sounds['paddle-hit']\play!

    --for k, brick in pairs @bricks
      --if brick.inGame and @ball\collides brick
       -- brick\hit!


    if Keyboard.wasPressed 'escape'
      Event.quit!

  draw: =>
    @paddle\draw!
    @ball\draw!

    for k, brick in pairs @bricks
      brick\draw!

    if @paused
      Graphics.setFont Res.Fonts['large']
      Graphics.printf "PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center'


