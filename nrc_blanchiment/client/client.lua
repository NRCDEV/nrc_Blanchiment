ESX = nil 

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

local isMenuOpen = false 

local blanchiment_menu = RageUI.CreateMenu(nil, "Blanchiment")
blanchiment_menu.Closed = function()
    isMenuOpen = false
end

function MenuBlanchiment()
    if not isMenuOpen then
        isMenuOpen = true 
        RageUI.Visible(blanchiment_menu, true)
        CreateThread(function()
            while isMenuOpen do 
                RageUI.IsVisible(blanchiment_menu, function()


                end)
            Wait(0)
            end
        end)
    end
end

CreateThread(function()
    while true do 
        local interval = 250 
        local playerPos = GetEntityCoords(PlayerPedId())


        for k,v in pairs(Config.PositionPoint) do 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local pos = Config.PositionPoint
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

            if dist <= 3 then
                interval = 0
                Visual.Subtitle("Appuyer sur [~r~E~s~] pour commencer un ~r~Gofast", 1)
                DrawMarker(22, pos[k].x + 1, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.5, 0.5, 0.5, 255, 0, 0, 255, false, true, p19, true)
            end

            if dist <= 2.0 then 
                interval = 0 
                if IsControlJustPressed(1, 51) then 
                    discu()
                    
                    -- Wait(2000)
                    -- Visual.Subtitle("[~r~CJ~s~] Ta combien à blanchire ?", 1)
                    -- Wait(2000)
                end
            end
        end
        Wait(interval)
    end
end)

CreateThread(function()
    local Hash = GetHashKey("s_m_y_dealer_01")
    while not HasModelLoaded(Hash) do
		RequestModel(Hash)
		Wait(20)
	end

    pos = Config.PositionPed

    local ped = CreatePed("PED_TYPE_CIVFEMALE", Hash, pos.x, pos.y, pos.z, 340.00, true, false)
    SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
end)

function discu()
    Visual.Subtitle("[~y~Vous~s~] Yo j'aurais de l'argent à faire blanchire", 3000)
    Wait(3000)
    Visual.Subtitle("[~r~CJ~s~] Ta combien à blanchire ?", 3000)
    Wait(3000)
    local count = KeyboardInput("Combien a tu à blanchire", nil, 8)
    count = tonumber(count)
    Wait(500)
    Visual.Subtitle("[~y~Vous~s~] J'ai ~r~"..count.."$~s~ tu peut me les faires ?", 3000)
    Wait(3000)
    Visual.Subtitle("[~r~CJ~s~] Passe moi l'argent je vais compter", 3000)
    TriggerServerEvent("nrc:Blanchiment", count)
end

RegisterNetEvent("nrc:Checked")
AddEventHandler("nrc:Checked", function(amount)
    Wait(7000)
    Visual.Subtitle("[~r~CJ~s~] Y'a bien le compte tiens ~g~"..amount.."$~s~ d'argent propre", 4000)
    Wait(4000)
    Visual.Subtitle("[~y~Vous~s~] Merci on ce revois plus tard", 3000)
    Wait(3000)
    Visual.Subtitle("[~r~CJ~s~] Vsy à plus frero", 3000)
end)

RegisterNetEvent("nrc:Unchecked")
AddEventHandler("nrc:Unchecked", function()
    Wait(7000)
    Visual.Subtitle("[~r~CJ~s~] Tu te fou de ma geule y'a pas le compte !!", 4000)
    Wait(4000)
    Visual.Subtitle("[~r~CJ~s~] Dégage tu reviendras quand tu auras de l'argent", 4000)
    Wait(3000)
    Visual.Subtitle("[~y~Vous~s~] Okok calme", 3000)
end)


function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    
    blockinput = true 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "Somme", ExampleText, "", "", "", MaxStringLenght) 
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end 
         
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end
