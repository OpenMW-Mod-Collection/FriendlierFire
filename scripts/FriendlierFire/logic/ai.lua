local I = require('openmw.interfaces')
local types = require('openmw.types')

local function AttackPlayerFilter(pkg)
    return not (pkg.type == "Combat" and pkg.target.type == types.Player)
end

function StopAttackingLeader(data)
    if AttackPlayerFilter({ type = "Combat", target = data.target }) then
        return
    end

    local state = I.FollowerDetectionUtil.getState()

    if state.followsPlayer then
        I.AI.filterPackages(AttackPlayerFilter)
        -- print("Friendlier Fire: Stopped attacking ".. self.recordId .."'s leader.")
        return
    end
end
