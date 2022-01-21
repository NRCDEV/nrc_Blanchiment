ESX = nil 

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

RegisterServerEvent("nrc:Blanchiment")
AddEventHandler("nrc:Blanchiment", function(amount)
    local _src = source 
    local xPlayer = ESX.GetPlayerFromId(_src)
    local taxe = Config.Taxe
    local total = amount

    if amount > 0 and xPlayer.getAccount("black_money").money >= amount then 
        xPlayer.removeAccountMoney("black_money", amount)
        xPlayer.addMoney(total)  
        print(total)
        TriggerClientEvent("nrc:Checked", _src, total)
    else 
        TriggerClientEvent("nrc:Unchecked", _src)
    end
end)