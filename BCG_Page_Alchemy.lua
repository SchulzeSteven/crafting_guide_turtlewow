local BCG = BashyoCraftingGuide
local Common = BCG.PageCommon
local Data   = BCG.Data
local makeD  = Data._makeD

local PROF = {
  key = "alchemy",
  names = {"Alchemy","Alchimie"},
  label = "Alchemy",
  prefix = "al",
  showIntermediates = true,
}

Common.RegisterProfession(PROF)


----------------------------------------------------------------------
-- ALCHEMY data (Classic 1–300)
----------------------------------------------------------------------

local D_AL = makeD()

----------------------------------------------------------------------
-- Alchemy: vendor-purchased reagents
----------------------------------------------------------------------

D_AL.VENDOR_MATS = {
  ["Empty Vial"]   = true,
  ["Leaded Vial"]  = true,
  ["Crystal Vial"] = true,
}

D_AL.CREATED_MATS = {
  ["Minor Healing Potion"] = true,
}

----------------------------------------------------------------------
-- Alchemy: icons (herbs, reagents, potions, elixirs, oils, flasks)
----------------------------------------------------------------------

D_AL.MAT_ICONS = {
  -- Herbs
  ["Peacebloom"]           = "Interface\\Icons\\INV_Misc_Flower_02",
  ["Silverleaf"]           = "Interface\\Icons\\INV_Misc_Herb_10",
  ["Mageroyal"]            = "Interface\\Icons\\INV_Jewelry_Talisman_03",
  ["Briarthorn"]           = "Interface\\Icons\\INV_Misc_Root_01",
  ["Stranglekelp"]         = "Interface\\Icons\\INV_Misc_Herb_11",
  ["Bruiseweed"]           = "Interface\\Icons\\INV_Misc_Herb_01",
  ["Wild Steelbloom"]      = "Interface\\Icons\\INV_Misc_Flower_01",
  ["Kingsblood"]           = "Interface\\Icons\\INV_Misc_Herb_03",
  ["Liferoot"]             = "Interface\\Icons\\INV_Misc_Root_02",
  ["Goldthorn"]            = "Interface\\Icons\\INV_Misc_Herb_15",
  ["Khadgar's Whisker"]    = "Interface\\Icons\\INV_Misc_Herb_08",
  ["Arthas' Tears"]        = "Interface\\Icons\\INV_Misc_Herb_13",
  ["Sungrass"]             = "Interface\\Icons\\INV_Misc_Herb_18",
  ["Blindweed"]            = "Interface\\Icons\\INV_Misc_Herb_14",
  ["Golden Sansam"]        = "Interface\\Icons\\INV_Misc_Herb_SansamRoot",
  ["Mountain Silversage"]  = "Interface\\Icons\\INV_Misc_Herb_MountainSilverSage",
  ["Purple Lotus"]         = "Interface\\Icons\\INV_Misc_Herb_17",
  ["Firebloom"]            = "Interface\\Icons\\INV_Misc_Herb_19",

  -- Other reagents
  ["Iron Bar"]             = "Interface\\Icons\\INV_Ingot_Iron",
  ["Black Vitriol"]        = "Interface\\Icons\\INV_Misc_Gem_Sapphire_03",
  ["Ghost Dye"]            = "Interface\\Icons\\inv_poison_mindnumbing",
  ["Goblin Rocket Fuel"]   = "Interface\\Icons\\inv_cask_02",

  -- Vials (vendor)
  ["Empty Vial"]           = "Interface\\Icons\\INV_Drink_06",
  ["Leaded Vial"]          = "Interface\\Icons\\INV_Drink_06",
  ["Crystal Vial"]         = "Interface\\Icons\\INV_Drink_06",

  -- Potions
  ["Minor Healing Potion"]        = "Interface\\Icons\\INV_Potion_49",
  ["Lesser Healing Potion"]       = "Interface\\Icons\\INV_Potion_50",
  ["Healing Potion"]              = "Interface\\Icons\\INV_Potion_51",
  ["Minor Rejuvenation Potion"]   = "Interface\\Icons\\INV_Potion_02",
  ["Greater Healing Potion"]      = "Interface\\Icons\\INV_Potion_52",
  ["Superior Healing Potion"]     = "Interface\\Icons\\INV_Potion_53",
  ["Major Healing Potion"]        = "Interface\\Icons\\INV_Potion_54",
  ["Minor Mana Potion"]           = "Interface\\Icons\\INV_Potion_70",
  ["Lesser Mana Potion"]          = "Interface\\Icons\\INV_Potion_71",
  ["Mana Potion"]                 = "Interface\\Icons\\INV_Potion_72",
  ["Discolored Healing Potion"]   = "Interface\\Icons\\INV_Potion_35",
  ["Lesser Invisibility Potion"]  = "Interface\\Icons\\INV_Potion_18",
  ["Greater Mana Potion"]         = "Interface\\Icons\\INV_Potion_73",
  ["Superior Mana Potion"]        = "Interface\\Icons\\INV_Potion_74",
  ["Major Mana Potion"]           = "Interface\\Icons\\INV_Potion_76",
  ["Weak Troll's Blood Potion"]   = "Interface\\Icons\\INV_Potion_77",
  ["Strong Troll's Blood Potion"] = "Interface\\Icons\\inv_potion_78",
  ["Dreamless Sleep Potion"]      = "Interface\\Icons\\INV_Potion_83",
  ["Greater Dreamless Sleep Potion"] = "Interface\\Icons\\inv_potion_83",
  ["Swim Speed Potion"]           = "Interface\\Icons\\inv_potion_13",
  ["Fire Protection Potion"]      = "Interface\\Icons\\inv_potion_16",
  ["Frost Protection Potion"]     = "Interface\\Icons\\inv_potion_13",
  ["Free Action Potion"]          = "Interface\\Icons\\INV_Potion_04",
  ["Restorative Potion"]          = "Interface\\Icons\\INV_Potion_01",
  ["Holy Protection Potion"]      = "Interface\\Icons\\INV_Potion_09",
  ["Rage Potion"]                 = "Interface\\Icons\\INV_Potion_24",
  ["Great Rage Potion"]           = "Interface\\Icons\\INV_Potion_07",
  ["Living Action Potion"]        = "Interface\\Icons\\INV_Potion_07",
  ["Shadow Protection Potion"]    = "Interface\\Icons\\INV_Potion_44",
  ["Lesser Stoneshield Potion"]   = "Interface\\Icons\\INV_Potion_67",
  ["Major Rejuvenation Potion"]   = "Interface\\Icons\\INV_Potion_47",
  ["Swiftness Potion"]            = "Interface\\Icons\\INV_Potion_95",
  ["Major Troll's Blood Potion"]  = "Interface\\Icons\\INV_Potion_80",
  ["Mageblood Potion"]            = "Interface\\Icons\\INV_Potion_45",
  ["Wildvine Potion"]             = "Interface\\Icons\\INV_Potion_39",
  ["Mighty Rage Potion"]          = "Interface\\Icons\\INV_Potion_41",
  ["Invisibility Potion"]         = "Interface\\Icons\\INV_Potion_25",
  ["Limited Invulnerability Potion"] = "Interface\\Icons\\INV_Potion_62",
  ["Magic Resistance Potion"]     = "Interface\\Icons\\INV_Potion_16",
  ["Mighty Troll's Blood Potion"] = "Interface\\Icons\\INV_Potion_79",
  ["Minor Magic Resistance Potion"]= "Interface\\Icons\\INV_Potion_08",
  ["Greater Arcane Protection Potion"] = "Interface\\Icons\\INV_Potion_83",
  ["Greater Fire Protection Potion"]   = "Interface\\Icons\\INV_Potion_24",
  ["Greater Frost Protection Potion"]  = "Interface\\Icons\\INV_Potion_20",
  ["Greater Nature Protection Potion"] = "Interface\\Icons\\INV_Potion_22",
  ["Greater Shadow Protection Potion"] = "Interface\\Icons\\INV_Potion_23",
  ["Greater Stoneshield Potion"]      = "Interface\\Icons\\INV_Potion_69",

  -- Elixirs
  ["Elixir of Lion's Strength"]         = "Interface\\Icons\\INV_Potion_56",
  ["Elixir of Minor Fortitude"]         = "Interface\\Icons\\INV_Potion_66",
  ["Elixir of Water Breathing"]         = "Interface\\Icons\\INV_Potion_03",
  ["Elixir of Minor Defense"]           = "Interface\\Icons\\inv_potion_63",
  ["Elixir of Defense"]                 = "Interface\\Icons\\inv_potion_64",
  ["Elixir of Firepower"]               = "Interface\\Icons\\INV_Potion_33",
  ["Elixir of Frost Power"]             = "Interface\\Icons\\INV_Potion_03",
  ["Elixir of Superior Defense"]        = "Interface\\Icons\\INV_Potion_66",
  ["Elixir of Agility"]                 = "Interface\\Icons\\INV_Potion_93",
  ["Elixir of Greater Defense"]         = "Interface\\Icons\\INV_Potion_65",
  ["Elixir of Wisdom"]                  = "Interface\\Icons\\inv_potion_06",
  ["Catseye Elixir"]                    = "Interface\\Icons\\inv_potion_36",
  ["Arcane Elixir"]                     = "Interface\\Icons\\INV_Potion_25",
  ["Elixir of Greater Water Breathing"] = "Interface\\Icons\\INV_Potion_05",
  ["Elixir of Detect Lesser Invisibility"] = "Interface\\Icons\\INV_Potion_01",
  ["Elixir of Brute Force"]            = "Interface\\Icons\\INV_Potion_40",
  ["Elixir of Fortitude"]              = "Interface\\Icons\\INV_Potion_43",
  ["Elixir of Dream Vision"]           = "Interface\\Icons\\INV_Potion_14",
  ["Elixir of Giant Growth"]           = "Interface\\Icons\\INV_Potion_10",
  ["Elixir of Giants"]                 = "Interface\\Icons\\INV_Potion_61",
  ["Elixir of Greater Firepower"]      = "Interface\\Icons\\INV_Potion_60",
  ["Elixir of Lesser Agility"]         = "Interface\\Icons\\INV_Potion_92",
  ["Elixir of Minor Agility"]          = "Interface\\Icons\\INV_Potion_91",
  ["Elixir of the Mongoose"]           = "Interface\\Icons\\INV_Potion_32",
  ["Elixir of Poison Resistance"]      = "Interface\\Icons\\INV_Potion_12",
  ["Elixir of Demonslaying"]           = "Interface\\Icons\\INV_Potion_27",
  ["Elixir of Greater Intellect"]      = "Interface\\Icons\\INV_Potion_10",
  ["Elixir of Detect Demon"]           = "Interface\\Icons\\INV_Potion_53",
  ["Elixir of Greater Agility"]        = "Interface\\Icons\\INV_Potion_94",
  ["Elixir of Detect Undead"]          = "Interface\\Icons\\INV_Potion_53",
  ["Elixir of Shadow Power"]           = "Interface\\Icons\\INV_Potion_46",
  ["Elixir of the Sages"]              = "Interface\\Icons\\INV_Potion_25",
  ["Elixir of Ogre's Strength"]        = "Interface\\Icons\\INV_Potion_57",

  -- Oils
  ["Blackmouth Oil"]    = "Interface\\Icons\\INV_Potion_92",
  ["Fire Oil"]          = "Interface\\Icons\\INV_Potion_03",
  ["Oil of Immolation"] = "Interface\\Icons\\INV_Potion_23",
  ["Stonescale Oil"]    = "Interface\\Icons\\INV_Potion_68",
  ["Frost Oil"]         = "Interface\\Icons\\INV_Potion_03",
  ["Shadow Oil"]        = "Interface\\Icons\\INV_Potion_23",

  -- Flasks
  ["Flask of the Titans"]           = "Interface\\Icons\\INV_Potion_62",
  ["Flask of Supreme Power"]        = "Interface\\Icons\\INV_Potion_41",
  ["Flask of Distilled Wisdom"]     = "Interface\\Icons\\INV_Potion_97",
  ["Flask of Chromatic Resistance"] = "Interface\\Icons\\INV_Potion_66",
  ["Flask of Petrification"]        = "Interface\\Icons\\INV_Potion_31",

  -- Special
  ["Philosophers' Stone"]       = "Interface\\Icons\\inv_misc_orb_01",
  ["Gift of Arthas"]            = "Interface\\Icons\\INV_Potion_19",
  ["Greater Fire Protection"]   = "Interface\\Icons\\INV_Potion_24",
  ["Greater Frost Protection"]  = "Interface\\Icons\\INV_Potion_20",
  ["Greater Nature Protection"] = "Interface\\Icons\\INV_Potion_22",
  ["Greater Arcane Elixir"]     = "Interface\\Icons\\INV_Potion_30",
  ["Gurubashi Mojo Madness"]    = "Interface\\Icons\\INV_Misc_MonsterScales_17",
}

