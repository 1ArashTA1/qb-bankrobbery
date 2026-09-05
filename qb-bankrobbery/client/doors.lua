-- ==========================================
-- ✅ سیستم قفل در داخلی - بدون ox_doorlock
-- ==========================================
-- State های قفل درها
PaletoMainDoorLocked = true
PaletoThermiteDoorLocked = true
PacificMainDoorLocked = true
PacificThermiteDoor2Locked = true
PacificThermiteDoor3Locked = true

-- ==========================================
-- توابع کمکی
-- ==========================================
-- ✅ باز کردن آروم در (مثل Fleeca)
local function SmoothOpenDoor(object, targetHeading, speed, delay)
    if not object or object == 0 then return end
    
    CreateThread(function()
        local rotationSpeed = speed or 0.05
        local rotationDelay = delay or 30
        
        while true do
            local heading = GetEntityHeading(object)
            local diff = math.abs(heading - targetHeading)
            
            if diff < rotationSpeed then break end
            
            if heading > targetHeading then
                SetEntityHeading(object, heading - rotationSpeed)
            else
                SetEntityHeading(object, heading + rotationSpeed)
            end
            Wait(rotationDelay)
        end
        
        SetEntityHeading(object, targetHeading)
        -- ✅ در رو freeze کن تا حرکت نکنه
        FreezeEntityPosition(object, true)
    end)
end

-- ==========================================
-- Event ریست درها (بعد از Timeout)
-- ==========================================
RegisterNetEvent('qb-bankrobbery:client:ClearTimeoutDoors', function()
    -- ✅ ریست State ها
    PaletoMainDoorLocked = true
    PaletoThermiteDoorLocked = true
    PacificMainDoorLocked = true
    PacificThermiteDoor2Locked = true
    PacificThermiteDoor3Locked = true
    
    -- ✅ در اصلی Paleto
    local PaletoObject = GetClosestObjectOfType(
        Config.BigBanks["paleto"]["coords"]["x"],
        Config.BigBanks["paleto"]["coords"]["y"],
        Config.BigBanks["paleto"]["coords"]["z"],
        5.0,
        Config.BigBanks["paleto"]["object"],
        false, false, false
    )
    
    if PaletoObject ~= 0 then
        SetEntityHeading(PaletoObject, Config.BigBanks["paleto"]["heading"].closed)
        FreezeEntityPosition(PaletoObject, true)
    end
    
    -- ✅ در ترمیت Paleto
    local thermiteCoords = Config.BigBanks["paleto"]["thermite"][1]["coords"]
    local thermiteObject = GetClosestObjectOfType(
        thermiteCoords.x, thermiteCoords.y, thermiteCoords.z,
        5.0, `hei_prop_heist_sec_door`, false, false, false
    )
    
    if thermiteObject ~= 0 then
        SetEntityHeading(thermiteObject, 45.0)
        FreezeEntityPosition(thermiteObject, true)
    end
    
    Config.BigBanks["paleto"]["thermite"][1]["isOpened"] = false
    
    -- ✅ در اصلی Pacific
    local pacificObject = GetClosestObjectOfType(
        Config.BigBanks["pacific"]["coords"][2]["x"],
        Config.BigBanks["pacific"]["coords"][2]["y"],
        Config.BigBanks["pacific"]["coords"][2]["z"],
        20.0,
        Config.BigBanks["pacific"]["object"],
        false, false, false
    )
    
    if pacificObject ~= 0 then
        SetEntityHeading(pacificObject, Config.BigBanks["pacific"]["heading"].closed)
        FreezeEntityPosition(pacificObject, true)
    end
    
    -- ✅ درهای ترمیت Pacific
    for _, thermiteData in pairs(Config.BigBanks["pacific"]["thermite"]) do
        local thermiteObj = GetClosestObjectOfType(
            thermiteData.coords.x,
            thermiteData.coords.y,
            thermiteData.coords.z,
            5.0,
            `hei_prop_heist_sec_door`,
            false, false, false
        )
        
        if thermiteObj ~= 0 then
            SetEntityHeading(thermiteObj, 160.0)
            FreezeEntityPosition(thermiteObj, true)
        end
        
        thermiteData.isOpened = false
    end
    
    -- ✅ ریست locker ها
    for k in pairs(Config.BigBanks["pacific"]["lockers"]) do
        Config.BigBanks["pacific"]["lockers"][k]["isBusy"] = false
        Config.BigBanks["pacific"]["lockers"][k]["isOpened"] = false
    end
    
    for k in pairs(Config.BigBanks["paleto"]["lockers"]) do
        Config.BigBanks["paleto"]["lockers"][k]["isBusy"] = false
        Config.BigBanks["paleto"]["lockers"][k]["isOpened"] = false
    end
    
    Config.BigBanks["paleto"]["isOpened"] = false
    Config.BigBanks["pacific"]["isOpened"] = false
    
    -- ✅ Despawn چرخ‌های پول
    for bankKey in pairs(Config.BankTrolleys) do
        TriggerServerEvent('qb-bankrobbery:server:despawnBankTrolleys', bankKey)
    end
end)

