-- BCG_Data.lua
-- Shared data + helpers for ALL professions

BashyoCraftingGuide = BashyoCraftingGuide or {}
BashyoCraftingGuide.Data = BashyoCraftingGuide.Data or {}

local Data = {}

-- =============================
-- Common helpers (Classic/Turtle safe)
-- =============================
local function _ensureSV()
  BashyoCraftingGuide_SV = BashyoCraftingGuide_SV or {}
  BashyoCraftingGuide_SV.bankCache = BashyoCraftingGuide_SV.bankCache or {} -- [itemID] = count
end
_ensureSV()

local function _idFromLink(link)
  if not link then return nil end
  local _, _, idstr = string.find(link, "item:(%d+)")
  return tonumber(idstr)
end

local function _countInBags(itemID)
  local total = 0
  for bag = 0, 4 do
    local slots = GetContainerNumSlots and GetContainerNumSlots(bag) or 0
    for slot = 1, slots do
      local link = GetContainerItemLink and GetContainerItemLink(bag, slot)
      if link and _idFromLink(link) == itemID then
        local _, cnt = GetContainerItemInfo(bag, slot)
        total = total + (cnt or 1)
      end
    end
  end
  return total
end

local function _scanBankToCache(itemID)
  local total = 0
  if not (BankFrame and BankFrame:IsShown()) then
    return BashyoCraftingGuide_SV.bankCache[itemID] or 0 -- Bank closed -> use cache
  end
  -- Main bank (-1)
  local slots = GetContainerNumSlots and GetContainerNumSlots(-1) or 0
  for slot = 1, slots do
    local link = GetContainerItemLink and GetContainerItemLink(-1, slot)
    if link and _idFromLink(link) == itemID then
      local _, cnt = GetContainerItemInfo(-1, slot)
      total = total + (cnt or 1)
    end
  end
  -- Bank bags (5..10)
  for bag = 5, 10 do
    local slotsB = GetContainerNumSlots and GetContainerNumSlots(bag) or 0
    for slot = 1, slotsB do
      local link = GetContainerItemLink and GetContainerItemLink(bag, slot)
      if link and _idFromLink(link) == itemID then
        local _, cnt = GetContainerItemInfo(bag, slot)
        total = total + (cnt or 1)
      end
    end
  end
  BashyoCraftingGuide_SV.bankCache[itemID] = total
  return total
end

-- =============================
-- Profession container factory
-- =============================
local function makeD()
  local D = {}
  D.VENDOR_MATS = {}
  D.CREATED_MATS = {}
  D.MAT_ICON_FALLBACK = "Interface\\Icons\\INV_Misc_QuestionMark"
  D.MAT_ICONS = {}
  D.RECIPE_ITEM_IDS = {}
  D.MAT_ITEM_IDS = {}
  D.GUIDE_STEPS = {}
  D.RECIPE_STEPS = {}
  D.SORT_WEIGHT = {}

  function D.IsVendor(mat)  return D.VENDOR_MATS[mat]  and true or false end
  function D.IsCreated(mat) return D.CREATED_MATS[mat] and true or false end
  function D.ItemIdFor(name) return D.MAT_ITEM_IDS and D.MAT_ITEM_IDS[name] end

  function D.IconFor(name)
    local id = (D.RECIPE_ITEM_IDS and D.RECIPE_ITEM_IDS[name]) or
               (D.MAT_ITEM_IDS and D.MAT_ITEM_IDS[name])
    if id and GetItemIcon then
      local tex = GetItemIcon(id); if tex then return tex end
      local fake = "item:"..tostring(id)..":0:0:0"
      tex = GetItemIcon(fake); if tex then return tex end
    end
    if D.MAT_ICONS and D.MAT_ICONS[name] then return D.MAT_ICONS[name] end
    return D.MAT_ICON_FALLBACK
  end

  function D.SplitCounts(name)
    local itemID = D.ItemIdFor(name); if not itemID then return 0,0 end
    local bags = _countInBags(itemID)
    local bank = _scanBankToCache(itemID)
    return bags, bank
  end

  function D.CountInBagsAndBank(name)
    local itemID = D.ItemIdFor(name); if not itemID then return 0 end
    return (_countInBags(itemID) or 0) + (_scanBankToCache(itemID) or 0)
  end

  function D.SortKeyLess(a,b)
    local wa = (D.SORT_WEIGHT and D.SORT_WEIGHT[a]) or 9999
    local wb = (D.SORT_WEIGHT and D.SORT_WEIGHT[b]) or 9999
    if wa ~= wb then return wa < wb end
    return tostring(a) < tostring(b)
  end

  return D
