-- BCG_Data.lua
-- Shared data + helpers for ALL professions

BashyoCraftingGuide       = BashyoCraftingGuide or {}
BashyoCraftingGuide.Data  = BashyoCraftingGuide.Data or {}

local Data = {}

----------------------------------------------------------------------
-- SavedVariables helpers (Classic/Turtle safe)
----------------------------------------------------------------------

local function _ensureSV()
  BashyoCraftingGuide_SV              = BashyoCraftingGuide_SV or {}
  BashyoCraftingGuide_SV.bankCache    = BashyoCraftingGuide_SV.bankCache or {} -- [itemID] = count
end

_ensureSV()

----------------------------------------------------------------------
-- Inventory / bank item-count helpers
----------------------------------------------------------------------

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

  -- If bank is closed, fall back to cached counts
  if not (BankFrame and BankFrame:IsShown()) then
    return BashyoCraftingGuide_SV.bankCache[itemID] or 0
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

----------------------------------------------------------------------
-- Profession container factory
----------------------------------------------------------------------

local function makeD()
  local D = {}

  D.VENDOR_MATS        = {}
  D.CREATED_MATS       = {}
  D.MAT_ICON_FALLBACK  = "Interface\\Icons\\INV_Misc_QuestionMark"
  D.MAT_ICONS          = {}
  D.RECIPE_ITEM_IDS    = {}
  D.MAT_ITEM_IDS       = {}
  D.GUIDE_STEPS        = {}
  D.RECIPE_STEPS       = {}
  D.SORT_WEIGHT        = {}

  function D.IsVendor(mat)
    return D.VENDOR_MATS[mat] and true or false
  end

  function D.IsCreated(mat)
    return D.CREATED_MATS[mat] and true or false
  end

  function D.ItemIdFor(name)
    return D.MAT_ITEM_IDS and D.MAT_ITEM_IDS[name]
  end

  function D.IconFor(name)
    local id = (D.RECIPE_ITEM_IDS and D.RECIPE_ITEM_IDS[name]) or
               (D.MAT_ITEM_IDS    and D.MAT_ITEM_IDS[name])

    if id and GetItemIcon then
      local tex = GetItemIcon(id)
      if tex then return tex end

      local fake = "item:" .. tostring(id) .. ":0:0:0"
      tex = GetItemIcon(fake)
      if tex then return tex end
    end

    if D.MAT_ICONS and D.MAT_ICONS[name] then
      return D.MAT_ICONS[name]
    end

    return D.MAT_ICON_FALLBACK
  end

  function D.SplitCounts(name)
    local itemID = D.ItemIdFor(name)
    if not itemID then return 0, 0 end

    local bags = _countInBags(itemID)
    local bank = _scanBankToCache(itemID)
    return bags, bank
  end

  function D.CountInBagsAndBank(name)
    local itemID = D.ItemIdFor(name)
    if not itemID then return 0 end

    return (_countInBags(itemID) or 0) + (_scanBankToCache(itemID) or 0)
  end

  function D.SortKeyLess(a, b)
    local wa = (D.SORT_WEIGHT and D.SORT_WEIGHT[a]) or 9999
    local wb = (D.SORT_WEIGHT and D.SORT_WEIGHT[b]) or 9999

    if wa ~= wb then
      return wa < wb
    end

    return tostring(a) < tostring(b)
  end

  return D
end

----------------------------------------------------------------------
-- Profession registry + accessors
----------------------------------------------------------------------

Data._byKey = {}

function Data.Register(key, D)
  Data._byKey[key] = D
end

function Data.Get(key)
  return Data._byKey[key]
end

BashyoCraftingGuide.Data.Get      = Data.Get
BashyoCraftingGuide.Data.Register = Data.Register
BashyoCraftingGuide.Data._makeD   = makeD
BashyoCraftingGuide.Data._byKey   = Data._byKey

----------------------------------------------------------------------
-- Empty data containers for professions not yet implemented
----------------------------------------------------------------------

local function registerEmpty(profKey)
  local d = makeD()
  BashyoCraftingGuide.Data.Register(profKey, d)
end

registerEmpty("blacksmithing")
registerEmpty("enchanting")
registerEmpty("engineering")
registerEmpty("tailoring")