local tabletOpen = false

RegisterCommand("cartablet", function()
    toggleTablet()
end)

function toggleTablet()
    tabletOpen = not tabletOpen
    SetNuiFocus(tabletOpen, tabletOpen)

    if tabletOpen then
        TriggerServerEvent("tablet:getVehicles")
        SendNUIMessage({ action = "open" })
    else
        SendNUIMessage({ action = "close" })
    end
end

-- Ontvang voertuigen
RegisterNetEvent("tablet:sendVehicles")
AddEventHandler("tablet:sendVehicles", function(vehicles)
    SendNUIMessage({
        action = "loadVehicles",
        vehicles = vehicles
    })
end)

-- Spawn voertuig
RegisterNUICallback("spawnVehicle", function(data, cb)
    local model = GetHashKey(data.model)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    local vehicle = CreateVehicle(
        model,
        coords.x,
        coords.y,
        coords.z,
        GetEntityHeading(ped),
        true,
        false
    )

    TaskWarpPedIntoVehicle(ped, vehicle, -1)
    cb("ok")
end)

-- SLUIT via knop
RegisterNUICallback("close", function(_, cb)
    tabletOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({ action = "close" })
    cb("ok")
end)

-- SLUIT via ESC
CreateThread(function()
    while true do
        Wait(0)
        if tabletOpen and IsControlJustReleased(0, 322) then -- ESC
            tabletOpen = false
            SetNuiFocus(false, false)
            SendNUIMessage({ action = "close" })
        end
    end
end)