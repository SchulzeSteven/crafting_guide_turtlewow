-- BH_Data_Leatherworking.lua
-- Pure data + helpers, extracted from your monolith

BashyoCraftingGuide = BashyoCraftingGuide or {}
BashyoCraftingGuide.Data = BashyoCraftingGuide.Data or {}
local D = {}

-- ========= Material Metadata =========
D.VENDOR_MATS = {
  ["Coarse Thread"]=true, ["Fine Thread"]=true, ["Silken Thread"]=true, ["Rune Thread"]=true,
  ["Salt"]=true, ["Gray Dye"]=true, ["Black Dye"]=true,
}
D.CREATED_MATS = { ["Cured Medium Hide"]=true, ["Cured Heavy Hide"]=true }

function D.IsVendor(mat)  return D.VENDOR_MATS[mat]  and true or false end
function D.IsCreated(mat) return D.CREATED_MATS[mat] and true or false end

-- ========= Icons =========
D.MAT_ICON_FALLBACK = "Interface\\Icons\\INV_Misc_QuestionMark"
D.MAT_ICONS = {
  -- leather tiers
  ["Light Leather"]="Interface\\Icons\\INV_Misc_LeatherScrap_03",
  ["Medium Leather"]="Interface\\Icons\\INV_Misc_LeatherScrap_05",
  ["Heavy Leather"]="Interface\\Icons\\INV_Misc_LeatherScrap_07",
  ["Thick Leather"]="Interface\\Icons\\INV_Misc_LeatherScrap_08",
  ["Rugged Leather"]="Interface\\Icons\\INV_Misc_LeatherScrap_02",
  -- hides
  ["Light Hide"]="Interface\\Icons\\inv_misc_pelt_wolf_ruin_02",
  ["Medium Hide"]="Interface\\Icons\\inv_misc_pelt_boar_ruin_02",
  ["Heavy Hide"]="Interface\\Icons\\inv_misc_pelt_wolf_ruin_03",
  ["Thick Hide"]="Interface\\Icons\\INV_Misc_Pelt_Bear_02",
  ["Rugged Hide"]="Interface\\Icons\\INV_Misc_Pelt_Bear_01",
  -- scraps
  ["Ruined Leather Scraps"]="Interface\\Icons\\inv_misc_pelt_bear_ruin_05",
  -- threads
  ["Coarse Thread"]="Interface\\Icons\\inv_fabric_linen_03",
  ["Fine Thread"]="Interface\\Icons\\inv_fabric_wool_02",
  ["Silken Thread"]="Interface\\Icons\\inv_fabric_silk_02",
  ["Rune Thread"]="Interface\\Icons\\spell_shadow_antimagicshell",
  -- vendor reagents
  ["Salt"]="Interface\\Icons\\INV_Misc_Dust_02",
  ["Gray Dye"]="Interface\\Icons\\inv_drink_10",
  ["Black Dye"]="Interface\\Icons\\inv_potion_63",
  -- created
  ["Cured Medium Hide"]="Interface\\Icons\\inv_misc_pelt_bear_02",
  ["Cured Heavy Hide"]="Interface\\Icons\\inv_misc_pelt_wolf_02",
  -- crafted items / recipes
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

function D.IconFor(name)
  -- 1) Try to get the ID from RECIPE_ITEM_IDS or MAT_ITEM_IDS first
  local id = (D.RECIPE_ITEM_IDS and D.RECIPE_ITEM_IDS[name]) or
             (D.MAT_ITEM_IDS and D.MAT_ITEM_IDS[name])

  if id and GetItemIcon then
    -- Attempt 1: Normal ItemID
    local tex = GetItemIcon(id)
    if tex then return tex end

    -- Attempt 2: TurtleWoW displayID (e.g., 16483)
    local fakeLink = "item:" .. tostring(id) .. ":0:0:0"
    tex = GetItemIcon(fakeLink)
    if tex then return tex end
  end

  -- 2) Fallback to static icons (if available)
  if D.MAT_ICONS and D.MAT_ICONS[name] then
    return D.MAT_ICONS[name]
  end

  -- 3) Final fallback icon
  return D.MAT_ICON_FALLBACK or "Interface\\Icons\\INV_Misc_QuestionMark"
end

