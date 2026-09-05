Config = Config or {}

--- This is called whenever an item check occurs
--- @param items table | array | string
--- @param amount number | nil
--- @return boolean
function Config.HasItem(items, amount)
    return QBCore.Functions.HasItem(items, amount)
end

Config.PowerStations = {
    [1] = { coords = vector3(2835.24, 1505.68, 24.72), hit = false },
    [2] = { coords = vector3(2811.76, 1500.6, 24.72), hit = false },
    [3] = { coords = vector3(2137.73, 1949.62, 93.78), hit = false },
    [4] = { coords = vector3(708.92, 117.49, 80.95), hit = false },
    [5] = { coords = vector3(670.23, 128.14, 80.95), hit = false },
    [6] = { coords = vector3(692.17, 160.28, 80.94), hit = false },
    [7] = { coords = vector3(2459.16, 1460.94, 36.2), hit = false },
    [8] = { coords = vector3(2280.45, 2964.83, 46.75), hit = false },
    [9] = { coords = vector3(2059.68, 3683.8, 34.58), hit = false },
    [10] = { coords = vector3(2589.5, 5057.38, 44.91), hit = false },
    [11] = { coords = vector3(1343.61, 6388.13, 33.4), hit = false },
    [12] = { coords = vector3(236.61, 6406.1, 31.83), hit = false },
    [13] = { coords = vector3(-293.1, 6023.54, 31.54), hit = false }
}

