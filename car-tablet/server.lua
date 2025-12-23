-- Hier kan je auto’s toevoegen
Vehicles = {
    { label = "Politie Audi", model = "police" },
    { label = "BMW M5", model = "bmwm5" },
    { label = "Mercedes Vito", model = "police3" }
}

RegisterNetEvent("tablet:getVehicles")
AddEventHandler("tablet:getVehicles", function()
    TriggerClientEvent("tablet:sendVehicles", source, Vehicles)
end)