end

-- =============================
-- Profession registry + accessors
-- =============================
Data._byKey = {}

function Data.Register(key, D) Data._byKey[key] = D end
function Data.Get(key) return Data._byKey[key] end

BashyoCraftingGuide.Data.Get = Data.Get
BashyoCraftingGuide.Data.Register = Data.Register
BashyoCraftingGuide.Data._makeD = makeD
BashyoCraftingGuide.Data._byKey = Data._byKey

-- ============================================
-- LEATHERWORKING data (1:1 aus deiner Version)
-- ============================================
local D_LW = makeD()

D_LW.VENDOR_MATS = {
  ["Coarse Thread"]=true, ["Fine Thread"]=true, ["Silken Thread"]=true, ["Rune Thread"]=true,
  ["Salt"]=true, ["Gray Dye"]=true, ["Black Dye"]=true,
}
D_LW.CREATED_MATS = { ["Cured Medium Hide"]=true, ["Cured Heavy Hide"]=true }

D_LW.MAT_ICONS = {
  ["Light Leather"]="Interface\\Icons\\INV_Misc_LeatherScrap_03",
  ["Medium Leather"]="Interface\\Icons\\INV_Misc_LeatherScrap_05",
  ["Heavy Leather"]="Interface\\Icons\\INV_Misc_LeatherScrap_07",
  ["Thick Leather"]="Interface\\Icons\\INV_Misc_LeatherScrap_08",
  ["Rugged Leather"]="Interface\\Icons\\INV_Misc_LeatherScrap_02",
  ["Light Hide"]="Interface\\Icons\\inv_misc_pelt_wolf_ruin_02",
  ["Medium Hide"]="Interface\\Icons\\inv_misc_pelt_boar_ruin_02",
  ["Heavy Hide"]="Interface\\Icons\\inv_misc_pelt_wolf_ruin_03",
  ["Thick Hide"]="Interface\\Icons\\INV_Misc_Pelt_Bear_02",
  ["Rugged Hide"]="Interface\\Icons\\INV_Misc_Pelt_Bear_01",
  ["Ruined Leather Scraps"]="Interface\\Icons\\inv_misc_pelt_bear_ruin_05",
  ["Coarse Thread"]="Interface\\Icons\\inv_fabric_linen_03",
  ["Fine Thread"]="Interface\\Icons\\inv_fabric_wool_02",
  ["Silken Thread"]="Interface\\Icons\\inv_fabric_silk_02",
  ["Rune Thread"]="Interface\\Icons\\spell_shadow_antimagicshell",
  ["Salt"]="Interface\\Icons\\INV_Misc_Dust_02",
  ["Gray Dye"]="Interface\\Icons\\inv_drink_10",
  ["Black Dye"]="Interface\\Icons\\inv_potion_63",
  ["Cured Medium Hide"]="Interface\\Icons\\inv_misc_pelt_bear_02",
  ["Cured Heavy Hide"]="Interface\\Icons\\inv_misc_pelt_wolf_02",
  ["Light Armor Kit"]="Interface\\Icons\\INV_Misc_ArmorKit_17",
  ["Embossed Leather Gloves"]="Interface\\Icons\\INV_Gauntlets_05",
  ["Fine Leather Belt"]="Interface\\Icons\\INV_Belt_04",
  ["Dark Leather Boots"]="Interface\\Icons\\INV_Boots_05",
  ["Dark Leather Belt"]="Interface\\Icons\\INV_Belt_03",
  ["Heavy Armor Kit"]="Interface\\Icons\\INV_Misc_ArmorKit_16",
  ["Barbaric Shoulders"]="Interface\\Icons\\INV_Shoulder_08",
  ["Guardian Gloves"]="Interface\\Icons\\INV_Gauntlets_05",
  ["Thick Armor Kit"]="Interface\\Icons\\INV_Misc_ArmorKit_07",
  ["Nightscape Headband"]="Interface\\Icons\\inv_helmet_40",
  ["Nightscape Pants"]="Interface\\Icons\\INV_Pants_11",
  ["Rugged Armor Kit"]="Interface\\Icons\\INV_Misc_ArmorKit_09",
  ["Wicked Leather Gauntlets"]="Interface\\Icons\\INV_Gauntlets_31",
  ["Wicked Leather Headband"]="Interface\\Icons\\inv_misc_bandage_13",
}

