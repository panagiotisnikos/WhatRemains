WR = WR or {}

WR.DefaultState = {
    started = false,
    completed = false,

    flags = {},

    quests = {}
}

local function initializeState()
    WR.State = ModData.getOrCreate("WhatRemains")

    for key, defaultValue in pairs(WR.DefaultState) do
        if WR.State[key] == nil then
            WR.State[key] = defaultValue
        end
    end

    print("[What Remains] State initialized")
end

Events.OnInitGlobalModData.Add(initializeState)

print("[What Remains] Server loaded")