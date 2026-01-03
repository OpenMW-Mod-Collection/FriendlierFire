local core = require("openmw.core")

local l10n = core.l10n("FriendlierFire")
local mainMod = "Friendlier Fire"

function CheckDependencies(player, dependencies)
    for fileName, interfaceMissing in pairs(dependencies) do
        local filePresent = core.contentFiles.has(string.lower(fileName))
        if not filePresent or interfaceMissing then
            local msg = l10n("dependency_missing", {
                mainMod = mainMod,
                dependency = fileName
            })
            player:sendEvent('ShowMessage', { message = msg })
        end
    end
end