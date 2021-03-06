function init()
  _x = config.getParameter("healthDown", 0)
baseValue = config.getParameter("healthDown",0)*(status.resource("energy"))

  --if (status.resourceMax("health")) * _x >= 100.0 then
     effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue }})
     --else
     --effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue }})
 --end
  
  animator.setParticleEmitterOffsetRegion("drips", mcontroller.boundBox())
  animator.setParticleEmitterActive("drips", true)
  
  script.setUpdateDelta(5)

  self.tickDamagePercentage = 0.035
  self.tickTime = 3.0
  self.tickTimer = self.tickTime  
end

function update(dt)
  self.tickTimer = self.tickTimer - dt
  if self.tickTimer <= 0 then
    self.tickTimer = self.tickTime
    status.applySelfDamageRequest({
        damageType = "IgnoresDef",
        damage = math.floor(status.resourceMax("health") * self.tickDamagePercentage) + 1,
        damageSourceKind = "poison",
        sourceEntityId = entity.id()
      })
  end

  effect.setParentDirectives("fade=806e4f="..self.tickTimer * 0.4)

end

function uninit()
  
end