import ceil from math
import max from math
import min from math

resolution_o = {}

sound_o = {
  "On",
  "Off"
}

choices = {
  {c:2,max:3},
  {c:1,max:2},
}

export class SettingsState extends BaseState

  new: (P) =>
    @loveframes = P.loveframes
    resolution_o = {
      {w: 720, h: 576},
      {w: 1280, h: 720},
      {w: 1920, h: 1080},
    }
    @opts = 3
    @highlighted = 1
    @res = ""
    @resIdx = 2
    @sound = ""
    @soundIdx = 1
    @updateOPtions!


  updateOPtions: =>
    @res = resolution_o[choices[1].c].w ..'x' .. resolution_o[choices[1].c].h
    @sound = sound_o[choices[2].c]

  updateInGame: (opt) =>
    switch opt
      when 1
        w,h = resolution_o[choices[1].c].w, resolution_o[choices[1].c].h
        Window.setMode w, h, {resizable: false}
        Push\resize w, h
      when 2
        switch @sound
          when "On"
            Audio.setVolume 1
          when "Off"
            Audio.setVolume 0



  update: (dt) =>
    opt = @highlighted
    if Keyboard.wasPressed('up') or Keyboard.wasPressed('down')
      @highlighted += 1
      if @highlighted > @opts
        @highlighted = 1
      Res.Sounds['paddle-hit']\play!
    if opt < @opts
      if @highlighted == opt and Keyboard.wasPressed('right')
        choices[opt].c = min choices[opt].c + opt, choices[opt].max
        @updateOPtions!
        @updateInGame opt
      elseif @highlighted == opt and Keyboard.wasPressed('left')
        choices[opt].c = max choices[opt].c - 1, 1
        @updateOPtions!
        @updateInGame opt

    if @highlighted == 3 and (Keyboard.wasPressed('enter') or Keyboard.wasPressed('return'))
      GStateMachine\change 'start',{
        loveframes: @loveframes
      }



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