Config.SmallBanks = {
    [1] = {
        label = "Lol",
        coords = vector3(311.15, -284.49, 54.16),
        alarm = true,
        object = `v_ilev_gb_vauldr`,
        heading = { closed = 250.0, open = 160.0 },
        camId = 21,
        isOpened = false,
        lockers = {
            [1] = { coords = vector3(311.16, -287.71, 54.14), isBusy = false, isOpened = false },
            [2] = { coords = vector3(311.86, -286.21, 54.14), isBusy = false, isOpened = false },
            [3] = { coords = vector3(313.39, -289.15, 54.14), isBusy = false, isOpened = false },
            [4] = { coords = vector3(311.7, -288.45, 54.14), isBusy = false, isOpened = false },
            [5] = { coords = vector3(314.23, -288.77, 54.14), isBusy = false, isOpened = false },
            [6] = { coords = vector3(314.83, -287.33, 54.14), isBusy = false, isOpened = false },
            [7] = { coords = vector3(315.24, -284.85, 54.14), isBusy = false, isOpened = false },
            [8] = { coords = vector3(314.08, -283.38, 54.14), isBusy = false, isOpened = false }
        }
    },
    [2] = {
        label = "Legion Square",
        coords = vector3(146.92, -1046.11, 29.36),
        alarm = true,
        object = `v_ilev_gb_vauldr`,
        heading = { closed = 250.0, open = 160.0 },
        camId = 22,
        isOpened = false,
        lockers = {
            [1] = { coords = vector3(149.84, -1044.9, 29.34), isBusy = false, isOpened = false },
            [2] = { coords = vector3(151.16, -1046.64, 29.34), isBusy = false, isOpened = false },
            [3] = { coords = vector3(147.16, -1047.72, 29.34), isBusy = false, isOpened = false },
            [4] = { coords = vector3(146.54, -1049.28, 29.34), isBusy = false, isOpened = false },
            [5] = { coords = vector3(146.88, -1050.33, 29.34), isBusy = false, isOpened = false },
            [6] = { coords = vector3(150.0, -1050.67, 29.34), isBusy = false, isOpened = false },
            [7] = { coords = vector3(149.47, -1051.28, 29.34), isBusy = false, isOpened = false },
            [8] = { coords = vector3(150.58, -1049.09, 29.34), isBusy = false, isOpened = false }
        }
    },
    [3] = {
        label = "Hawick Ave",
        coords = vector3(-353.82, -55.37, 49.03),
        alarm = true,
        object = `v_ilev_gb_vauldr`,
        heading = { closed = 250.0, open = 160.0 },
        camId = 23,
        isOpened = false,
        lockers = {
            [1] = { coords = vector3(-350.99, -54.13, 49.01), isBusy = false, isOpened = false },
            [2] = { coords = vector3(-349.53, -55.77, 49.01), isBusy = false, isOpened = false },
            [3] = { coords = vector3(-353.54, -56.94, 49.01), isBusy = false, isOpened = false },
            [4] = { coords = vector3(-354.09, -58.55, 49.01), isBusy = false, isOpened = false },
            [5] = { coords = vector3(-353.81, -59.48, 49.01), isBusy = false, isOpened = false },
            [6] = { coords = vector3(-349.8, -58.3, 49.01), isBusy = false, isOpened = false },
            [7] = { coords = vector3(-351.14, -60.37, 49.01), isBusy = false, isOpened = false },
            [8] = { coords = vector3(-350.4, -59.92, 49.01), isBusy = false, isOpened = false }
        }
    },
    [4] = {
        label = "Del Perro Blvd",
        coords = vector3(-1210.77, -336.57, 37.78),
        alarm = true,
        object = `v_ilev_gb_vauldr`,
        heading = { closed = 296.863, open = 206.863 },
        camId = 24,
        isOpened = false,
        lockers = {
            [1] = { coords = vector3(-1209.68, -333.65, 37.75), isBusy = false, isOpened = false },
            [2] = { coords = vector3(-1207.46, -333.77, 37.75), isBusy = false, isOpened = false },
            [3] = { coords = vector3(-1209.45, -337.47, 37.75), isBusy = false, isOpened = false },
            [4] = { coords = vector3(-1208.65, -339.06, 37.75), isBusy = false, isOpened = false },
            [5] = { coords = vector3(-1207.75, -339.42, 37.75), isBusy = false, isOpened = false },
            [6] = { coords = vector3(-1205.28, -338.14, 37.75), isBusy = false, isOpened = false },
            [7] = { coords = vector3(-1205.08, -337.28, 37.75), isBusy = false, isOpened = false },
            [8] = { coords = vector3(-1205.92, -335.75, 37.75), isBusy = false, isOpened = false }
        }
    },
    [5] = {
        label = "Great Ocean Hwy",
        coords = vector3(-2956.55, 481.74, 15.69),
        alarm = true,
        object = `hei_prop_heist_sec_door`,
        heading = { closed = 357.542, open = 267.542 },
        camId = 25,
        isOpened = false,
        lockers = {
            [1] = { coords = vector3(-2958.54, 484.1, 15.67), isBusy = false, isOpened = false },
            [2] = { coords = vector3(-2957.3, 485.95, 15.67), isBusy = false, isOpened = false },
            [3] = { coords = vector3(-2955.09, 482.43, 15.67), isBusy = false, isOpened = false },
            [4] = { coords = vector3(-2953.26, 482.42, 15.67), isBusy = false, isOpened = false },
            [5] = { coords = vector3(-2952.63, 483.09, 15.67), isBusy = false, isOpened = false },
            [6] = { coords = vector3(-2952.45, 485.66, 15.67), isBusy = false, isOpened = false },
            [7] = { coords = vector3(-2953.13, 486.26, 15.67), isBusy = false, isOpened = false },
            [8] = { coords = vector3(-2954.98, 486.37, 15.67), isBusy = false, isOpened = false }
        }
    }
    -- [6] = {
    --     label = "East",
    --     coords = vector3(1175.96, 2712.87, 38.09),
    --     alarm = true,
    --     object = `v_ilev_gb_vauldr`,
    --     heading = { closed = -270.542, open = -370.542 },
    --     camId = 25,
    --     isOpened = false,
    --     lockers = {
    --         [1] = { coords = vector3(1173.69, 2710.76, 38.07), isBusy = false, isOpened = false },
    --         [2] = { coords = vector3(1171.78, 2711.94, 38.07), isBusy = false, isOpened = false },
    --         [3] = { coords = vector3(1175.25, 2714.51, 38.07), isBusy = false, isOpened = false },
    --         [4] = { coords = vector3(1175.26, 2715.97, 38.07), isBusy = false, isOpened = false },
    --         [5] = { coords = vector3(1174.27, 2716.83, 38.07), isBusy = false, isOpened = false },
    --         [6] = { coords = vector3(1172.32, 2716.82, 38.07), isBusy = false, isOpened = false },
    --         [7] = { coords = vector3(1171.25, 2716.08, 38.07), isBusy = false, isOpened = false },
    --         [8] = { coords = vector3(1171.23, 2714.44, 38.07), isBusy = false, isOpened = false }
    --     }
    -- }
}

