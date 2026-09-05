-- ==========================================
-- ✅ سیستم چرخ پول برای همه بانک‌ها
-- ==========================================
local BankTrolleyObjects = {}
local BankTrolleyRewardObjects = {}
local IsGrabbingTrolley = false

-- تابع بررسی باز بودن بانک
function IsBankOpen(bankKey)
    local bankType, bankId = bankKey:match("^(.-)_(.+)$")
    if bankType == "small" then
        bankId = tonumber(bankId)
        return Config.SmallBanks[bankId] and Config.SmallBanks[bankId]["isOpened"]
    else
        return Config.BigBanks[bankKey] and Config.BigBanks[bankKey]["isOpened"]
    end
end

-- تابع Spawn چرخ‌های پول
local function SpawnBankTrolleys(bankKey, rewardTypes)
    if not Config.BankTrolleys[bankKey] then return end
    
    local bankTrolleys = Config.BankTrolleys[bankKey].trolleys
    
    if not BankTrolleyObjects[bankKey] then
        BankTrolleyObjects[bankKey] = {}
    end
    if not BankTrolleyRewardObjects[bankKey] then
        BankTrolleyRewardObjects[bankKey] = {}
    end
    
    if #BankTrolleyObjects[bankKey] > 0 then return end
    
    -- Load مدل‌های چرخ
    RequestModel("hei_prop_hei_cash_trolly_01")
    RequestModel("hei_prop_hei_cash_trolly_03")
    while not HasModelLoaded("hei_prop_hei_cash_trolly_01") or not HasModelLoaded("hei_prop_hei_cash_trolly_03") do
        Wait(100)
    end
    
    for i, trolley in pairs(bankTrolleys) do
        -- ✅ فقط چرخ‌هایی که empty نیستن رو spawn کن
        if rewardTypes[i] ~= 'empty' then
            local rewardType = rewardTypes[i]
            local trolleyModel = Config.TrolleyModels[rewardType]
            
            local obj = CreateObject(
                GetHashKey(trolleyModel),
                trolley.coords.x, trolley.coords.y, trolley.coords.z,
                true, true, true
            )
            SetEntityHeading(obj, trolley.heading)
            FreezeEntityPosition(obj, true)
            SetEntityAsMissionEntity(obj, true, true)
            BankTrolleyObjects[bankKey][i] = obj
            
            -- ✅ اضافه کردن آبجکت پاداش روی چرخ (اگر پول نیست)
            if rewardType ~= 'cash' then
                local rewardModel = Config.TrolleyRewardModels[rewardType]
                RequestModel(rewardModel)
                while not HasModelLoaded(rewardModel) do
                    Wait(100)
                end
                
                local rewardCount = math.random(3, 6)
                local rewardObjects = {}
                
                for j = 1, rewardCount do
                    local offsetX = (math.random() - 0.5) * 0.8
                    local offsetY = (math.random() - 0.5) * 0.8
                    local offsetZ = 0.5 + (math.random() * 0.3)
                    
                    local rewardObj = CreateObject(
                        GetHashKey(rewardModel),
                        trolley.coords.x + offsetX,
                        trolley.coords.y + offsetY,
                        trolley.coords.z + offsetZ,
                        true, true, true
                    )
                    SetEntityRotation(rewardObj, math.random(0, 360), math.random(0, 360), math.random(0, 360))
                    FreezeEntityPosition(rewardObj, true)
                    SetEntityAsMissionEntity(rewardObj, true, true)
                    rewardObjects[#rewardObjects + 1] = rewardObj
                end
                
                BankTrolleyRewardObjects[bankKey][i] = rewardObjects
                SetModelAsNoLongerNeeded(rewardModel)
            end
            
            -- اضافه کردن qrt-target
            exports['qrt-target']:AddTargetEntity(obj, {
                options = {
                    {
                        icon = 'fas fa-money-bill-wave',
                        label = 'Grab Loot',
                        action = function()
                            GrabTrolleyCash(bankKey, i)
                        end,
                        canInteract = function()
                            return not IsGrabbingTrolley 
                                and IsBankOpen(bankKey)
                        end,
                        items = Config.TrolleyReward.bagItem
                    }
                },
                distance = 2.0
            })
        end
    end
end

-- تابع Despawn چرخ‌های پول
local function DespawnBankTrolleys(bankKey)
    if not BankTrolleyObjects[bankKey] then return end
    
    for i, obj in pairs(BankTrolleyObjects[bankKey]) do
        if DoesEntityExist(obj) then
            exports['qrt-target']:RemoveTargetEntity(obj)
            DeleteEntity(obj)
        end
    end
    
    if BankTrolleyRewardObjects[bankKey] then
        for i, rewardObjects in pairs(BankTrolleyRewardObjects[bankKey]) do
            for _, rewardObj in pairs(rewardObjects) do
                if DoesEntityExist(rewardObj) then
                    DeleteEntity(rewardObj)
                end
            end
        end
    end
    
    BankTrolleyObjects[bankKey] = {}
    BankTrolleyRewardObjects[bankKey] = {}
end

-- تابع جمع‌آوری loot از چرخ
function GrabTrolleyCash(bankKey, trolleyId)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    
    -- چک وجود آیتم bag
    if not QBCore.Functions.HasItem(Config.TrolleyReward.bagItem) then
        QBCore.Functions.Notify('You need a bag to collect the loot!', 'error')
        return
    end
    
    -- چک فاصله
    local trolleyCoords = Config.BankTrolleys[bankKey].trolleys[trolleyId].coords
    if #(pos - trolleyCoords) > 2.5 then
        QBCore.Functions.Notify('Too far from the trolley!', 'error')
        return
    end
    
    -- از سرور نوع پاداش را بپرس
    QBCore.Functions.TriggerCallback('qb-bankrobbery:server:getTrolleyRewardType', function(rewardType)
        if not rewardType then
            QBCore.Functions.Notify('Cannot loot this trolley!', 'error')
            return
        end
        
        IsGrabbingTrolley = true
        
        -- Load انیمیشن‌ها و مدل‌ها
        local bagHash = GetHashKey("hei_p_m_bag_var22_arm_s")
        local emptyTrolleyHash = GetHashKey("hei_prop_hei_cash_trolly_03")
        
        RequestAnimDict("anim@heists@ornate_bank@grab_cash")
        RequestModel(bagHash)
        RequestModel(emptyTrolleyHash)
        
        while not HasAnimDictLoaded("anim@heists@ornate_bank@grab_cash") 
            or not HasModelLoaded(bagHash)
            or not HasModelLoaded(emptyTrolleyHash) do
            Wait(100)
        end
        
        local trolleyObj = BankTrolleyObjects[bankKey][trolleyId]
        
        -- کنترل شبکه
        while not NetworkHasControlOfEntity(trolleyObj) do
            Wait(1)
            NetworkRequestControlOfEntity(trolleyObj)
        end
        
        -- ایجاد کیسه
        local bag = CreateObject(bagHash, pos, true, false, false)
        
        -- صحنه : Intro
        local scene1 = NetworkCreateSynchronisedScene(
            GetEntityCoords(trolleyObj), GetEntityRotation(trolleyObj),
            2, false, false, 1065353216, 0, 1.3
        )
        NetworkAddPedToSynchronisedScene(
            ped, scene1, "anim@heists@ornate_bank@grab_cash", "intro",
            1.5, -4.0, 1, 16, 1148846080, 0
        )
        NetworkAddEntityToSynchronisedScene(
            bag, scene1, "anim@heists@ornate_bank@grab_cash", "bag_intro",
            4.0, -8.0, 1
        )
        SetPedComponentVariation(ped, 5, 0, 0, 0)
        NetworkStartSynchronisedScene(scene1)
        Wait(1500)
        
        -- نمایش پاداش در دست بازیکن
        local rewardModel = Config.TrolleyRewardModels[rewardType]
        local rewardHash
        if rewardModel then
            rewardHash = GetHashKey(rewardModel)
            RequestModel(rewardHash)
            while not HasModelLoaded(rewardHash) do
                Wait(100)
            end
        end
        
        local rewardObj
        if rewardHash then
            rewardObj = CreateObject(rewardHash, pos, true)
            FreezeEntityPosition(rewardObj, true)
            SetEntityInvincible(rewardObj, true)
            SetEntityNoCollisionEntity(rewardObj, ped)
            AttachEntityToEntity(rewardObj, ped, GetPedBoneIndex(ped, 60309),
                0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
        end
        
        -- صحنه ۲: Grab
        local scene2 = NetworkCreateSynchronisedScene(
            GetEntityCoords(trolleyObj), GetEntityRotation(trolleyObj),
            2, false, false, 1065353216, 0, 1.3
        )
        NetworkAddPedToSynchronisedScene(
            ped, scene2, "anim@heists@ornate_bank@grab_cash", "grab",
            1.5, -4.0, 1, 16, 1148846080, 0
        )
        NetworkAddEntityToSynchronisedScene(
            bag, scene2, "anim@heists@ornate_bank@grab_cash", "bag_grab",
            4.0, -8.0, 1
        )
        NetworkAddEntityToSynchronisedScene(
            trolleyObj, scene2, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear",
            4.0, -8.0, 1
        )
        NetworkStartSynchronisedScene(scene2)
        Wait(37000)
        
        -- صحنه ۳: Exit
        local scene3 = NetworkCreateSynchronisedScene(
            GetEntityCoords(trolleyObj), GetEntityRotation(trolleyObj),
            2, false, false, 1065353216, 0, 1.3
        )
        NetworkAddPedToSynchronisedScene(
            ped, scene3, "anim@heists@ornate_bank@grab_cash", "exit",
            1.5, -4.0, 1, 16, 1148846080, 0
        )
        NetworkAddEntityToSynchronisedScene(
            bag, scene3, "anim@heists@ornate_bank@grab_cash", "bag_exit",
            4.0, -8.0, 1
        )
        NetworkStartSynchronisedScene(scene3)
        
        -- تبدیل چرخ پر به چرخ خالی
        local newTrolley = CreateObject(
            emptyTrolleyHash,
            GetEntityCoords(trolleyObj) + vector3(0.0, 0.0, -0.985),
            true
        )
        SetEntityRotation(newTrolley, GetEntityRotation(trolleyObj))
        DeleteEntity(trolleyObj)
        PlaceObjectOnGroundProperly(newTrolley)
        BankTrolleyObjects[bankKey][trolleyId] = newTrolley
        
        -- حذف آبجکت‌های پاداش از روی چرخ
        if BankTrolleyRewardObjects[bankKey][trolleyId] then
            for _, rewardObj in pairs(BankTrolleyRewardObjects[bankKey][trolleyId]) do
                if DoesEntityExist(rewardObj) then
                    DeleteEntity(rewardObj)
                end
            end
            BankTrolleyRewardObjects[bankKey][trolleyId] = nil
        end
        
        Wait(1800)
        
        -- پاکسازی
        if rewardObj then
            DeleteObject(rewardObj)
        end
        DeleteObject(bag)
        SetPedComponentVariation(ped, 5, 45, 0, 0)
        RemoveAnimDict("anim@heists@ornate_bank@grab_cash")
        SetModelAsNoLongerNeeded(emptyTrolleyHash)
        SetModelAsNoLongerNeeded(bagHash)
        if rewardHash then
            SetModelAsNoLongerNeeded(rewardHash)
        end
        
        -- ارسال به سرور برای دریافت پاداش
        TriggerServerEvent('qb-bankrobbery:server:lootBankTrolley', bankKey, trolleyId, rewardType)
        
        -- حذف target از این چرخ
        exports['qrt-target']:RemoveTargetEntity(newTrolley)
        IsGrabbingTrolley = false
    end, bankKey, trolleyId)
end

-- ==========================================
-- رویدادهای Spawn/Despawn از سرور
-- ==========================================
RegisterNetEvent('qb-bankrobbery:client:spawnBankTrolleys', function(bankKey, rewardTypes)
    SpawnBankTrolleys(bankKey, rewardTypes)
end)

RegisterNetEvent('qb-bankrobbery:client:despawnBankTrolleys', function(bankKey)
    DespawnBankTrolleys(bankKey)
end)

-- Sync کردن loot شدن چرخ برای همه
RegisterNetEvent('qb-bankrobbery:client:trolleyLooted', function(bankKey, trolleyId)
    local trolleyObj = BankTrolleyObjects[bankKey] and BankTrolleyObjects[bankKey][trolleyId]
    if trolleyObj and DoesEntityExist(trolleyObj) then
        local emptyTrolleyHash = GetHashKey("hei_prop_hei_cash_trolly_03")
        RequestModel(emptyTrolleyHash)
        while not HasModelLoaded(emptyTrolleyHash) do
            Wait(100)
        end
        
        local newTrolley = CreateObject(
            emptyTrolleyHash,
            GetEntityCoords(trolleyObj) + vector3(0.0, 0.0, -0.985),
            true
        )
        SetEntityRotation(newTrolley, GetEntityRotation(trolleyObj))
        DeleteEntity(trolleyObj)
        PlaceObjectOnGroundProperly(newTrolley)
        BankTrolleyObjects[bankKey][trolleyId] = newTrolley
        
        -- حذف آبجکت‌های پاداش
        if BankTrolleyRewardObjects[bankKey] and BankTrolleyRewardObjects[bankKey][trolleyId] then
            for _, rewardObj in pairs(BankTrolleyRewardObjects[bankKey][trolleyId]) do
                if DoesEntityExist(rewardObj) then
                    DeleteEntity(rewardObj)
                end
            end
            BankTrolleyRewardObjects[bankKey][trolleyId] = nil
        end
        
        exports['qrt-target']:RemoveTargetEntity(newTrolley)
        
        SetModelAsNoLongerNeeded(emptyTrolleyHash)
    end
end)

-- Cleanup هنگام ریستارت اسکریپت
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for bankKey in pairs(BankTrolleyObjects) do
            DespawnBankTrolleys(bankKey)
        end
    end
end)