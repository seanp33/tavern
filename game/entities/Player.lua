local assets = require 'game.assets'

local Player = class("Player")

function Player:init(config)   
   print('DEBUG - Player:init')
   local walkingGrid = anim8.newGrid(32, 32, 128, 32, 0, 0, 0)
   local idleGrid = anim8.newGrid(32, 32, 128, 32, 0, 0, 0)
   local jumpingGrid = anim8.newGrid(32, 32, 256, 32, 0, 0, 0)
   self.walkingAnim = anim8.newAnimation(walkingGrid('1-4', 1), 0.1)   
   self.idleAnim = anim8.newAnimation(idleGrid('1-4', 1), 0.1)      
   self.jumpingAnim = anim8.newAnimation(jumpingGrid('1-8', 1), 0.1)
   self.animation = self.idleAnim
   self.sprite = assets.idleImg
   self.isPlayer = true
   self.controllable = true
   self.pos = {x = config.x or 0, y = config.y or 0}
   self.speed = config.speed or 150
   self.fastSpeed = self.speed * 1.5
   self.fast = false
   self.velocityX = 0
   self.direction = 'right'  
end

function Player:currentSpeed()
   if self.fast then
      return self.fastSpeed
   else
      return self.speed
   end
end

function Player:update(dt)
   self.pos.x = self.pos.x + (self.velocityX * dt)
   self.animation:update(dt)
   self.animation:resume()
end

function Player:draw()
   self.animation:draw(self.sprite, self.pos.x, self.pos.y)   
end

function Player:faceRight()
   self.velocityX = self:currentSpeed()
   if self.direction ~= 'right' then
      self.walkingAnim:flipH()
      self.jumpingAnim:flipH()
      self.idleAnim:flipH()
      self.direction = 'right'
   end
end

function Player:faceLeft()
   self.velocityX = self:currentSpeed() * -1
   if self.direction ~= 'left' then
      self.walkingAnim:flipH()
      self.jumpingAnim:flipH()
      self.idleAnim:flipH()
      self.direction = 'left'
   end
end

function Player:idle()
   self.velocityX = 0
   if self.controllable then
      self.sprite = assets.idleImg
      self.animation = self.idleAnim
      self.jumpingAnim:gotoFrame(1)
   end
end

function Player:walk(fast)
   if self.controllable then
      self.fast = fast
      self.sprite = assets.walkImg
      self.animation = self.walkingAnim
      self.jumpingAnim:gotoFrame(1)
   end   
end

function Player:jump()
   if self.controllable then
      self.sprite = assets.jumpImg
      self.animation = self.jumpingAnim
   end
end

return Player
