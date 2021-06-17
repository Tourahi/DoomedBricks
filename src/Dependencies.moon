
export Push  = assert require 'luaLibs/push'

export Bino  = assert require 'luaLibs/Binocles'
Bino!

export Graphics = love.graphics
export Window = love.window
export Keyboard = love.keyboard
export Event = love.event

assert require 'src/constants'
assert require 'src/colors'

assert require 'src/StateMachine'
assert require 'src/states/BaseState'
assert require 'src/states/StartState'




export WinS = {
  vsync: true,
  fullscreen: false,
  resizable: true
}
