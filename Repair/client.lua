
Citizen.CreateThread(function()
   while true do
    Wait(0)
         RegisterCommand("repair", function()
            TriggerEvent("vehicle:repair", source)
         end)
    end
end)

--Net Event to grab nearest vehicle depending on direction and distance you are from a vehicle and fixes it
RegisterNetEvent("vehicle:repair")
AddEventHandler("vehicle:repair", function()
    local PlayerPed = GetPlayerPed(-1)
    local localVehicle = GetVehiclePedIsIn(PlayerPed, false)
    local vehicle = GetCurrentTargetCar()
    if vehicle then
	if DoesEntityExist(vehicle) then
        SetVehicleFixed(vehicle)
        SetVehicleDeformationFixed(vehicle)
        SetVehicleAutoRepairDisabled(PlayerPedId(), true)
        notify("~y~AutoMotive Garages\n~g~Your vehicle has been repaired")
    else
        notify("~r~You must be facing a vehicle for it to repair!")
    end
    end

end)


--functions

function GetCurrentTargetCar()
    local ped = GetPlayerPed(-1)
    local coords = GetEntityCoords(ped)
   
    local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 120.0, 0.0)
    local rayHandle = CastRayPointToPoint(coords.x, coords.y, coords.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, ped, 0)
    local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)

    return vehicleHandle
end

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end
