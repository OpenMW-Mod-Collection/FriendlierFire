local self = require('openmw.self')
local I = require('openmw.interfaces')
local types = require('openmw.types')

require("scripts.FriendlierFire.logic.combat")
require("scripts.FriendlierFire.logic.spells")

-- +----------------------------------+
-- | Physical Attack and Aggro Handler|
-- +----------------------------------+

I.Combat.addOnHitHandler(AttackHandler)

-- +----------------------+
-- | Harmful Spell Handler|
-- +----------------------+

-- SpellCount = #self.type.activeSpells(self)

function SpellUpdate()
    -- local activeSpells = self.type.activeSpells(self)
    -- local currSpellCount = #activeSpells
    -- if currSpellCount >= SpellCount then
    --     SpellCount = currSpellCount
    --     local state = I.FollowerDetectionUtil.getState()

    --     -- if not (player or player follower)
    --     local summoner
    --     if self.recordId:find("_summon$") or self.recordId:find("_summ$") then
    --         -- summoner = types.Summonable.getSummoner(self)
    --     end

    --     if self.type ~= types.Player
    --         or not state.leader
    --         or state.leader.type ~= types.Player
    --     then
    --         return
    --     end

    --     RemoveFriendlyHarmfulSpells(self, activeSpells)
    -- else
    --     SpellCount = currSpellCount
    -- end
end
