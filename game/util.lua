local module = {}

-- creates a new Image for the given raw data
function module.dataAsImage(data)
   local newFileData = love.filesystem.newFileData
   local newImageData = love.image.newImageData
   local newImage = love.graphics.newImage
   return newImage(newImageData(newFileData(data, 'img', 'file')))
end

-- centers the specified image at absolute center of the screen
function module.center (image)
   local sw = love.graphics.getWidth()
   local sh = love.graphics.getHeight()
   local iw = image:getWidth()
   local ih = image:getHeight()
   return (sw/2) - (iw/2), (sh/2) - (ih/2)
end

return module
