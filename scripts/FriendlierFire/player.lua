local storage = require('openmw.storage')
local self = require("openmw.self")
local I = require("openmw.interfaces")

require("scripts.FriendlierFire.actorCommon")
require("scripts.FriendlierFire.utils.dependencies")

CheckDependencies(self, {
    ["FollowerDetectionUtils.omwscripts"] = I.FollowerDetectionUtils == nil
})

local sectionPtF = storage.globalSection('SettingsFriendlierFire_playerToFollowers')

local function onUpdate()
    if sectionPtF:get("disableSpells") then SpellUpdate() end
end

local function localEnemyTargetsChanged(data)
    data.actor:sendEvent("TargetChanged", { target = self })
end

return {
    -- engineHandlers = {
    --     onUpdate = onUpdate,
    -- },
    eventHandlers = {
        OMWMusicCombatTargetsChanged = localEnemyTargetsChanged
    }
}