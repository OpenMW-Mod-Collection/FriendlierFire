local storage = require('openmw.storage')
local self = require("openmw.self")
local I = require("openmw.interfaces")

require("scripts.FriendlierFire.actorCommon")
require("scripts.FriendlierFire.utils.dependencies")

CheckDependencies(self, {
    ["FollowerDetectionUtil.omwscripts"] = I.FollowerDetectionUtil == nil
})

local sectionPtF = storage.globalSection('SettingsFriendlierFire_playerToFollowers')

local function onUpdate()
    if sectionPtF:get("disableSpells") then SpellUpdate() end
end

local function localEnemyTargetChanged(data)
    data.actor:sendEvent("FriendlyFire_TargetChanged", { target = self })
end

return {
    -- engineHandlers = {
    --     onUpdate = onUpdate,
    -- },
    eventHandlers = {
        OMWMusicCombatTargetsChanged = localEnemyTargetChanged
    }
}