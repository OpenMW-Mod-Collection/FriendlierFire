local I = require('openmw.interfaces')
local self = require('openmw.self')
local types = require('openmw.types')

function GetLeader()
    local followedActor
    I.AI.forEachPackage(function(pkg)
        if pkg.type == "Follow" then
            followedActor = pkg.target
            return
        end
    end)
    return followedActor
end

function FollowsPlayer()
    local followedActor = GetLeader()
    if not followedActor then return false end

    local followsPlayer = followedActor.type == types.Player
    local isSummon = string.find(self.recordId, "_summon$")
        or string.find(self.recordId, "_summ$")

    if not followsPlayer and isSummon then
        followedActor:sendEvent("Summon_CheckSummonersLeader", { sender = self })
    end

    return followsPlayer
end

local function AttackPlayerFilter(pkg)
    return not (pkg.type == "Combat" and pkg.target.type == types.Player)
end

function StopAttackingLeader(data)
    if AttackPlayerFilter({ type = "Combat", target = data.target }) then
        return
    end

    if I.FriendlierFire_nonPlayer.followsPlayer() then
        I.AI.filterPackages(AttackPlayerFilter)
        -- print("Friendlier Fire: Stopped attacking ".. self.recordId .."'s leader.")
        return
    end
end
