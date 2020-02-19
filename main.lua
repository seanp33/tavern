tiny = require 'lib.tiny'
anim8 = require 'lib.anim8'
beholder = require 'lib.beholder'
class = require 'lib.30log' -- introduce global 'class' reference
local Demo = require('game.states.Demo')

local paused = false

beholder.observe("keypress", "escape", love.event.quit)

-- TODO: impl game pausing and some kind of pauseCanvas(also used when resizing)
beholder.observe("keypress", "p", function()
	paused = not paused
  print('Paused? ' .. tostring(paused))
  if paused then     
		--love.graphics.setCanvas(pauseCanvas)
		--world:update(0)
		--love.graphics.setCanvas()
	end
end)

function love.load()
   love.mouse.setVisible(false)
   Demo():load() -- TODO: consider a "gamestate" module that loads States
   print('system count: ' .. world:getSystemCount())
   print('entity count: ' .. world:getEntityCount())
end

function love.draw()   
   if world then      
      world:update(love.timer.getDelta())
   else
      print('No global world found. Unable to update')
   end
end

function love.keypressed(k)
   beholder.trigger("keypress", k)  
end

function love.keyreleased(k)
    beholder.trigger("keyrelease", k)
end
