M = require "moon"
export Dump = M.p


export Push  = assert require 'luaLibs/push'

export Bino  = assert require 'luaLibs/Binocles'
Bino!

export Graphics = love.graphics
export Window = love.window
export Keyboard = love.keyboard
export Event = love.event
export Audio = love.audio
assert require 'src/constants'
assert require 'src/colors'

assert require 'src/StateMachine'
assert require 'src/states/BaseState'
assert require 'src/states/StartState'
assert require 'src/states/PlayState'
assert require 'src/states/SettingsState'
assert require 'src/states/ServeState'
assert require 'src/states/GameOverState'



export GStateMachine = StateMachine {
  ['serve']: (params) -> ServeState params
  ['start']: (params) -> StartState params
  ['play']: (params) -> PlayState params
  ['settings']: (params) -> SettingsState params
  ['game-over']: (params) -> GameOverState params
}


export WinS = {
  vsync: true,
  fullscreen: false,
  resizable: true
}

love.sound.Sound_On = true

