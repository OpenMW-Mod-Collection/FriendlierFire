local storage = require('openmw.storage')
local types = require('openmw.types')
local self = require('openmw.self')

require("scripts.FriendlierFire.actorCommon")
require("scripts.FriendlierFire.logic.ai")

local sectionFtP = storage.globalSection('SettingsFriendlierFire_followersToPlayer')

local followsPlayer = FollowsPlayer()

local function onUpdate()
    if sectionFtP:get("disableSpells") then SpellUpdate() end
end

local function startAIPackage(pkg)
    if pkg.type == "Follow" then
        followsPlayer = pkg.target.type == types.Player
    end
end

local function removeAIPackage(pkgType)
    if pkgType == "Follow" then
        followsPlayer = false
    end
end

---@param data table { sender = actor }
local function CheckSummonersLeader(data)
    data.sender:sendEvent("Summon_SummonerFollowsPlayer", { followsPlayer = followsPlayer })
end

---@param data table { followsPlayer = boolean }
local function SummonerFollowsPlayer(data)
    followsPlayer = data.followsPlayer
end

return {
    -- engineHandlers = {
    --     onUpdate = onUpdate,
    -- },
    eventHandlers = {
        StartAIPackage = startAIPackage,
        RemoveAIPackage = removeAIPackage,
        -- custom events
        StopAttackingLeader = StopAttackingLeader,
        Summon_CheckSummonersLeader = CheckSummonersLeader,
        Summon_SummonerFollowsPlayer = SummonerFollowsPlayer,
    },
    interfaceName = 'FriendlierFire_nonPlayer',
    interface = {
        followsPlayer = function() return followsPlayer end,
    },
}
