local I = require('openmw.interfaces')
local types = require('openmw.types')
local storage = require('openmw.storage')

local sectionOther = storage.globalSection('SettingsFriendlierFire_other')

local function AttackPlayerFilter(pkg)
    return not (pkg.type == "Combat" and pkg.target.type == types.Player)
end

local function stopAttackingPlayer(data)
    if AttackPlayerFilter({ type = "Combat", target = data.target }) then
        return
    end

    local state = I.FollowerDetectionUtil.getState()
    if state.followsPlayer then
        I.AI.filterPackages(AttackPlayerFilter)
    end
end

local function stopAttackingFollower(data)
    local followers = I.FollowerDetectionUtil.getFollowerList()
    if not followers[data.target.id] then return end

    I.AI.filterPackages(function (pkg)
        return not (pkg.type == "Combat" and followers[pkg.target.id])
    end)
end

function TargetChanged(data)
    if not sectionOther:get("disableAggro") then return end
    stopAttackingPlayer(data)
    stopAttackingFollower(data)
end