-- ==========================================
-- Event باز کردن در Paleto (از paleto.lua)
-- ==========================================
RegisterNetEvent('qb-bankrobbery:client:openPaletoDoor', function()
    PaletoMainDoorLocked = false
    
    local object = GetClosestObjectOfType(
        Config.BigBanks["paleto"]["coords"]["x"],
        Config.BigBanks["paleto"]["coords"]["y"],
        Config.BigBanks["paleto"]["coords"]["z"],
        5.0,
        Config.BigBanks["paleto"]["object"],
        false, false, false
    )
    
    if object ~= 0 then
        SmoothOpenDoor(object, Config.BigBanks["paleto"]["heading"].open, 0.05, 30)
    end
end)

-- ==========================================
-- Event باز کردن در ترمیت Paleto (از powerstation.lua)
-- ==========================================
RegisterNetEvent('qb-bankrobbery:client:openPaletoThermiteDoor', function()
    PaletoThermiteDoorLocked = false
    Config.BigBanks["paleto"]["thermite"][1]["isOpened"] = true
    
    local thermiteCoords = Config.BigBanks["paleto"]["thermite"][1]["coords"]
    local thermiteObject = GetClosestObjectOfType(
        thermiteCoords.x, thermiteCoords.y, thermiteCoords.z,
        5.0, `hei_prop_heist_sec_door`, false, false, false
    )
    
    if thermiteObject ~= 0 then
        SmoothOpenDoor(thermiteObject, 135.0, 0.05, 30)
    end
end)

-- ==========================================
-- Event باز کردن در Pacific (از pacific.lua)
-- ==========================================
RegisterNetEvent('qb-bankrobbery:client:openPacificDoor', function()
    PacificMainDoorLocked = false
    
    local object = GetClosestObjectOfType(
        Config.BigBanks["pacific"]["coords"][2]["x"],
        Config.BigBanks["pacific"]["coords"][2]["y"],
        Config.BigBanks["pacific"]["coords"][2]["z"],
        20.0,
        Config.BigBanks["pacific"]["object"],
        false, false, false
    )
    
    if object ~= 0 then
        SmoothOpenDoor(object, Config.BigBanks["pacific"]["heading"].open, 0.05, 30)
    end
end)

-- ==========================================
-- Event باز کردن در ترمیت Pacific (از powerstation.lua)
-- ==========================================
RegisterNetEvent('qb-bankrobbery:client:openPacificThermiteDoor', function(doorId)
    local thermiteData = doorId == 2 and Config.BigBanks["pacific"]["thermite"][1] or Config.BigBanks["pacific"]["thermite"][2]
    
    if doorId == 2 then
        PacificThermiteDoor2Locked = false
    else
        PacificThermiteDoor3Locked = false
    end
    
    thermiteData.isOpened = true
    
    local thermiteObject = GetClosestObjectOfType(
        thermiteData.coords.x,
        thermiteData.coords.y,
        thermiteData.coords.z,
        5.0,
        `hei_prop_heist_sec_door`,
        false, false, false
    )
    
    if thermiteObject ~= 0 then
        SmoothOpenDoor(thermiteObject, 250.0, 0.05, 30)
    end
end)

