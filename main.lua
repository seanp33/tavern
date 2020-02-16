--[[
   main.lua
   The main entry point into the game
]]--

local images = {}

function love.load()
   love.graphics.newImage('k8s-cluster.png')   
end

function love.update(dt)
end

function love.draw()
   for k,v in pairs(images) do
      --print('will draw image ' .. k) 
      love.graphics.draw(v, center(v))
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
         ok, image = pcall(safeReadImageData, data)
         if ok and image then
            images[name] = image
         else
            print("could not load image " .. images[name])
         end         
      end
   end   
end

function safeReadImageData(data)
   local newFileData = love.filesystem.newFileData
   local newImageData = love.image.newImageData
   local newImage = love.graphics.newImage
   return newImage(newImageData(newFileData(data, 'img', 'file')))
end

function center(image)
   local sw = love.graphics.getWidth()
   local sh = love.graphics.getHeight()
   local iw = image:getWidth()
   local ih = image:getHeight()
   return (sw/2) - (iw/2), (sh/2) - (ih/2)
end
   
