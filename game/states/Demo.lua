local EnvironmentSystem = require 'game.systems.EnvironmentSystem'
local PlayerSystem = require 'game.systems.PlayerSystem'
local Environment = require 'game.entities.Environment'
local Player = require 'game.entities.Player'
local tags = require 'game.tags'

local Demo = class("Demo")

function Demo:load()
   print('DEBUG - Demo: loading map')
   local map = sti('production/demo_map.lua', {'box2d'})
   _G.map = map

   local mapObjects = {}
   for _, ob in pairs(map.objects) do
      if ob.name then
         print('adding by name ' .. ob.name)
         mapObjects[ob.name] = ob
      else
         print('adding by id ' .. ob.id)
         mapObjects[ob.id] = ob
      end      
   end
   _G.mapObjects = mapObjects

   local playerSpawn = mapObjects[tags.PLAYER_SPAWN]
   if  playerSpawn then
      print('player start - x:' .. tostring(playerSpawn.x))
      print('player start - y:' .. tostring(playerSpawn.y))
   else
      print('ERROR - could not find the player_start object in the mapObjects table')
   end   
    
   -- hide the zones
   map.layers['zones'].opacity = 0
   
   print('DEBUG - Demo: Initializing tiny world')
   local systemsWorld = tiny.world()
   systemsWorld:addSystem(PlayerSystem)
   systemsWorld:addSystem(EnvironmentSystem)
   systemsWorld:addEntity(Player({x=playerSpawn.x+15, y=playerSpawn.y-100}))
   systemsWorld:addEntity(Environment({bColor={r=99/255, g=155/255, b=255/255}, x=110, y=126}))
   systemsWorld:refresh()
  _G.systemsWorld = systemsWorld   
end

return Demo