-- ==========================================
-- Thread اصلی برای sync همه درها
-- ==========================================
CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local PaletoDist = #(pos - Config.BigBanks["paleto"]["coords"])
        local PacificDist = #(pos - Config.BigBanks["pacific"]["coords"][2])
        
        -- ✅ Paleto Main Door
        if PaletoDist < 15 then
            local object = GetClosestObjectOfType(
                Config.BigBanks["paleto"]["coords"]["x"],
                Config.BigBanks["paleto"]["coords"]["y"],
                Config.BigBanks["paleto"]["coords"]["z"],
                5.0,
                Config.BigBanks["paleto"]["object"],
                false, false, false
            )
            
            if object ~= 0 then
                if PaletoMainDoorLocked then
                    SetEntityHeading(object, Config.BigBanks["paleto"]["heading"].closed)
                    FreezeEntityPosition(object, true)
                else
                    -- ✅ وقتی بازه، heading رو ست کن و freeze کن
                    SetEntityHeading(object, Config.BigBanks["paleto"]["heading"].open)
                    FreezeEntityPosition(object, true)
                end
            end
            
            -- ✅ Paleto Thermite Door
            local thermiteCoords = Config.BigBanks["paleto"]["thermite"][1]["coords"]
            local thermiteObject = GetClosestObjectOfType(
                thermiteCoords.x, thermiteCoords.y, thermiteCoords.z,
                5.0, `hei_prop_heist_sec_door`, false, false, false
            )
            
            if thermiteObject ~= 0 then
                if PaletoThermiteDoorLocked then
                    SetEntityHeading(thermiteObject, 45.0)
                    FreezeEntityPosition(thermiteObject, true)
                else
                    -- ✅ وقتی بازه، heading رو ست کن و freeze کن
                    SetEntityHeading(thermiteObject, 135.0)
                    FreezeEntityPosition(thermiteObject, true)
                end
            end
        end
        
        -- ✅ Pacific Main Door
        if PacificDist < 50 then
            local object = GetClosestObjectOfType(
                Config.BigBanks["pacific"]["coords"][2]["x"],
                Config.BigBanks["pacific"]["coords"][2]["y"],
                Config.BigBanks["pacific"]["coords"][2]["z"],
                20.0,
                Config.BigBanks["pacific"]["object"],
                false, false, false
            )
            
            if object ~= 0 then
                if PacificMainDoorLocked then
                    SetEntityHeading(object, Config.BigBanks["pacific"]["heading"].closed)
                    FreezeEntityPosition(object, true)
                else
                    -- ✅ وقتی بازه، heading رو ست کن و freeze کن
                    SetEntityHeading(object, Config.BigBanks["pacific"]["heading"].open)
                    FreezeEntityPosition(object, true)
                end
            end
            
            -- ✅ Pacific Thermite Doors
            for i, thermiteData in pairs(Config.BigBanks["pacific"]["thermite"]) do
                local thermiteObj = GetClosestObjectOfType(
                    thermiteData.coords.x,
                    thermiteData.coords.y,
                    thermiteData.coords.z,
                    5.0,
                    `hei_prop_heist_sec_door`,
                    false, false, false
                )
                
                if thermiteObj ~= 0 then
                    local isLocked = (i == 1 and PacificThermiteDoor2Locked) or PacificThermiteDoor3Locked
                    
                    if isLocked then
                        SetEntityHeading(thermiteObj, 160.0)
                        FreezeEntityPosition(thermiteObj, true)
                    else
                        -- ✅ وقتی بازه، heading رو ست کن و freeze کن
                        SetEntityHeading(thermiteObj, 250.0)
                        FreezeEntityPosition(thermiteObj, true)
                    end
                end
            end
        end
        
        Wait(1000)
    end
end)