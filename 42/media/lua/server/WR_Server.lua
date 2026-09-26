-- Main namespace for the mod.
WR = WR or {}

-- Default structure for a new campaign save.
-- Flags store things that have happened in the world.
-- Quests will store the shared progress of the questline.
WR.DefaultState = {
    started = false,
    completed = false,
    flags = {},
    quests = {}
}

-- Loads the campaign state saved with this world.
-- Missing fields are filled with defaults without resetting existing progress.
local function initializeState()
    WR.State = ModData.getOrCreate("WhatRemains")

    for key, defaultValue in pairs(WR.DefaultState) do
        if WR.State[key] == nil then
            WR.State[key] = defaultValue
        end
    end

    print("[What Remains] State initialized")
end

-- Sets a persistent world flag.
-- Example: WR.setFlag("radioClueFound", true)
function WR.setFlag(flagName, value)
    if WR.State == nil then
        print("[What Remains] ERROR: Tried to set flag before state initialization")
        return
    end

    WR.State.flags[flagName] = value

    print("[What Remains] Flag '" .. flagName .. "' set to " .. tostring(value))
end

-- Returns the current value of a world flag.
-- Returns nil if the flag has never been set.
function WR.getFlag(flagName)
    if WR.State == nil then
        print("[What Remains] ERROR: Tried to get flag before state initialization")
        return nil
    end

    return WR.State.flags[flagName]
end

-- Initialize our state after Project Zomboid loads the world's Global Mod Data.
Events.OnInitGlobalModData.Add(initializeState)

print("[What Remains] Server loaded")