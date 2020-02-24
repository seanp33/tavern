-- globals
tiny = require 'lib.tiny'
sti = require 'lib.sti'
anim8 = require 'lib.anim8'
beholder = require 'lib.beholder'
class = require 'lib.30log' -- introduce global 'class' reference

local Demo = require('game.states.Demo')
local paused = false

beholder.observe("keypress", "escape", love.event.quit)

-- TODO: impl game pausing and some kind of pauseCanvas(also used when resizing)
beholder.observe("keypress", "p", function()
	paused = not paused
  print('DEBUG - Paused? ' .. tostring(paused))
  if paused then     
		--love.graphics.setCanvas(pauseCanvas)
		--systemsWorld:update(0)
		--love.graphics.setCanvas()
	end
end)

function love.load()
   love.mouse.setVisible(false)   

   Demo():load()      
   if systemsWorld and map then
      love.physics.setMeter(64)
      physicsWorld = love.physics.newWorld(0, 9.81*64, true)
      map:box2d_init(physicsWorld)      
      print('DEBUG - system count: ' .. systemsWorld:getSystemCount())
      print('DEBUG - entity count: ' .. systemsWorld:getEntityCount())
   else
      print('ERROR - systemsWorld or map undefined. Exiting')
   end
end

function love.draw()   
   -- NOTE: this world:update call has to happen within love.draw, because the ecs update cycle calls entity draw routines
   systemsWorld:update(love.timer.getDelta())

   -- Translation would normally be based on a player's x/y
   local translateX = 0
   local translateY = 0
   
   -- Draw Range culls unnecessary tiles
   --map:setDrawRange(translateX, translateY, windowWidth, windowHeight)
   
   map:draw()
   
   -- Draw Collision Map (useful for debugging)
   love.graphics.setColor(1, 0, 0, 0.7)
   map:box2d_draw()   
   
   -- Reset color
   love.graphics.setColor(1,1,1,1)
end

function love.update(dt)
   map:update(dt)
end

function love.keypressed(k)
   beholder.trigger("keypress", k)  
end

function love.keyreleased(k)
    beholder.trigger("keyrelease", k)
end
