
export class StartState extends BaseState
  new: =>
    @highlighted = 1

  update: (dt) =>
    if Keyboard.wasPressed('up') or Keyboard.wasPressed('down')
      @highlighted = @highlighted == 1 and 2 or 1
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
      VIRTUAL_HEIGHT / 2 + 50, VIRTUAL_WIDTH, 'center'

    Graphics.setColor(Colors.white)
    if @highlighted == 2
      Graphics.setColor(Colors.blueviolet)

    Graphics.printf "High Scores", 0,
      VIRTUAL_HEIGHT / 2 + 70, VIRTUAL_WIDTH, 'center'

    Graphics.setColor(Colors.white)


