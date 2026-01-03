local storage = require('openmw.storage')
local self = require("openmw.self")
local I = require("openmw.interfaces")

require("scripts.FriendlierFire.actorCommon")
require("scripts.FriendlierFire.logic.ai")

local sectionFtP = storage.globalSection('SettingsFriendlierFire_followersToPlayer')

local function onUpdate()
    if sectionFtP:get("disableSpells") then SpellUpdate() end
end

local function startAIPackage(pkg)
    TargetChanged(pkg)
end

local function checkTargetsLeader(data)
    local state = I.FollowerDetectionUtil.getState()
    if state.followsPlayer then
        data.sender:sendEvent("StopAttackingOtherFollower", { sender = self })
    end
end

return {
    -- engineHandlers = {
    --     onUpdate = onUpdate,
    -- },
    eventHandlers = {
        StartAIPackage = startAIPackage,
        TargetChanged = TargetChanged,
        -- for follower -> follower aggro prevention
        CheckTargetsLeader = checkTargetsLeader,
        StopAttackingOtherFollower = StopAttackingOtherFollower,
    }
}