D_LW.RECIPE_ITEM_IDS = {
  ["Light Armor Kit"]=2304, ["Embossed Leather Gloves"]=4239, ["Fine Leather Belt"]=4246,
  ["Dark Leather Boots"]=2315, ["Dark Leather Belt"]=4248, ["Heavy Armor Kit"]=2313,
  ["Barbaric Shoulders"]=5964, ["Guardian Gloves"]=5966, ["Thick Armor Kit"]=8173,
  ["Nightscape Headband"]=8176, ["Nightscape Pants"]=8193, ["Rugged Armor Kit"]=15564,
  ["Wicked Leather Gauntlets"]=15083, ["Wicked Leather Headband"]=15086,
}

D_LW.MAT_ITEM_IDS = {
  ["Light Leather"]=2318, ["Medium Leather"]=2319, ["Heavy Leather"]=4234,
  ["Thick Leather"]=4304, ["Rugged Leather"]=8170,
  ["Light Hide"]=783, ["Medium Hide"]=4232, ["Heavy Hide"]=4235,
  ["Thick Hide"]=8169, ["Rugged Hide"]=8171,
  ["Ruined Leather Scraps"]=2934,
  ["Coarse Thread"]=2320, ["Fine Thread"]=2321, ["Silken Thread"]=4291, ["Rune Thread"]=14341,
  ["Salt"]=4289, ["Gray Dye"]=4340, ["Black Dye"]=2325,
  ["Cured Medium Hide"]=4233, ["Cured Heavy Hide"]=4236,
}

D_LW.SORT_WEIGHT = {
  ["Ruined Leather Scraps"]=1,
  ["Light Leather"]=2, ["Medium Leather"]=3, ["Heavy Leather"]=4, ["Thick Leather"]=5, ["Rugged Leather"]=6,
  ["Light Hide"]=10, ["Medium Hide"]=11, ["Heavy Hide"]=12, ["Thick Hide"]=13, ["Rugged Hide"]=14,
  ["Coarse Thread"]=20, ["Fine Thread"]=21, ["Silken Thread"]=22, ["Rune Thread"]=23,
  ["Salt"]=30, ["Gray Dye"]=31, ["Black Dye"]=32,
  ["Cured Medium Hide"]=40, ["Cured Heavy Hide"]=41,
}

