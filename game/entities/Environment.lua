local assets = require 'game.assets'

local Environment = class("Environment")

function Environment:init(config)
   print('DEBUG - Environment:init')
   self.isEnvironment = true
   self.pos = {x = config.x or 0, y = config.y or 0}
   self.bColor = config.bColor or {r=99/255, g=155/255, b=255/255}
   self.animation = self.idleAnim
   self.sprite = assets.envImg
end

function Environment:draw()
   love.graphics.setBackgroundColor({self.bColor.r, self.bColor.g, self.bColor.b})
   love.graphics.draw(self.sprite, self.pos.x, self.pos.y)
end


return Environment
