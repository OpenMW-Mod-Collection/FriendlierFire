local self = require('openmw.self')
local types = require('openmw.types')
local core = require('openmw.core')

local activeSpells = types.Actor.activeSpells(self)
local newSpellCount = userDataLength(types.Actor.activeSpells(self))
if newSpellCount ~= spellCount then
    for a, b in pairs(types.Actor.activeSpells(self)) do
        local friendlyFire = false
        if types.Player.objectIsInstance(b.caster) then
            --local spell = core.magic.spells.records[b.id]
            for c, d in pairs(b.effects) do
                local effect = core.magic.effects.records[d.id]
                if effect.harmful then
                    friendlyFire = true
                end
            end
        end
        if friendlyFire then
            types.Actor.activeSpells(self):remove(b.activeSpellId)
        end
    end
end
spellCount = newSpellCount
