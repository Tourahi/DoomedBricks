
import ceil from math

export class StartState extends BaseState
  new: =>
    @highlighted = 1
    @opts = 3

  update: (dt) =>
    if Keyboard.wasPressed('up') or Keyboard.wasPressed('down')
      @highlighted += 1
      if @highlighted > @opts
        @highlighted = 1
      Res.Sounds['paddle-hit']\play!

    if Keyboard.wasPressed('escape')
      Event.quit!

  draw: =>
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


