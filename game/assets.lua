local assets = {}
   love.graphics.setDefaultFilter("nearest", "nearest")
   assets.envImg = love.graphics.newImage('img/environment.png')
   assets.mapImg = love.graphics.newImage('img/map.png')
   assets.walkImg = love.graphics.newImage('img/walk.png')
   assets.idleImg = love.graphics.newImage('img/idle.png')
   assets.jumpImg = love.graphics.newImage('img/jump.png')
return assets
