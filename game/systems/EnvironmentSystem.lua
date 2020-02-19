local EnvironmentSystem = {}

EnvironmentSystem.filter = tiny.requireAll('isEnvironment')

function EnvironmentSystem:process(e, dt)
   e:draw()
end

return tiny.processingSystem(EnvironmentSystem)

