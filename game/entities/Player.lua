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
   self.velocityX = 0
end

function Player:update(dt)
   self.pos.x = self.pos.x + (self.velocityX * dt)
   self.animation:update(dt)
   self.animation:resume()
end

function Player:draw()
   self.animation:draw(self.sprite, self.pos.x, self.pos.y)   
end

function Player:idle()
   if self.controllable then
      self.sprite = assets.idleImg
      self.animation = self.idleAnim
      self.jumpingAnim:gotoFrame(1)
   end
end

function Player:walk()
   if self.controllable then
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