-- ========= Recipes (Item IDs for tooltip) =========
D.RECIPE_ITEM_IDS = {
  ["Light Armor Kit"]=2304, ["Embossed Leather Gloves"]=4239, ["Fine Leather Belt"]=4246,
  ["Dark Leather Boots"]=2315, ["Dark Leather Belt"]=4248, ["Heavy Armor Kit"]=2313,
  ["Barbaric Shoulders"]=5964, ["Guardian Gloves"]=5966, ["Thick Armor Kit"]=8173,
  ["Nightscape Headband"]=8176, ["Nightscape Pants"]=8193, ["Rugged Armor Kit"]=15564,
  ["Wicked Leather Gauntlets"]=15083, ["Wicked Leather Headband"]=15086,
}

-- ========= Material Item IDs (for GetItemCount) =========
D.MAT_ITEM_IDS = {
  -- leather
  ["Light Leather"]  = 2318,
  ["Medium Leather"] = 2319,
  ["Heavy Leather"]  = 4234,
  ["Thick Leather"]  = 4304,
  ["Rugged Leather"] = 8170,

  -- hides
  ["Light Hide"]     = 783,
  ["Medium Hide"]    = 4232,
  ["Heavy Hide"]     = 4235,
  ["Thick Hide"]     = 8169,
  ["Rugged Hide"]    = 8171,

  -- scraps
  ["Ruined Leather Scraps"] = 2934,

  -- threads (vendor)
  ["Coarse Thread"]  = 2320,
  ["Fine Thread"]    = 2321,
  ["Silken Thread"]  = 4291,
  ["Rune Thread"]    = 14341,

  -- vendor reagents
  ["Salt"]           = 4289,
  ["Gray Dye"]       = 4340,
  ["Black Dye"]      = 2325,

  -- created
  ["Cured Medium Hide"] = 4233,
  ["Cured Heavy Hide"]  = 4236,
}

function D.ItemIdFor(name)
  return D.MAT_ITEM_IDS and D.MAT_ITEM_IDS[name]
end

-- ================== Persistent Bank Cache ==================
-- Stored in SavedVariables BashyoCraftingGuide_SV
local function _ensureSV()
  BashyoCraftingGuide_SV = BashyoCraftingGuide_SV or {}
  BashyoCraftingGuide_SV.bankCache = BashyoCraftingGuide_SV.bankCache or {}  -- [itemID] = count
end
_ensureSV()

-- internal: ItemID extractor (Classic-safe)
local function _idFromLink(link)
  if not link then return nil end
  local _, _, idstr = string.find(link, "item:(%d+)")
  return tonumber(idstr)
end

-- Count ONLY in bags
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

-- Count ONLY in bank (only when open); updates the cache as well
local function _scanBankToCache(itemID)
  local total = 0
  if not (BankFrame and BankFrame:IsShown()) then
    return BashyoCraftingGuide_SV.bankCache[itemID] or 0   -- Bank closed -> use cache
  end

  -- Main bank compartment (-1)
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

-- Public helper: inventory/bank separated (bank cached)
function D.SplitCounts(name)
  local itemID = D.ItemIdFor(name)
  if not itemID then return 0, 0 end
  local bags = _countInBags(itemID)
  local bank = _scanBankToCache(itemID)  -- uses live or cache
  return bags, bank
end

-- Public helper: total (inventory + cached bank)
function D.CountInBagsAndBank(name)
  local itemID = D.ItemIdFor(name)
  if not itemID then return 0 end
  local bags = _countInBags(itemID)
  local bank = _scanBankToCache(itemID)
  return (bags or 0) + (bank or 0)
end

-- ========= Sorting =========
D.SORT_WEIGHT = {
  ["Ruined Leather Scraps"]=1,
  ["Light Leather"]=2, ["Medium Leather"]=3, ["Heavy Leather"]=4, ["Thick Leather"]=5, ["Rugged Leather"]=6,
  ["Light Hide"]=10, ["Medium Hide"]=11, ["Heavy Hide"]=12, ["Thick Hide"]=13, ["Rugged Hide"]=14,
  ["Coarse Thread"]=20, ["Fine Thread"]=21, ["Silken Thread"]=22, ["Rune Thread"]=23,
  ["Salt"]=30, ["Gray Dye"]=31, ["Black Dye"]=32,
  ["Cured Medium Hide"]=40, ["Cured Heavy Hide"]=41,
}
function D.SortKeyLess(a, b)
  local wa = (D.SORT_WEIGHT and D.SORT_WEIGHT[a]) or 9999
  local wb = (D.SORT_WEIGHT and D.SORT_WEIGHT[b]) or 9999
  if wa ~= wb then return wa < wb end
  return tostring(a) < tostring(b)
end

