local EggsData = {
    HalloweenCFrame = Vector3.new(-4922.46289, 25.5243816, -567.863281),
    OverworldEggAreaCFrame = Vector3.new(-69.27651977539062, 9.55966567993164, -27.520709991455078)
    Perm = {
        "Common Egg",
        "Spotted Egg",
        "Iceshard Egg",
        "Inferno Egg",
        "Spikey Egg",
        "Magma Egg",
        "Crystal Egg",
        "Lunar Egg",
        "Void Egg",
        "Hell Egg",
        "Nightmare Egg",
        "Rainbow Egg",
        "Showman Egg",
        "Mining Egg",
        "Cyber Egg",
        "Neon Egg",
        "Icy Egg",
        "Vine Egg",
        "Lava Egg",
        "Secret Egg",
        "Atlantis Egg",
        "Classic Egg"
    },
    Event = {
        Halloween = {
            "Pumpkin Egg",
            "Costume Egg",
            "Sinister Egg",
            "Mutant Egg"
        }
    },
    ActiveEvent = "Halloween",
    AreaToTeleport = {}
}

for _, egg in ipairs(EggsData.Perm) do
    EggsData.AreaToTeleport[egg] = "Workspace.Worlds.The Overworld.FastTravel.Spawn"
end

local activeEvent = EggsData.ActiveEvent
if activeEvent and EggsData.Event[activeEvent] then
    for _, egg in ipairs(EggsData.Event[activeEvent]) do
        EggsData.AreaToTeleport[egg] = "Workspace.HalloweenEvent.Spawn"
    end
end

return EggsData