----------------------------------------------------------------------
-- Alchemy: recipe item IDs
----------------------------------------------------------------------

D_AL.RECIPE_ITEM_IDS = {
  -- Basic potions
  ["Minor Healing Potion"]      = 118,
  ["Minor Mana Potion"]         = 2455,
  ["Weak Troll's Blood Potion"] = 3382,
  ["Lesser Healing Potion"]     = 858,
  ["Mana Potion"]               = 3827,
  ["Minor Rejuvenation Potion"] = 2456,
  ["Swim Speed Potion"]         = 6372,
  ["Healing Potion"]            = 929,
  ["Discolored Healing Potion"] = 4596,
  ["Strong Troll's Blood Potion"]= 3388,
  ["Greater Healing Potion"]    = 1710,
  ["Superior Healing Potion"]   = 3928,
  ["Lesser Invisibility Potion"]= 3823,
  ["Major Healing Potion"]      = 13446,
  ["Lesser Mana Potion"]        = 3385,
  ["Greater Mana Potion"]       = 6149,
  ["Superior Mana Potion"]      = 13443,
  ["Major Mana Potion"]         = 13444,
  ["Dreamless Sleep Potion"]    = 12190,
  ["Greater Dreamless Sleep Potion"] = 20002,
  ["Greater Dreamless Sleep"]   = 20002,
  ["Shadow Protection Potion"]  = 6048,
  ["Invisibility Potion"]       = 9172,
  ["Limited Invulnerability Potion"] = 3387,
  ["Magic Resistance Potion"]   = 9036,
  ["Mighty Troll's Blood Potion"]= 3826,
  ["Minor Magic Resistance Potion"] = 3384,

  -- Vendor / quest & specials
  ["Free Action Potion"]        = 5634,
  ["Restorative Potion"]        = 9030,
  ["Great Rage Potion"]         = 5633,
  ["Rage Potion"]               = 5631,
  ["Living Action Potion"]      = 20008,
  ["Lesser Stoneshield Potion"] = 4623,
  ["Major Rejuvenation Potion"] = 18253,
  ["Swiftness Potion"]          = 2459,
  ["Wildvine Potion"]           = 9144,
  ["Mighty Rage Potion"]        = 13442,
  ["Goblin Rocket Fuel"]        = 9061,
  ["Ghost Dye"]                 = 9210,

  -- Elixirs
  ["Elixir of Lion's Strength"]           = 2454,
  ["Elixir of Minor Fortitude"]           = 2458,
  ["Elixir of Water Breathing"]           = 5996,
  ["Elixir of Minor Defense"]             = 5997,
  ["Elixir of Defense"]                   = 3389,
  ["Elixir of Frost Power"]               = 17708,
  ["Elixir of Firepower"]                 = 6373,
  ["Elixir of Agility"]                   = 8949,
  ["Elixir of Wisdom"]                    = 3383,
  ["Elixir of Greater Defense"]           = 8951,
  ["Catseye Elixir"]                      = 10592,
  ["Elixir of Demonslaying"]              = 9224,
  ["Arcane Elixir"]                       = 9155,
  ["Elixir of Greater Water Breathing"]   = 18294,
  ["Elixir of Detect Lesser Invisibility"]= 3828,
  ["Elixir of Brute Force"]              = 13453,
  ["Elixir of Fortitude"]                = 3825,
  ["Elixir of Dream Vision"]             = 9197,
  ["Elixir of Giant Growth"]             = 6662,
  ["Elixir of Giants"]                   = 9206,
  ["Elixir of Greater Firepower"]        = 21546,
  ["Elixir of Lesser Agility"]           = 3390,
  ["Elixir of Minor Agility"]            = 2457,
  ["Elixir of the Mongoose"]             = 13452,
  ["Elixir of Poison Resistance"]        = 3386,
  ["Elixir of Greater Intellect"]        = 9179,
  ["Elixir of Greater Agility"]          = 9187,
  ["Elixir of Detect Undead"]            = 9154,
  ["Elixir of Detect Demon"]            = 9233,
  ["Elixir of Shadow Power"]             = 9264,
  ["Elixir of the Sages"]                = 13447,
  ["Elixir of Ogre's Strength"]          = 3391,
  ["Elixir of Superior Defense"]         = 13445,

  -- Buff / regeneration
  ["Major Troll's Blood Potion"]         = 20004,
  ["Mageblood Potion"]                   = 20007,

  -- Oils
  ["Blackmouth Oil"]                     = 6370,
  ["Fire Oil"]                           = 6371,
  ["Oil of Immolation"]                  = 8956,
  ["Stonescale Oil"]                     = 13423,
  ["Frost Oil"]                          = 3829,
  ["Shadow Oil"]                         = 3824,

  -- Protection potions
  ["Fire Protection Potion"]             = 6049,
  ["Frost Protection Potion"]            = 6050,
  ["Nature Protection Potion"]           = 6052,
  ["Holy Protection Potion"]             = 6051,
  ["Greater Arcane Protection Potion"]   = 13461,
  ["Greater Fire Protection Potion"]     = 13457,
  ["Greater Frost Protection Potion"]    = 13456,
  ["Greater Nature Protection Potion"]   = 13458,
  ["Greater Shadow Protection Potion"]   = 13459,
  ["Greater Stoneshield Potion"]         = 13455,

  -- Flasks
  ["Flask of the Titans"]                = 13510,
  ["Flask of Supreme Power"]             = 13512,
  ["Flask of Distilled Wisdom"]          = 13511,
  ["Flask of Chromatic Resistance"]      = 13513,
  ["Flask of Petrification"]             = 13506,

  -- Misc / rare
  ["Philosophers' Stone"]                = 9149,
  ["Gift of Arthas"]                     = 9088,
  ["Greater Arcane Elixir"]              = 13454,
  ["Greater Fire Protection"]            = 13457,
  ["Greater Frost Protection"]           = 13456,
  ["Greater Nature Protection"]          = 13458,
  ["Gurubashi Mojo Madness"]             = 19931,
}

