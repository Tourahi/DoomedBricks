import ceil from math
import max from math

resolution_o = {}

sound_o = {
  "On",
  "Off"
}

choices = {
  {c:1,max:2},
  {c:1,max:2},
}

export class SettingsState extends BaseState

  new: =>
    resolution_o = {
      {w: Graphics.getWidth!, h: Graphics.getHeight!},
      {w: 720, h: 720},
    }
    @opts = 3
    @highlighted = 1
    @res = resolution_o[choices[1].c].w ..'x' .. resolution_o[choices[1].c].h
    @sound = sound_o[choices[2].c]


  update: (dt) =>
    if Keyboard.wasPressed('up') or Keyboard.wasPressed('down')
      @highlighted += 1
      if @highlighted > @opts
        @highlighted = 1
      Res.Sounds['paddle-hit']\play!

    --if @highlighted == 1 and Keyboard.wasPressed 'right'
      --choices[1].c =

    if Keyboard.wasPressed('escape')
      Event.quit!


  draw: =>

    Graphics.setFont Res.Fonts['medium']
    if @highlighted == 1
      Graphics.setColor(Colors.blueviolet)

    Graphics.printf "< Resolution : " .. @res .." >", 0,
      ceil(70), VIRTUAL_WIDTH, 'center'

    Graphics.setColor(Colors.white)

    if @highlighted == 2
      Graphics.setColor(Colors.blueviolet)

    Graphics.printf "< Sound : " .. @sound .." >", 0,
      ceil(90), VIRTUAL_WIDTH, 'center'

    Graphics.setColor(Colors.white)

    Graphics.setColor(Colors.white)

    if @highlighted == 3
      Graphics.setColor(Colors.crimson)

    Graphics.printf "Done", 0,
      ceil(120), VIRTUAL_WIDTH, 'center'

    Graphics.setColor(Colors.white)
