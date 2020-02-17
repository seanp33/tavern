local tiny = require 'lib.tiny'
local anim8 = require 'lib.anim8'

require 'entity'

local util = require 'util'

local images = {}

function love.load()
   walkingImg = love.graphics.newImage('img/walking.png')
   idleImg = love.graphics.newImage('img/idle.png')
   jumpImg = love.graphics.newImage('img/jump.png')
   loopingGrid = anim8.newGrid(32, 32, 128, 32, 0, 0, 0)
   loopingAnim = anim8.newAnimation(loopingGrid('1-4', 1), 0.1)
   jumpingGrid = anim8.newGrid(32, 32, 256, 32, 0, 0, 0)
   jumpingAnim = anim8.newAnimation(jumpingGrid('1-8', 1), 0.1)   
end

function love.update(dt)
   loopingAnim:update(dt)
   jumpingAnim:update(dt)
end

function love.draw()
   red = 97/255
   green = 85/255
   blue = 97/255
   love.graphics.setBackgroundColor({red,green,blue})
   loopingAnim:draw(walkingImg, 100, 100)
   loopingAnim:draw(idleImg, 150, 100)
   jumpingAnim:draw(jumpImg, 200, 100)
   for k,v in pairs(images) do
      love.graphics.draw(v, util.center(v))
   end   
end

function love.filedropped(file)
   local name = file:getFilename()
   local len = string.len(name)
   local ext = string.sub(name, len-2, len)
   if(ext == 'png') then
      if(file:open('r'))then
         local data = file:read()
         file:close()
         ok, image = pcall(util.dataAsImage, data)
         if ok and image then
            images[name] = image
         else
            print("could not load image " .. images[name])
         end         
      end
   end   
end
