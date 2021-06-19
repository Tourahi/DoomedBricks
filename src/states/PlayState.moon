Paddle = assert require 'src/Paddle'

export class PlayState extends BaseState
  new: =>
    @paused = false
    @paddle = Paddle!

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

    if Keyboard.wasPressed 'escape'
      Event.quit!

  draw: =>
    @paddle\draw!

    if @paused
      Graphics.setFont Res.Fonts['large']
      Graphics.printf "PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center'


