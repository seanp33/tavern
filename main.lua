--[[
   main.lua
   The main entry point into the game
]]--

local util = require 'util'

local images = {}

function love.load()
end

function love.update(dt)
end

function love.draw()
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
