local storage = require('openmw.storage')
local self = require("openmw.self")

require("scripts.FriendlierFire.actorCommon")

local sectionPtF = storage.globalSection('SettingsFriendlierFire_playerToFollowers')

local function onUpdate()
    if sectionPtF:get("disableSpells") then SpellUpdate() end
end

local function localEnemyTargetsChanged(data)
    data.actor:sendEvent("StopAttackingLeader", { target = self })
end

return {
    -- engineHandlers = {
    --     onUpdate = onUpdate,
    -- },
    eventHandlers = {
        OMWMusicCombatTargetsChanged = localEnemyTargetsChanged
    }
}