Config.BigBanks = {
    ["paleto"] = {
        label = "Blaine County Savings Bank",
        coords = vector3(-105.61, 6472.03, 31.62),
        alarm = true,
        object = -1185205679,
        heading = { closed = 45.45, open = 130.45 },
        thermite = {
            [1] = { coords = vector3(-106.11, 6475.36, 31.62), isOpened = false, doorId = 5 }
        },
        camId = 26,
        isOpened = false,
        lockers = {
            [1] = { coords = vector3(-107.4, 6473.87, 31.62), isBusy = false, isOpened = false },
            [2] = { coords = vector3(-107.66, 6475.61, 31.62), isBusy = false, isOpened = false },
            [3] = { coords = vector3(-103.52, 6475.03, 31.62), isBusy = false, isOpened = false },
            [4] = { coords = vector3(-102.3, 6476.13, 31.66), isBusy = false, isOpened = false },
            [5] = { coords = vector3(-102.43, 6477.45, 31.67), isBusy = false, isOpened = false },
            [6] = { coords = vector3(-103.97, 6478.97, 31.62), isBusy = false, isOpened = false },
            [7] = { coords = vector3(-105.39, 6479.19, 31.67), isBusy = false, isOpened = false },
            [8] = { coords = vector3(-106.57, 6478.01, 31.62), isBusy = false, isOpened = false }
        }
    },
    ["pacific"] = {
        label = "Pacific Standard",
        coords = {
            [1] = vector3(261.95, 223.11, 106.28),
            [2] = vector3(253.25, 228.44, 101.68)
        },
        alarm = true,
        object = 961976194,
        heading = { closed = 160.00001, open = 70.00001 },
        thermite = {
            [1] = { coords = vector3(252.55, 221.15, 101.68), isOpened = false, doorId = 2 },
            [2] = { coords = vector3(261.15, 215.21, 101.68), isOpened = false, doorId = 3 }
        },
        camId = 26,
        isOpened = false,
        lockers = {
            [1] = { coords = vector3(258.57, 218.36, 101.68), isBusy = false, isOpened = false },
            [2] = { coords = vector3(260.82, 217.62, 101.68), isBusy = false, isOpened = false },
            [3] = { coords = vector3(259.33, 213.76, 101.68), isBusy = false, isOpened = false },
            [4] = { coords = vector3(257.09, 214.55, 101.68), isBusy = false, isOpened = false },
            [5] = { coords = vector3(263.7, 216.48, 101.68), isBusy = false, isOpened = false },
            [6] = { coords = vector3(265.81, 215.81, 101.68), isBusy = false, isOpened = false },
            [7] = { coords = vector3(266.43, 214.37, 101.68), isBusy = false, isOpened = false },
            [8] = { coords = vector3(265.71, 212.49, 101.68), isBusy = false, isOpened = false },
            [9] = { coords = vector3(264.24, 211.92, 101.68), isBusy = false, isOpened = false },
            [10] = { coords = vector3(262.21, 212.67, 101.68), isBusy = false, isOpened = false }
        }
    }
}