D_LW.GUIDE_STEPS = {
  {from=1,to=30,mats={ ["Ruined Leather Scraps"]=90 }},
  {from=30,to=45,mats={ ["Light Leather"]=18 }},
  {from=45,to=55,mats={ ["Light Hide"]=10, ["Salt"]=10 }},
  {from=55,to=85,mats={ ["Light Leather"]=90, ["Coarse Thread"]=60 }},
  {from=85,to=100,mats={ ["Light Leather"]=90, ["Coarse Thread"]=30 }},
  {from=100,to=115,mats={ ["Medium Hide"]=15, ["Salt"]=15 }},
  {from=115,to=125,mats={ ["Medium Leather"]=40, ["Fine Thread"]=20, ["Gray Dye"]=10 }},
  {from=125,to=135,mats={ ["Medium Leather"]=48, ["Fine Thread"]=24, ["Gray Dye"]=12 }},
  {from=135,to=150,mats={ ["Cured Medium Hide"]=15, ["Fine Thread"]=30, ["Gray Dye"]=15 }},
  {from=150,to=155,mats={ ["Medium Leather"]=25 }},
  {from=155,to=160,mats={ ["Heavy Hide"]=5, ["Salt"]=15 }},
  {from=160,to=180,mats={ ["Heavy Leather"]=110, ["Fine Thread"]=22 }},
  {from=180,to=190,mats={ ["Heavy Leather"]=80, ["Cured Heavy Hide"]=10, ["Fine Thread"]=20 }},
  {from=190,to=200,mats={ ["Heavy Leather"]=40, ["Cured Heavy Hide"]=10, ["Silken Thread"]=10 }},
  {from=200,to=220,mats={ ["Thick Leather"]=100, ["Silken Thread"]=20 }},
  {from=220,to=230,mats={ ["Thick Leather"]={ total=55, unit=5 }, ["Silken Thread"]={ total=22, unit=2 } }},
  {from=230,to=250,mats={ ["Thick Leather"]=280, ["Silken Thread"]=80 }},
  {from=250,to=260,mats={ ["Rugged Leather"]=60 }},
  {from=260,to=290,mats={ ["Rugged Leather"]=256, ["Black Dye"]=32, ["Rune Thread"]=32 }},
  {from=290,to=300,mats={ ["Rugged Leather"]=120, ["Black Dye"]=10, ["Rune Thread"]=10 }},
}

D_LW.RECIPE_STEPS = {
  {from=1,to=30,name="Light Leather",icon="Light Leather",count=30},
  {from=30,to=45,name="Light Armor Kit",icon="Light Armor Kit",count=18,approx=true},
  {from=45,to=55,name="Cured Light Hide",icon="Light Hide",count=10},
  {from=55,to=85,name="Embossed Leather Gloves",icon="Embossed Leather Gloves",count=30},
  {from=85,to=100,name="Fine Leather Belt",icon="Fine Leather Belt",count=15},
  {from=100,to=115,name="Cured Medium Hide",icon="Medium Hide",count=15},
  {from=115,to=135,name="Dark Leather Boots",icon="Dark Leather Boots",count=22,approx=true},
  {from=135,to=150,name="Dark Leather Belt",icon="Dark Leather Belt",count=15},
  {from=150,to=155,name="Heavy Leather",icon="Heavy Leather",count=5},
  {from=155,to=160,name="Cured Heavy Hide",icon="Heavy Hide",count=5},
  {from=160,to=180,name="Heavy Armor Kit",icon="Heavy Armor Kit",count=22,approx=true},
  {from=180,to=190,name="Barbaric Shoulders",icon="Barbaric Shoulders",count=10},
  {from=190,to=200,name="Guardian Gloves",icon="Guardian Gloves",count=10},
  {from=200,to=220,name="Thick Armor Kit",icon="Thick Armor Kit",count=20},
  {from=220,to=230,name="Nightscape Headband",icon="Nightscape Headband",count=11,approx=true},
  {from=230,to=250,name="Nightscape Pants",icon="Nightscape Pants",count=20},
  {from=250,to=260,name="Rugged Armor Kit",icon="Rugged Armor Kit",count=12,approx=true},
  {from=260,to=290,name="Wicked Leather Gauntlets",icon="Wicked Leather Gauntlets",count=32,approx=true},
  {from=290,to=300,name="Wicked Leather Headband",icon="Wicked Leather Headband",count=10},
}

