
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
    local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPed), 15.0, 0, 70)
    if vehicle then
	if DoesEntityExist(vehicle) then
        SetVehicleFixed(vehicle)
        SetVehicleDeformationFixed(vehicle)
        SetVehicleAutoRepairDisabled(PlayerPedId(), true)
        notify("~y~AutoMotive Garages\n~g~Your vehicle has been repaired")
    else
        notify("~r~You are not close enough to a vehicle")
    end
    end

end)


--functions

function GetVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end


function GetTargetedVehicle(pCoords, ply)
    for i = 1, 200 do
        coordB = GetOffsetFromEntityInWorldCoords(ply, 0.0, (6.281)/i, 0.0)
        targetedVehicle = GetVehicleInDirection(pCoords, coordB)
        if(targetedVehicle ~= nil and targetedVehicle ~= 0)then
            return targetedVehicle
        end
    end
    return
end

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end