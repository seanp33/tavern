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
   self.layer = config.layer
   self.pos = {x = config.x or 0, y = config.y or 0}
   self.speed = config.speed or 100
   self.force = config.force or 200
   self.currentForce = 0
   self.fastSpeed = self.speed * 1.5
   self.fast = false
   self.velocityX = 0
   self.direction = 'right'
   
   -- physics play
   self.body = love.physics.newBody(physicsWorld, self.pos.x, self.pos.y, "dynamic")
   self.body:setMass(77)
   self.shape = love.physics.newRectangleShape(16, 16, self.sprite:getWidth(), self.sprite:getHeight())
   self.fixture = love.physics.newFixture(self.body, self.shape, .6)

   self.layer.update = function(layer, dt)
      self:update(dt)
   end

   self.layer.draw = function()
      self:draw()
   end
   
end

function Player:currentSpeed()
   if self.fast then
      return self.fastSpeed
   else
      return self.speed
   end
end

function Player:update(dt)
   --self.pos.x = self.pos.x + (self.velocityX * dt)
   self.body:applyForce(self.currentForce, 10)
   self.animation:update(dt)
   self.animation:resume()
end

function Player:draw()
   --self.animation:draw(self.sprite, self.pos.x, self.pos.y)   
   self.animation:draw(self.sprite, self.body:getX(), self.body:getY())
   love.graphics.setColor(1, 0, 0, 0.4)
   love.graphics.rectangle( "fill", self.body:getX(), self.body:getY(), 32, 32)
   love.graphics.setColor(1, 1, 1, 1)   
end

function Player:faceRight()
   self.velocityX = self:currentSpeed()
   self.currentForce = self.force
   if self.direction ~= 'right' then
      self.walkingAnim:flipH()
      self.jumpingAnim:flipH()
      self.idleAnim:flipH()
      self.direction = 'right'
   end
end

function Player:faceLeft()
   self.velocityX = self:currentSpeed() * -1
   self.currentForce = self.force * -1
   if self.direction ~= 'left' then
      self.walkingAnim:flipH()
      self.jumpingAnim:flipH()
      self.idleAnim:flipH()
      self.direction = 'left'
   end
end

function Player:idle()
   self.velocityX = 0
   --self.body:setLinearVelocity(0,0) --BUG: #playermovement | chaneg to slow/stop the player, but only when not jumping. When jumping, the player cannot go idle in the air
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