-- ==========================================
-- ✅ سیستم چرخ پول برای همه بانک‌ها
-- ==========================================
Config.BankTrolleys = {
    -- Small Banks (Fleeca) - 6 بانک
    -- ⚠️ مختصات زیر placeholder هستند! باید با مختصات دقیق داخل هر بانک جایگزین شوند
    ["small_1"] = { -- Lol
        trolleys = {
            [1] = { coords = vector3(314.99, -284.21, 53.14), heading = 302.82, cashChance = 100, goldChance = 0, diamondChance = 0, emptyChance = 0, cash = {min = 5000, max = 12000}, gold = {min = 1, max = 2}, diamond = {min = 1, max = 1} },
            [2] = { coords = vector3(312.96, -288.34, 53.14), heading = 338.17, cashChance = 100, goldChance = 0, diamondChance = 0, emptyChance = 0, cash = {min = 6000, max = 13000}, gold = {min = 1, max = 2}, diamond = {min = 1, max = 1} },
        }
    },
    ["small_2"] = { -- Legion Square
        trolleys = {
            [1] = { coords = vector3(148.59, -1049.91, 28.35), heading = 336.43, cashChance = 100, goldChance = 0, diamondChance = 0, emptyChance = 0, cash = {min = 5000, max = 12000}, gold = {min = 1, max = 2}, diamond = {min = 1, max = 1} },
            [2] = { coords = vector3(150.73, -1045.79, 28.35), heading = 309.54, cashChance = 100, goldChance = 0, diamondChance = 0, emptyChance = 0, cash = {min = 6000, max = 13000}, gold = {min = 1, max = 2}, diamond = {min = 1, max = 1} },
        }
    },
    ["small_3"] = { -- Hawick Ave
        trolleys = {
            [1] = { coords = vector3(-352.02, -59.11, 48.01), heading = 342.76, cashChance = 100, goldChance = 0, diamondChance = 0, emptyChance = 0, cash = {min = 5000, max = 12000}, gold = {min = 1, max = 2}, diamond = {min = 1, max = 1} },
            [2] = { coords = vector3(-350.02, -55.03, 48.01), heading = 310.96, cashChance = 100, goldChance = 0, diamondChance = 0, emptyChance = 0, cash = {min = 6000, max = 13000}, gold = {min = 1, max = 2}, diamond = {min = 1, max = 1} },
        }
    },
    ["small_4"] = { -- Del Perro Blvd
        trolleys = {
            [1] = { coords = vector3(-1206.75, -337.89, 36.76), heading = 26.15, cashChance = 100, goldChance = 0, diamondChance = 0, emptyChance = 0, cash = {min = 5000, max = 12000}, gold = {min = 1, max = 2}, diamond = {min = 1, max = 1} },
            [2] = { coords = vector3(-1208.41, -333.66, 36.76), heading = 348.82, cashChance = 100, goldChance = 0, diamondChance = 0, emptyChance = 0, cash = {min = 6000, max = 13000}, gold = {min = 1, max = 2}, diamond = {min = 1, max = 1} },
        }
    },
    ["small_5"] = { -- Great Ocean Hwy
        trolleys = {
            [1] = { coords = vector3(-2958.00, 485.34, 14.68), heading = 62.20, cashChance = 100, goldChance = 0, diamondChance = 0, emptyChance = 0, cash = {min = 5000, max = 12000}, gold = {min = 1, max = 2}, diamond = {min = 1, max = 1} },
            [2] = { coords = vector3(-2953.39, 484.54, 14.68), heading = 84.94, cashChance = 100, goldChance = 0, diamondChance = 0, emptyChance = 0, cash = {min = 6000, max = 13000}, gold = {min = 1, max = 2}, diamond = {min = 1, max = 1} },
        }
    },
    -- ["small_6"] = { -- East مپینگ شده ! rod 68
    --     trolleys = {
    --         [1] = { coords = vector3(1173.0, 2713.0, 38.07), heading = -270.542, cashChance = 100, goldChance = 0, diamondChance = 0, emptyChance = 0, cash = {min = 5000, max = 12000}, gold = {min = 1, max = 2}, diamond = {min = 1, max = 1} },
    --         [2] = { coords = vector3(1174.0, 2716.0, 38.07), heading = -370.542, cashChance = 100, goldChance = 0, diamondChance = 0, emptyChance = 0, cash = {min = 6000, max = 13000}, gold = {min = 1, max = 2}, diamond = {min = 1, max = 1} },
    --     }
    -- },
    -- Paleto Bank
    ["paleto"] = {
        trolleys = {
            [1] = { coords = vector3(-107.83, 6474.67, 30.63), heading = 263.26, cashChance = 100, goldChance = 0, diamondChance = 0, emptyChance = 0, cash = {min = 10000, max = 25000}, gold = {min = 1, max = 5}, diamond = {min = 1, max = 3} },
            [2] = { coords = vector3(-103.27, 6478.27, 30.63), heading = 141.49, cashChance = 100, goldChance = 0, diamondChance = 0, emptyChance = 0, cash = {min = 15000, max = 30000}, gold = {min = 1, max = 5}, diamond = {min = 1, max = 3} },
            [3] = { coords = vector3(-105.5, 6478.5, 30.62), heading = 225.0, cashChance = 100, goldChance = 0, diamondChance = 0, emptyChance = 0, cash = {min = 20000, max = 35000}, gold = {min = 1, max = 5}, diamond = {min = 1, max = 3} },
        }
    },
    -- Pacific Standard
    ["pacific"] = {
        trolleys = {
            [1] = { coords = vector3(260.0, 216.0, 101.68), heading = 160.0, cashChance = 100, goldChance = 0, diamondChance = 0, emptyChance = 0, cash = {min = 25000, max = 50000}, gold = {min = 2, max = 8}, diamond = {min = 1, max = 5} },
            [2] = { coords = vector3(264.0, 213.0, 101.68), heading = 70.0, cashChance = 100, goldChance = 0, diamondChance = 0, emptyChance = 0, cash = {min = 30000, max = 60000}, gold = {min = 2, max = 10}, diamond = {min = 1, max = 6} },
        }
    }
}