-- ========= Guide Steps & Recipe Progression =========
D.GUIDE_STEPS = {
  {from=1,   to=30,  mats={ ["Ruined Leather Scraps"]=90 }},
  {from=30,  to=45,  mats={ ["Light Leather"]=18 }},
  {from=45,  to=55,  mats={ ["Light Hide"]=10, ["Salt"]=10 }},
  {from=55,  to=85,  mats={ ["Light Leather"]=90, ["Coarse Thread"]=60 }},
  {from=85,  to=100, mats={ ["Light Leather"]=90, ["Coarse Thread"]=30 }},
  {from=100, to=115, mats={ ["Medium Hide"]=15, ["Salt"]=15 }},
  {from=115, to=125, mats={ ["Medium Leather"]=40, ["Fine Thread"]=20, ["Gray Dye"]=10 }},
  {from=125, to=135, mats={ ["Medium Leather"]=48, ["Fine Thread"]=24, ["Gray Dye"]=12 }},
  {from=135, to=150, mats={ ["Cured Medium Hide"]=15, ["Fine Thread"]=30, ["Gray Dye"]=15 }},
  {from=150, to=155, mats={ ["Medium Leather"]=25 }},
  {from=155, to=160, mats={ ["Heavy Hide"]=5, ["Salt"]=15 }},
  {from=160, to=180, mats={ ["Heavy Leather"]=110, ["Fine Thread"]=22 }},
  {from=180, to=190, mats={ ["Heavy Leather"]=80, ["Cured Heavy Hide"]=10, ["Fine Thread"]=20 }},
  {from=190, to=200, mats={ ["Heavy Leather"]=40, ["Cured Heavy Hide"]=10, ["Silken Thread"]=10 }},
  {from=200, to=220, mats={ ["Thick Leather"]=100, ["Silken Thread"]=20 }},
  {from=220, to=230, mats={
      ["Thick Leather"]={ total=55, unit=5 },
      ["Silken Thread"]={ total=22, unit=2 },
  }},
  {from=230, to=250, mats={ ["Thick Leather"]=280, ["Silken Thread"]=80 }},
  {from=250, to=260, mats={ ["Rugged Leather"]=60 }},
  {from=260, to=290, mats={ ["Rugged Leather"]=256, ["Black Dye"]=32, ["Rune Thread"]=32 }},
  {from=290, to=300, mats={ ["Rugged Leather"]=120, ["Black Dye"]=10, ["Rune Thread"]=10 }},
}

D.RECIPE_STEPS = {
  {from=1,   to=30,  name="Light Leather",           icon="Light Leather",           count=30},
  {from=30,  to=45,  name="Light Armor Kit",         icon="Light Armor Kit",         count=18, approx=true},
  {from=45,  to=55,  name="Cured Light Hide",        icon="Light Hide",              count=10},

  {from=55,  to=85,  name="Embossed Leather Gloves", icon="Embossed Leather Gloves", count=30},
  {from=85,  to=100, name="Fine Leather Belt",       icon="Fine Leather Belt",       count=15},
  {from=100, to=115, name="Cured Medium Hide",       icon="Medium Hide",             count=15},
  {from=115, to=135, name="Dark Leather Boots",      icon="Dark Leather Boots",      count=22, approx=true},
  {from=135, to=150, name="Dark Leather Belt",       icon="Dark Leather Belt",       count=15},

  {from=150, to=155, name="Heavy Leather",           icon="Heavy Leather",           count=5},
  {from=155, to=160, name="Cured Heavy Hide",        icon="Heavy Hide",              count=5},
  {from=160, to=180, name="Heavy Armor Kit",         icon="Heavy Armor Kit",         count=22, approx=true},
  {from=180, to=190, name="Barbaric Shoulders",      icon="Barbaric Shoulders",      count=10},
  {from=190, to=200, name="Guardian Gloves",         icon="Guardian Gloves",         count=10},
  {from=200, to=220, name="Thick Armor Kit",         icon="Thick Armor Kit",         count=20},

  {from=220, to=230, name="Nightscape Headband",     icon="Nightscape Headband",     count=11, approx=true},
  {from=230, to=250, name="Nightscape Pants",        icon="Nightscape Pants",        count=20},
  {from=250, to=260, name="Rugged Armor Kit",        icon="Rugged Armor Kit",        count=12, approx=true},
  {from=260, to=290, name="Wicked Leather Gauntlets",icon="Wicked Leather Gauntlets",count=32, approx=true},
  {from=290, to=300, name="Wicked Leather Headband", icon="Wicked Leather Headband", count=10},
}

-- Expose
BashyoCraftingGuide.Data.Leatherworking = D