----------------------------------------------------------------------
-- Alchemy: material item IDs (herbs, vials, bars, etc.)
----------------------------------------------------------------------

D_AL.MAT_ITEM_IDS = {
  -- Herbs
  ["Peacebloom"]          = 2447,
  ["Silverleaf"]          = 765,
  ["Mageroyal"]           = 785,
  ["Briarthorn"]          = 2450,
  ["Stranglekelp"]        = 3820,
  ["Bruiseweed"]          = 2453,
  ["Wild Steelbloom"]     = 3355,
  ["Kingsblood"]          = 3356,
  ["Liferoot"]            = 3357,
  ["Goldthorn"]           = 3821,
  ["Khadgar's Whisker"]   = 3358,
  ["Arthas' Tears"]       = 8836,
  ["Sungrass"]            = 8838,
  ["Blindweed"]           = 8839,
  ["Golden Sansam"]       = 13464,
  ["Mountain Silversage"] = 13465,
  ["Purple Lotus"]        = 8831,
  ["Firebloom"]           = 4625,

  -- Other reagents
  ["Iron Bar"]            = 3575,
  ["Black Vitriol"]       = 9262,

  -- Vials (vendor)
  ["Empty Vial"]          = 3371,
  ["Leaded Vial"]         = 3372,
  ["Crystal Vial"]        = 8925,

  -- Potions used as reagents later
  ["Minor Healing Potion"]     = 118,
  ["Lesser Healing Potion"]    = 858,
  ["Healing Potion"]           = 929,
  ["Lesser Mana Potion"]       = 3385,
  ["Greater Healing Potion"]   = 1710,
  ["Elixir of Agility"]        = 2457,
  ["Elixir of Greater Defense"]= 8951,
  ["Superior Healing Potion"]  = 3928,
  ["Elixir of Detect Undead"]  = 9154,
  ["Elixir of Greater Agility"]= 9187,
  ["Superior Mana Potion"]     = 13443,
  ["Major Healing Potion"]     = 13446,
}

