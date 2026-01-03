local storage = require('openmw.storage')

require("scripts.FriendlierFire.actorCommon")
require("scripts.FriendlierFire.logic.ai")

local sectionFtP = storage.globalSection('SettingsFriendlierFire_followersToPlayer')

local function onUpdate()
    if sectionFtP:get("disableSpells") then SpellUpdate() end
end

return {
    -- engineHandlers = {
    --     onUpdate = onUpdate,
    -- },
    eventHandlers = {
        StopAttackingLeader = StopAttackingLeader,
    }
}