BashyoCraftingGuide.Data.Register("leatherworking", D_LW)

-- ============================================
-- ALCHEMY data (Classic 1–300)
-- ============================================
local D_AL = makeD()

-- Vendor-purchased reagents
D_AL.VENDOR_MATS = {
  ["Empty Vial"]  = true,
  ["Leaded Vial"] = true,
  ["Crystal Vial"]= true,
}
D_AL.CREATED_MATS = { ["Minor Healing Potion"] = true }

D_AL.MAT_ICONS = {
  -- Herbs
  ["Peacebloom"]          = "Interface\\Icons\\inv_misc_flower_02",
  ["Silverleaf"]          = "Interface\\Icons\\inv_misc_herb_10",
  ["Mageroyal"]           = "Interface\\Icons\\inv_jewelry_talisman_03",
  ["Briarthorn"]          = "Interface\\Icons\\inv_misc_root_01",
  ["Stranglekelp"]        = "Interface\\Icons\\inv_misc_herb_11",
  ["Bruiseweed"]          = "Interface\\Icons\\inv_misc_herb_01",
  ["Wild Steelbloom"]     = "Interface\\Icons\\inv_misc_flower_01",
  ["Kingsblood"]          = "Interface\\Icons\\inv_misc_herb_03",
  ["Liferoot"]            = "Interface\\Icons\\inv_misc_root_02",
  ["Goldthorn"]           = "Interface\\Icons\\inv_misc_herb_15",
  ["Khadgar's Whisker"]   = "Interface\\Icons\\inv_misc_herb_08",
  ["Arthas' Tears"]       = "Interface\\Icons\\inv_misc_herb_13",
  ["Sungrass"]            = "Interface\\Icons\\inv_misc_herb_18",
  ["Blindweed"]           = "Interface\\Icons\\inv_misc_herb_14",
  ["Golden Sansam"]       = "Interface\\Icons\\INV_Misc_Herb_SansamRoot",
  ["Mountain Silversage"] = "Interface\\Icons\\INV_Misc_Herb_MountainSilverSage",
  ["Purple Lotus"]        = "Interface\\Icons\\inv_misc_herb_17",
  ["Firebloom"]           = "Interface\\Icons\\INV_Misc_Herb_19",

  -- Other reagents
  ["Iron Bar"]            = "Interface\\Icons\\INV_Ingot_Iron",
  ["Black Vitriol"]       = "Interface\\Icons\\inv_misc_gem_sapphire_03",

  -- Vials (vendor)
  ["Empty Vial"]          = "Interface\\Icons\\INV_Drink_06",
  ["Leaded Vial"]         = "Interface\\Icons\\inv_drink_06",
  ["Crystal Vial"]        = "Interface\\Icons\\inv_drink_06",

  -- Potions / Elixirs
  ["Minor Healing Potion"]        = "Interface\\Icons\\INV_Potion_49",
  ["Lesser Healing Potion"]       = "Interface\\Icons\\inv_potion_50",
  ["Healing Potion"]              = "Interface\\Icons\\inv_potion_51",
  ["Lesser Mana Potion"]          = "Interface\\Icons\\inv_potion_71",
  ["Greater Healing Potion"]      = "Interface\\Icons\\inv_potion_52",
  ["Elixir of Agility"]           = "Interface\\Icons\\inv_potion_93",
  ["Elixir of Greater Defense"]   = "Interface\\Icons\\inv_potion_65",
  ["Superior Healing Potion"]     = "Interface\\Icons\\inv_potion_53",
  ["Philosophers' Stone"]         = "Interface\\Icons\\INV_Misc_Orb_01",
  ["Elixir of Detect Undead"]     = "Interface\\Icons\\inv_potion_53",
  ["Elixir of Greater Agility"]   = "Interface\\Icons\\INV_Potion_94",
  ["Superior Mana Potion"]        = "Interface\\Icons\\INV_Potion_74",
  ["Major Healing Potion"]        = "Interface\\Icons\\INV_Potion_54",
}


