if GetResourceState(Config.ResourceName) == 'started' then
    print('\x1b[31mDVN-TYPING \x1b[37m-\x1b[32m Started successfully!')
else
    print('\x1b[31mDVN-TYPING \x1b[37m-\x1b[33m Chat resource not found!')
end

RegisterNetEvent("dvn-typing:syncChatStatus")
AddEventHandler("dvn-typing:syncChatStatus", function(playerId, bool)
    TriggerClientEvent("dvn-typing:updateChatStatus", -1, playerId, bool)
end)