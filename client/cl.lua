local chat = false
local playersTyping = {}

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x,y,z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x,p.y,p.z, x,y,z,1)
    local scale = (1 / distance) * Config.Scale
    local fov = (1 / GetGameplayCamFov()) * 200
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0, scale)
        SetTextFont(Config.TextFont)
        SetTextProportional(1)
        SetTextColour(Config.Colour.r, Config.Colour.g, Config.Colour.b, Config.Colour.a)
		SetTextOutline(1)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

RegisterNetEvent("dvn-typing:input", function(bool)
    chat = bool
    TriggerServerEvent("dvn-typing:syncChatStatus", GetPlayerServerId(PlayerId()), bool)
end)

RegisterNetEvent("dvn-typing:updateChatStatus")
AddEventHandler("dvn-typing:updateChatStatus", function(playerId, bool)
    playersTyping[playerId] = bool
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for playerId, isTyping in pairs(playersTyping) do
            if isTyping then
                local pedCoords = GetEntityCoords(PlayerPedId())
                local playerPed = GetPlayerPed(GetPlayerFromServerId(playerId))
                local coords = GetEntityCoords(playerPed)
                local dist = Vdist(pedCoords.x, pedCoords.y, pedCoords.z, coords.x, coords.y, coords.z)
                if dist <= Config.Distance and HasEntityClearLosToEntity(PlayerPedId(), playerPed, 17) then
                    DrawText3D(coords.x, coords.y, coords.z + Config.Height, Config.Text)
                end
            end
        end
    end
end)