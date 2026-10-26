local types = require("openmw.types")
local self = require("openmw.self")
local I = require("openmw.interfaces")
local core = require("openmw.core")

local activeSpells = self.type.activeSpells(self)

local function isAlly(actor, state)
    if types.Player.objectIsInstance(actor) then return true end
    return state ~= nil and state.followsPlayer
end

local function isFriendlyFire(spell, followers)
    local caster = spell.caster
    if not caster or caster.id == self.id then return false end

    return isAlly(caster, followers[caster.id])
        and isAlly(self, followers[self.id])
end

local function isHarmful(spell)
    for _, effect in pairs(spell.effects) do
        if core.magic.effects.records[effect.id].harmful then
            return true
        end
    end
    return false
end

function UpdateActiveSpells()
    local followers = I.FollowerDetectionUtil.getFollowerList()
    local newSpells = {}

    for _, spell in pairs(activeSpells) do
        if spell.temporary
            and isFriendlyFire(spell, followers)
            and isHarmful(spell)
        then
            table.insert(newSpells, spell)
        end
    end

    return newSpells
end

function RemoveFriendlyHarmfulSpells(newSpells)
    if not next(newSpells) then return end

    for _, spell in ipairs(newSpells) do
        activeSpells:remove(spell.activeSpellId)
    end
end
