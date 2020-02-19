local EnvironmentSystem = require 'game.systems.EnvironmentSystem'
local PlayerSystem = require 'game.systems.PlayerSystem'
local Environment = require 'game.entities.Environment'
local Player = require 'game.entities.Player'

local Demo = class("Demo")

function Demo:load()
   print('DEBUG - Demo:load')
   local world = tiny.world()
   world:addSystem(EnvironmentSystem)
   world:addSystem(PlayerSystem)
   world:addEntity(Environment({bColor={r=99/255, g=155/255, b=255/255}, x=110, y=126}))
   world:addEntity(Player({x=104, y=100}))
   world:refresh()
   _G.world = world
   
end

return Demo