-- آیتم مورد نیاز برای loot
Config.TrolleyReward = {
    bagItem = 'bag'
}

-- مدل‌های چرخ بر اساس نوع پاداش
Config.TrolleyModels = {
    cash = "hei_prop_hei_cash_trolly_01",
    gold = "hei_prop_hei_cash_trolly_03",
    diamond = "hei_prop_hei_cash_trolly_03",
    empty = "hei_prop_hei_cash_trolly_03"
}

-- مدل‌های پاداش برای نمایش روی چرخ
Config.TrolleyRewardModels = {
    cash = nil,
    gold = "ch_prop_gold_bar_01a",
    diamond = "ch_prop_diamond_01a"
}


-- سیستم رمز داستانی!
Config.BigBanks["paleto"].vaultPin = {
    length = 4,
    digits = {
        [1] = { location = "office", minigame = "terminal", found = false },
        [2] = { location = "wall_safe", minigame = "thermite", found = false },
        [3] = { location = "computer", minigame = "chopping", found = false },
        [4] = { location = "drawer", minigame = "item_search", found = false },
    }
}

-- ==========================================
-- ✅ Cell Gates - Pacific Bank Extended Vault
-- ==========================================
Config.CellGates = {
    [1] = {
        coords = vector3(256.31155395508, 220.65788269043, 106.4295425415),
        rotation = vector3(0.0, 0.0, 250.0),
        closedHeading = 340.0,
        openHeading = 160.0,
    },
    [2] = {
        coords = vector3(262.399, 248.455, 101.801),
        rotation = vector3(0.0, 0.0, 250.0),
        closedHeading = 250.0,
        openHeading = 160.0,
    },
    [3] = {
        coords = vector3(264.409, 254.055, 101.801),
        rotation = vector3(0.0, 0.0, 250.0),
        closedHeading = 250.0,
        openHeading = 160.0,
    },
    [4] = {
        coords = vector3(255.205, 244.726, 101.801),
        rotation = vector3(0.0, 0.0, 70.0),
        closedHeading = 70.0,
        openHeading = 160.0,
    },
    [5] = {
        coords = vector3(257.205, 250.276, 101.801),
        rotation = vector3(0.0, 0.0, 70.0),
        closedHeading = 70.0,
        openHeading = 160.0,
    },
    [6] = {
        coords = vector3(259.225, 255.886, 101.801),
        rotation = vector3(0.0, 0.0, 70.0),
        closedHeading = 70.0,
        openHeading = 160.0,
    },
}