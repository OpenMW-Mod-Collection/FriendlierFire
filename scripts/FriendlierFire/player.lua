local storage = require('openmw.storage')

-- require("scripts.FriendlierFire.logic.spells")

local sectionPtF = storage.globalSection('SettingsFriendlierFire_playerToFollowers')

local function onUpdate()
    if sectionPtF:get("disableSpells") then SpellUpdate() end
end

local function targetsChanged(data)
    for _, target in ipairs(data.targets) do
        data.actor:sendEvent("StopAttackingLeader", { target = target })
    end
end

return {
    -- engineHandlers = {
    --     onUpdate = onUpdate,
    -- },
    eventHandlers = {
        OMWMusicCombatTargetsChanged = targetsChanged,
    },
}