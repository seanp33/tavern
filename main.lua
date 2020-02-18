local tiny = require 'lib.tiny'
local anim8 = require 'lib.anim8'

require 'entity'

local util = require 'util'

local images = {}

function love.load()
   envImg = love.graphics.newImage('img/environment.png')
   walkingImg = love.graphics.newImage('img/walking.png')
   walkingGrid = anim8.newGrid(32, 32, 128, 32, 0, 0, 0)
   walkingAnim = anim8.newAnimation(walkingGrid('1-4', 1), 0.1)

   idleImg = love.graphics.newImage('img/idle.png')
   idleGrid = anim8.newGrid(32, 32, 128, 32, 0, 0, 0)
   idleAnim = anim8.newAnimation(idleGrid('1-4', 1), 0.1)
   
   jumpImg = love.graphics.newImage('img/jump.png')
   jumpingGrid = anim8.newGrid(32, 32, 256, 32, 0, 0, 0)
   jumpingAnim = anim8.newAnimation(jumpingGrid('1-8', 1), 0.1)   
end

function love.update(dt)
   walkingAnim:update(dt)
   idleAnim:update(dt)
   jumpingAnim:update(dt)
end

function love.draw()
   red = 99/255
   green = 155/255
   blue = 255/255
   love.graphics.setBackgroundColor({red,green,blue})
   love.graphics.draw(envImg, 110, 126)
   walkingAnim:draw(walkingImg, 104, 100)
   idleAnim:draw(idleImg, 161, 100)
   jumpingAnim:draw(jumpImg, 192, 100)
   for k,v in pairs(images) do
      love.graphics.draw(v, util.center(v))
   end   
end

function love.keypressed(key)
   if (key == 'a' or key == 'left') and not walkingAnim.flippedH then
      walkingAnim:flipH()
   elseif (key == 'd' or key == 'right') and walkingAnim.flippedH then
         walkingAnim:flipH()
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