----------------------------------------------------------------------
-- Alchemy: sort weights (approximate progression)
----------------------------------------------------------------------

D_AL.SORT_WEIGHT = {
  ["Peacebloom"]          = 10,
  ["Silverleaf"]          = 11,
  ["Mageroyal"]           = 20,
  ["Briarthorn"]          = 21,
  ["Bruiseweed"]          = 30,
  ["Stranglekelp"]        = 31,
  ["Wild Steelbloom"]     = 32,
  ["Kingsblood"]          = 33,
  ["Liferoot"]            = 34,
  ["Goldthorn"]           = 40,
  ["Khadgar's Whisker"]   = 41,
  ["Arthas' Tears"]       = 42,
  ["Sungrass"]            = 50,
  ["Blindweed"]           = 51,
  ["Purple Lotus"]        = 52,
  ["Firebloom"]           = 53,
  ["Golden Sansam"]       = 60,
  ["Mountain Silversage"] = 61,

  ["Iron Bar"]            = 70,
  ["Black Vitriol"]       = 71,

  ["Empty Vial"]          = 90,
  ["Leaded Vial"]         = 91,
  ["Crystal Vial"]        = 92,
}

----------------------------------------------------------------------
-- Alchemy: guide steps (material requirements per range)
----------------------------------------------------------------------