-- Potion/Elixir item IDs (used for tooltips and when they appear as reagents)
D_AL.RECIPE_ITEM_IDS = {
  ["Minor Healing Potion"]   = 118,
  ["Lesser Healing Potion"]  = 858,
  ["Healing Potion"]         = 929,
  ["Lesser Mana Potion"]     = 3385,
  ["Greater Healing Potion"] = 1710,
  ["Elixir of Agility"]      = 2457,
  ["Elixir of Greater Defense"]= 8951,
  ["Superior Healing Potion"]= 3928,
  ["Philosophers' Stone"]    = 9149,
  ["Elixir of Detect Undead"]= 9154,
  ["Elixir of Greater Agility"]= 9187,
  ["Superior Mana Potion"]   = 13443,
  ["Major Healing Potion"]   = 13446,
}

-- Material item IDs (herbs, vials, bars, etc.)
D_AL.MAT_ITEM_IDS = {
  -- Herbs
  ["Peacebloom"]           = 2447,
  ["Silverleaf"]           = 765,
  ["Mageroyal"]            = 785,
  ["Briarthorn"]           = 2450,
  ["Stranglekelp"]         = 3820,
  ["Bruiseweed"]           = 2453,
  ["Wild Steelbloom"]      = 3355,
  ["Kingsblood"]           = 3356,
  ["Liferoot"]             = 3357,
  ["Goldthorn"]            = 3821,
  ["Khadgar's Whisker"]    = 3358,
  ["Arthas' Tears"]        = 8836,
  ["Sungrass"]             = 8838,
  ["Blindweed"]            = 8839,
  ["Golden Sansam"]        = 13464,
  ["Mountain Silversage"]  = 13465,
  ["Purple Lotus"]         = 8831,
  ["Firebloom"]            = 4625,

  -- Other reagents
  ["Iron Bar"]             = 3575,
  ["Black Vitriol"]        = 9262,

  -- Vials (vendor)
  ["Empty Vial"]           = 3371,
  ["Leaded Vial"]          = 3372,
  ["Crystal Vial"]         = 8925,

  -- Potions that are used as reagents in later steps
  ["Minor Healing Potion"]   = 118,
  ["Lesser Healing Potion"]  = 858,
  ["Healing Potion"]         = 929,
  ["Lesser Mana Potion"]     = 3385,
  ["Greater Healing Potion"] = 1710,
  ["Elixir of Agility"]      = 2457,
  ["Elixir of Greater Defense"]= 8951,
  ["Superior Healing Potion"]= 3928,
  ["Philosophers' Stone"]    = 9149,
  ["Elixir of Detect Undead"]= 9154,
  ["Elixir of Greater Agility"]= 9187,
  ["Superior Mana Potion"]   = 13443,
  ["Major Healing Potion"]   = 13446,
}

-- Sorting hint (puts herbs roughly by progression; vials after herbs)
D_AL.SORT_WEIGHT = {
  ["Peacebloom"]=10, ["Silverleaf"]=11, ["Mageroyal"]=20, ["Briarthorn"]=21,
  ["Bruiseweed"]=30, ["Stranglekelp"]=31, ["Wild Steelbloom"]=32, ["Kingsblood"]=33, ["Liferoot"]=34,
  ["Goldthorn"]=40, ["Khadgar's Whisker"]=41, ["Arthas' Tears"]=42,
  ["Sungrass"]=50, ["Blindweed"]=51, ["Purple Lotus"]=52, ["Firebloom"]=53,
  ["Golden Sansam"]=60, ["Mountain Silversage"]=61,
  ["Iron Bar"]=70, ["Black Vitriol"]=71,
  ["Empty Vial"]=90, ["Leaded Vial"]=91, ["Crystal Vial"]=92,
}

