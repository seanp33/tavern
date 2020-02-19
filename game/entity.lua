Entity = {}

Entity.__index = Entity

IDLE_MODE, WALK_MODE, RUN_MODE, DIE_MODE = 1, 2, 3, 4

local MODES = {IDLE_MODE, WALK_MODE, RUN_MODE, DIE_MODE}

local  ENTITY_COUNT = 0

function Entity.getCount()
   return ENTITY_COUNT
end

function Entity.create(title)
   local self = setmetatable({}, Entity)
   self.title = title
   self.currentMode = IDLE_MODE
   ENTITY_COUNT = ENTITY_COUNT + 1
   return self
end

function Entity:idle()
   self.currentMode = IDLE_MODE
end

function Entity:walk()
   self.currentMode = WALK_MODE
end

function Entity:run()
   self.currentMode = RUN_MODE
end

function Entity:die()
   self.currentMode = DIE_MODE
end

function Entity:report()
   print('Entity ' .. self.title .. ' is in mode ' .. MODES[self.currentMode])
end

   