D_AL.GUIDE_STEPS = {
  { from = 1,   to = 60,  mats = { ["Peacebloom"] = 59, ["Silverleaf"] = 59, ["Empty Vial"] = 59 } },
  { from = 60,  to = 110, mats = { ["Minor Healing Potion"] = 59, ["Briarthorn"] = 59 } },
  { from = 110, to = 140, mats = { ["Bruiseweed"] = 30, ["Briarthorn"] = 30, ["Leaded Vial"] = 30 } },
  { from = 140, to = 155, mats = { ["Mageroyal"] = 15, ["Stranglekelp"] = 15, ["Empty Vial"] = 15 } },
  { from = 155, to = 185, mats = { ["Liferoot"] = 30, ["Kingsblood"] = 30, ["Leaded Vial"] = 30 } },
  { from = 185, to = 210, mats = { ["Stranglekelp"] = 25, ["Goldthorn"] = 25, ["Leaded Vial"] = 25 } },
  { from = 210, to = 215, mats = { ["Wild Steelbloom"] = 10, ["Goldthorn"] = 10, ["Leaded Vial"] = 10 } },
  { from = 215, to = 230, mats = { ["Sungrass"] = 15, ["Khadgar's Whisker"] = 15, ["Crystal Vial"] = 15 } },
  { from = 230, to = 231, mats = { ["Iron Bar"] = 4, ["Black Vitriol"] = 1, ["Purple Lotus"] = 4, ["Firebloom"] = 4 } }, -- Philosopher's Stone
  { from = 231, to = 250, mats = { ["Arthas' Tears"] = 19, ["Crystal Vial"] = 19 } },
  { from = 250, to = 265, mats = { ["Sungrass"] = 15, ["Goldthorn"] = 15, ["Crystal Vial"] = 15 } },
  { from = 265, to = 285, mats = { ["Sungrass"] = 40, ["Blindweed"] = 40, ["Crystal Vial"] = 20 } },
  { from = 285, to = 300, mats = { ["Golden Sansam"] = 36, ["Mountain Silversage"] = 18, ["Crystal Vial"] = 18 } },
}