-- Guide-derived material needs per range (as shown in your screenshots)
D_AL.GUIDE_STEPS = {
  {from=1,   to=60,  mats={ ["Peacebloom"]=59, ["Silverleaf"]=59, ["Empty Vial"]=59 }},
  {from=60,  to=110, mats={ ["Minor Healing Potion"]=59, ["Briarthorn"]=59 }},
  {from=110, to=140, mats={ ["Bruiseweed"]=30, ["Briarthorn"]=30, ["Leaded Vial"]=30 }},
  {from=140, to=155, mats={ ["Mageroyal"]=15, ["Stranglekelp"]=15, ["Empty Vial"]=15 }},
  {from=155, to=185, mats={ ["Liferoot"]=30, ["Kingsblood"]=30, ["Leaded Vial"]=30 }},
  {from=185, to=210, mats={ ["Stranglekelp"]=25, ["Goldthorn"]=25, ["Leaded Vial"]=25 }},
  {from=210, to=215, mats={ ["Wild Steelbloom"]=10, ["Goldthorn"]=10, ["Leaded Vial"]=10 }},
  {from=215, to=230, mats={ ["Sungrass"]=15, ["Khadgar's Whisker"]=15, ["Crystal Vial"]=15 }},
  {from=230, to=231, mats={ ["Iron Bar"]=4, ["Black Vitriol"]=1, ["Purple Lotus"]=4, ["Firebloom"]=4 }}, -- Philosopher's Stone
  {from=231, to=250, mats={ ["Arthas' Tears"]=19, ["Crystal Vial"]=19 }},
  {from=250, to=265, mats={ ["Sungrass"]=15, ["Goldthorn"]=15, ["Crystal Vial"]=15 }},
  {from=265, to=285, mats={ ["Sungrass"]=40, ["Blindweed"]=40, ["Crystal Vial"]=20 }},
  {from=285, to=300, mats={ ["Golden Sansam"]=36, ["Mountain Silversage"]=18, ["Crystal Vial"]=18 }},
}

-- Recipes to show per range (counts from your screenshots; ~ marks approximations)
D_AL.RECIPE_STEPS = {
  {from=1,   to=60,  name="Minor Healing Potion",        icon="Minor Healing Potion",        count=59},
  {from=60,  to=110, name="Lesser Healing Potion",       icon="Lesser Healing Potion",       count=59},
  {from=110, to=140, name="Healing Potion",              icon="Healing Potion",              count=30},
  {from=140, to=155, name="Lesser Mana Potion",          icon="Lesser Mana Potion",          count=15},
  {from=155, to=185, name="Greater Healing Potion",      icon="Greater Healing Potion",      count=30},
  {from=185, to=210, name="Elixir of Agility",           icon="Elixir of Agility",           count=25},
  {from=210, to=215, name="Elixir of Greater Defense",   icon="Elixir of Greater Defense",   count=10},
  {from=215, to=230, name="Superior Healing Potion",     icon="Superior Healing Potion",     count=15},
  {from=230, to=231, name="Philosophers' Stone",         icon="Philosophers' Stone",         count=1},
  {from=231, to=250, name="Elixir of Detect Undead",     icon="Elixir of Detect Undead",     count=19},
  {from=250, to=265, name="Elixir of Greater Agility",   icon="Elixir of Greater Agility",   count=15},
  {from=265, to=285, name="Superior Mana Potion",        icon="Superior Mana Potion",        count=20},
  {from=285, to=300, name="Major Healing Potion",        icon="Major Healing Potion",        count=18, approx=true},
}

BashyoCraftingGuide.Data.Register("alchemy", D_AL)


local function registerEmpty(profKey)
  local d = makeD()
  BashyoCraftingGuide.Data.Register(profKey, d)
end

registerEmpty("blacksmithing")
registerEmpty("enchanting")
registerEmpty("engineering")
registerEmpty("tailoring")