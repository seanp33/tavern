local PlayerSystem = {}

PlayerSystem.filter = tiny.requireAll('isPlayer', 'controllable')

function PlayerSystem:init()
   print('DEBUG - PlayerSystem:init')
end

function PlayerSystem:process(e, dt)
   local left = love.keyboard.isDown('a') or love.keyboard.isDown('left')
   local right = love.keyboard.isDown('d') or love.keyboard.isDown('right')
   local jump = love.keyboard.isDown('space') or love.keyboard.isDown('up')
   if right and not jump then
      if e.flippedH then e.animation:flipH() end
      e.velocityX = 50
      e:walk()
   elseif left and not jump then
      if not e.flippedH then e.animation:flipH() end
      e.velocityX = -50
      e:walk()
   elseif jump then
      e:jump()
   elseif not right and not left and not jump then
      e.velocityX = 0
      e:idle()
   end
   e:update(dt)
   e:draw()
end

return tiny.processingSystem(PlayerSystem)