----------------------------------------------------------------------
-- Alchemy: recipe steps (what to craft per range)
----------------------------------------------------------------------

D_AL.RECIPE_STEPS = {
  { from = 1,   to = 60,  name = "Minor Healing Potion",     icon = "Minor Healing Potion",     count = 59 },
  { from = 60,  to = 110, name = "Lesser Healing Potion",    icon = "Lesser Healing Potion",    count = 59 },
  { from = 110, to = 140, name = "Healing Potion",           icon = "Healing Potion",           count = 30 },
  { from = 140, to = 155, name = "Lesser Mana Potion",       icon = "Lesser Mana Potion",       count = 15 },
  { from = 155, to = 185, name = "Greater Healing Potion",   icon = "Greater Healing Potion",   count = 30 },
  { from = 185, to = 210, name = "Elixir of Agility",        icon = "Elixir of Agility",        count = 25 },
  { from = 210, to = 215, name = "Elixir of Greater Defense",icon = "Elixir of Greater Defense",count = 10 },
  { from = 215, to = 230, name = "Superior Healing Potion",  icon = "Superior Healing Potion",  count = 15 },
  { from = 230, to = 231, name = "Philosophers' Stone",      icon = "Philosophers' Stone",      count = 1 },
  { from = 231, to = 250, name = "Elixir of Detect Undead",  icon = "Elixir of Detect Undead",  count = 19 },
  { from = 250, to = 265, name = "Elixir of Greater Agility",icon = "Elixir of Greater Agility",count = 15 },
  { from = 265, to = 285, name = "Superior Mana Potion",     icon = "Superior Mana Potion",     count = 20 },
  { from = 285, to = 300, name = "Major Healing Potion",     icon = "Major Healing Potion",     count = 18, approx = true },
}

----------------------------------------------------------------------
-- Alchemy: recipe sources (trainer / vendor / drops / flasks)
----------------------------------------------------------------------

D_AL.RECIPE_SOURCES = {
  -- Trainable recipes
  trainable = {
    -- Potions
    { name = "Minor Healing Potion",       source = "Trainer (0)"   },
    { name = "Weak Troll's Blood Potion",  source = "Trainer (15)"  },
    { name = "Minor Mana Potion",          source = "Trainer (25)"  },
    { name = "Minor Rejuvenation Potion",  source = "Trainer (40)"  },
    { name = "Lesser Healing Potion",      source = "Trainer (55)"  },
    { name = "Swim Speed Potion",          source = "Trainer (100)" },
    { name = "Healing Potion",             source = "Trainer (110)" },
    { name = "Lesser Mana Potion",         source = "Trainer (120)" },
    { name = "Strong Troll's Blood Potion",source = "Trainer (125)" },
    { name = "Greater Healing Potion",     source = "Trainer (155)" },
    { name = "Mana Potion",                source = "Trainer (160)" },
    { name = "Lesser Invisibility Potion", source = "Trainer (165)" },
    { name = "Greater Mana Potion",        source = "Trainer (205)" },
    { name = "Superior Healing Potion",    source = "Trainer (215)" },
    { name = "Dreamless Sleep Potion",     source = "Trainer (230)" },

    -- Elixirs
    { name = "Elixir of Lion's Strength",         source = "Trainer (0)"   },
    { name = "Elixir of Minor Defense",           source = "Trainer (0)"   },
    { name = "Elixir of Minor Fortitude",         source = "Trainer (50)"  },
    { name = "Elixir of Water Breathing",         source = "Trainer (90)"  },
    { name = "Elixir of Wisdom",                  source = "Trainer (90)"  },
    { name = "Elixir of Defense",                 source = "Trainer (130)" },
    { name = "Elixir of Firepower",               source = "Trainer (140)" },
    { name = "Elixir of Agility",                 source = "Trainer (185)" },
    { name = "Elixir of Greater Defense",         source = "Trainer (195)" },
    { name = "Catseye Elixir",                    source = "Trainer (200)" },
    { name = "Elixir of Greater Water Breathing", source = "Trainer (215)" },
    { name = "Elixir of Detect Undead",           source = "Trainer (230)" },
    { name = "Arcane Elixir",                     source = "Trainer (235)" },
    { name = "Elixir of Greater Intellect",       source = "Trainer (235)" },
    { name = "Elixir of Greater Agility",         source = "Trainer (240)" },
    { name = "Elixir of Detect Demon",            source = "Trainer (250)" },

    -- Oils
    { name = "Blackmouth Oil",    source = "Trainer (80)"  },
    { name = "Fire Oil",          source = "Trainer (130)" },
    { name = "Oil of Immolation", source = "Trainer (205)" },
    { name = "Stonescale Oil",    source = "Trainer (250)" },
  },

  -- Vendor / quest recipes
  vendorquests = {
    { name = "Discolored Healing Potion",    source = "Quest reward: Wild Hearts" },
    { name = "Elixir of Demonslaying",       source = "Vendors: Nina Lightbrew (Feralas), Rartar (Orgrimmar)" },
    { name = "Elixir of Frost Power",        source = "Seasonal reward: You're a Mean One... (Feast of Winter Veil)" },
    { name = "Elixir of Firepower",          source = "Seasonal reward: You're a Mean One... (Feast of Winter Veil)" },
    { name = "Elixir of Shadow Power",       source = "Vendors: Algernon (Undercity), Maria Lumere (Stormwind)" },
    { name = "Elixir of Superior Defense",   source = "Vendors: Kor'geld (Orgrimmar), Soolie Berryfizz (Ironforge)" },
    { name = "Fire Protection Potion",       source = "Vendor: Jeeda (Stonetalon Mountains)" },
    { name = "Free Action Potion",           source = "Vendors: Kor'geld (Orgrimmar), Soolie Berryfizz (Ironforge), Uthir (Darnassus)" },
    { name = "Frost Oil",                    source = "Vendor: Bro'kin (Alterac Mountains)" },
    { name = "Frost Protection Potion",      source = "Vendors: Drovnar Strongbrew (Hillsbrad), Glyx Brewright (Feralas)" },
    { name = "Ghost Dye",                    source = "Vendors: Bronk (Feralas), Logannas (Feralas)" },
    { name = "Goblin Rocket Fuel",           source = "Created by Goblin Engineers using Blank Parchment and Engineer's Ink" },
    { name = "Great Rage Potion",            source = "Vendors: Hagrus (Orgrimmar), Uthir (Darnassus)" },
    { name = "Greater Dreamless Sleep Potion", source = "Vendor: Rin'wosho the Trader (Zandalar Tribe – Friendly)" },
    { name = "Greater Nature Protection Potion", source = "Vendor: Calandrath (Silithus)" },
    { name = "Holy Protection Potion",       source = "Vendors: Hula'mahi (Orgrimmar), Kzixx (Duskwood), Xandar Goodbeard (Loch Modan)" },
    { name = "Lesser Stoneshield Potion",    source = "Quest reward: Coolant Heads Prevail / Gyro... What?" },
    { name = "Living Action Potion",         source = "Vendor: Rin'wosho the Trader (Zandalar Tribe – Exalted)" },
    { name = "Major Healing Potion",         source = "Vendor: Evie Whirlbrew (Winterspring)" },
    { name = "Major Mana Potion",            source = "Vendor: Magnus Frostwake (Western Plaguelands)" },
    { name = "Major Troll's Blood Potion",   source = "Vendor: Rin'wosho the Trader (Zandalar Tribe – Honored)" },
    { name = "Mageblood Potion",             source = "Vendor: Rin'wosho the Trader (Zandalar Tribe – Revered)" },
    { name = "Philosophers' Stone",          source = "Vendors: Alchemist Pestlezugg (Tanaris), Bronk / Glyx Brewright / Logannas (Feralas)" },
    { name = "Rage Potion",                  source = "Vendors: Hagrus (Orgrimmar), Ranik (Hillsbrad), Xandar Goodbeard (Loch Modan)" },
    { name = "Shadow Oil",                   source = "Vendors: Bliztik (STV), Montarr (Desolace)" },
    { name = "Shadow Protection Potion",     source = "Vendors: Josephine Lister (Undercity), Theocritus (Stormwind)" },
    { name = "Superior Mana Potion",         source = "Vendors: Algernon (Undercity), Uthir (Darnassus)" },
    { name = "Restorative Potion",           source = "Quest chain: Uldaman Reagent Run / Badlands Reagent Run" },
  },

  -- World / mob / zone drops
  drops = {
    { name = "Gurubashi Mojo Madness",             source = "Zul'Gurub – Edge of Madness Tablet" },
    { name = "Elixir of Brute Force",              source = "Chance from Small Brown-wrapped Package (Dadanga is Hungry! – Repeatable)" },
    { name = "Elixir of Detect Lesser Invisibility", source = "World Drop" },
    { name = "Elixir of Fortitude",                source = "World Drop (Arathi Highlands)" },
    { name = "Elixir of Dream Vision",             source = "Drop from Nefarian, Taerar, Venom Belcher" },
    { name = "Elixir of Giant Growth",             source = "Zone Drop in The Barrens" },
    { name = "Elixir of Giants",                   source = "Drop from Ogom the Wretched; World Drop" },
    { name = "Elixir of Greater Firepower",        source = "Drop from Dark Iron Slaver, Dark Iron Taskmaster, Dark Iron Watchman" },
    { name = "Elixir of Lesser Agility",           source = "World Drop" },
    { name = "Elixir of Minor Agility",            source = "World Drop" },
    { name = "Elixir of the Mongoose",             source = "Satyrs in Jadefire Run, Felwood" },
    { name = "Elixir of Ogre's Strength",          source = "World Drop" },
    { name = "Elixir of Poison Resistance",        source = "World Drop" },
    { name = "Elixir of the Sages",                source = "Rare drop from Scarlet Crusade mobs (Eastern Plaguelands)" },
    { name = "Gift of Arthas",                     source = "Drop from Skeletal Flayer in Western Plaguelands" },
    { name = "Greater Arcane Elixir",              source = "Rare World Drop" },
    { name = "Greater Arcane Protection Potion",   source = "Drop from Cobalt Mageweaver (Winterspring)" },
    { name = "Greater Fire Protection Potion",     source = "Zone Drop in Blackrock Spire" },
    { name = "Greater Frost Protection Potion",    source = "Frostmaul Giant (Winterspring)" },
    { name = "Greater Nature Protection Potion",   source = "Drop from Rotting Behemoth, Decaying Horror" },
    { name = "Greater Shadow Protection Potion",   source = "World Drop" },
    { name = "Greater Stoneshield Potion",         source = "Mobs in Blackrock Spire, Molten Core, Blackwing Lair" },
    { name = "Invisibility Potion",                source = "World Drop" },
    { name = "Limited Invulnerability Potion",     source = "World Drop" },
    { name = "Magic Resistance Potion",            source = "World Drop" },
    { name = "Major Mana Potion",                  source = "World Drop" },
    { name = "Major Rejuvenation Potion",          source = "Boss drop in Molten Core" },
    { name = "Mighty Troll's Blood Potion",        source = "World Drop" },
    { name = "Mighty Rage Potion",                 source = "Drop from Blackrock Slayer / Soldier (Burning Steppes)" },
    { name = "Minor Magic Resistance Potion",      source = "World Drop" },
    { name = "Swiftness Potion",                   source = "World Drop" },
    { name = "Wildvine Potion",                    source = "World Drop" },
  },

  -- Special category (for Alchemy, used as "Flask recipes")
  special = {
    { name = "Flask of Chromatic Resistance", source = "Gyth – Upper Blackrock Spire" },
    { name = "Flask of Distilled Wisdom",     source = "Zone drop – Stratholme" },
    { name = "Flask of Petrification",        source = "Rare World Drop" },
    { name = "Flask of Supreme Power",        source = "Ras Frostwhisper – Scholomance" },
    { name = "Flask of the Titans",           source = "General Drakkisath – Upper Blackrock Spire" },
  },
}

BashyoCraftingGuide.Data.Register("alchemy", D_AL)