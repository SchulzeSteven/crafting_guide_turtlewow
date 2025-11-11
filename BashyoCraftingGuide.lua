-- BashyoCraftingGuide.lua
BashyoCraftingGuide = BashyoCraftingGuide or {}
local BCG = BashyoCraftingGuide

local ADDON = "BashyoCraftingGuide"
local function msg(t)
  if DEFAULT_CHAT_FRAME then
    DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99"..ADDON.."|r "..t)
  end
end

BCG.pages = {}
BCG.ui    = {frame=nil, scroll=nil, currentKey=nil, buttons={}, copyright=nil }

function BCG:RegisterPage(key, label, buildFunc)
  self.pages[key] = {label=label, build=buildFunc}
end

-- ===== Prefix -> Section Label (für Tabs/Überschrift) =====
local PREFIX_LABELS = {
  al  = "Alchemy",
  bs  = "Blacksmithing",
  en  = "Enchanting",
  eng = "Engineering",
  lw  = "Leatherworking",
  ta  = "Tailoring",
}

-- ===== Tab-Bar & Section-Header (generisch, prefix-basiert) =====
local function BCG_RebuildTabs(sectionKey)
  local f = BCG.ui and BCG.ui.frame
  if not f then return end

  -- Vorherige Tab-Buttons verstecken
  for _, b in pairs(BCG.ui.buttons or {}) do
    if b.Hide then b:Hide() end
  end
  BCG.ui.buttons = {}

  -- Prefix aus key (z.B. "lw_trainer" -> "lw")
  local prefix = nil
if type(sectionKey) == "string" then
  local us = string.find(sectionKey, "_")
  if us and us > 1 then
    prefix = string.sub(sectionKey, 1, us - 1)
  end
end
local label  = prefix and PREFIX_LABELS[prefix] or nil
local isProfession = (label ~= nil)

  local tabs
  if isProfession then
    tabs = {
      { key = prefix .. "_trainer",  text = "Trainer"  },
      { key = prefix .. "_shopping", text = "Shopping" },
    }
  end

  -- Section-Label
  if not BCG.ui.sectionLabel then
    local labelFS = f:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    labelFS:SetPoint("TOPLEFT", f, "TOPLEFT", 36, -18)
    labelFS:SetTextColor(1, 0.82, 0)
    labelFS:Hide()
    BCG.ui.sectionLabel = labelFS
  end

  -- Unterstreichung
  if not BCG.ui.sectionUnderline then
    local line = f:CreateTexture(nil, "ARTWORK")
    line:SetTexture("Interface\\Buttons\\WHITE8x8")
    line:SetVertexColor(1, 0.82, 0, 1)
    line:SetHeight(1)
    line:SetPoint("TOPLEFT",  f, "TOPLEFT",  16, -34)
    line:SetPoint("TOPRIGHT", f, "TOPRIGHT", -16, -34)
    line:Hide()
    BCG.ui.sectionUnderline = line
  end

  if isProfession then
    BCG.ui.sectionLabel:SetText(label)
    BCG.ui.sectionLabel:Show()
    BCG.ui.sectionUnderline:Show()
  else
    BCG.ui.sectionLabel:Hide()
    if BCG.ui.sectionUnderline then BCG.ui.sectionUnderline:Hide() end
  end

  -- Back-to-Hub
  if not BCG.ui.backToHub then
    local b = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    b:SetWidth(80); b:SetHeight(22)
    b:SetText("Professions")
    b:SetScript("OnClick", function()
      if BCG.ui and BCG.ui.tip and BCG.ui.tip.Hide then BCG.ui.tip:Hide() end
      BCG.ShowPage("hub")
    end)
    BCG.ui.backToHub = b
  end

  if isProfession then
    BCG.ui.backToHub:Show()
    BCG.ui.backToHub:ClearAllPoints()
    BCG.ui.backToHub:SetPoint("TOPLEFT", f, "TOPLEFT", 22, -44)
  else
    if BCG.ui.backToHub then BCG.ui.backToHub:Hide() end
  end

  if not tabs then return end

  -- Tabs mittig ausrichten (Lua 5.0 kompatibel)
  local buttonWidth, spacing = 90, 10
  local count = table.getn(tabs)
  local totalWidth = buttonWidth * count + spacing * (count - 1)
  local frameWidth = f.GetWidth and f:GetWidth() or 500
  local startX = (frameWidth - totalWidth) / 2

  local prev
  for i=1, count do
    local t = tabs[i]
    local b = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    b:SetWidth(buttonWidth); b:SetHeight(22)
    if i == 1 then
      b:SetPoint("TOPLEFT", f, "TOPLEFT", startX, -44)
    else
      b:SetPoint("LEFT", prev, "RIGHT", spacing, 0)
    end
    b:SetText(t.text)
    b:SetScript("OnClick", function() BCG.ShowPage(t.key) end)
    BCG.ui.buttons[t.key] = b
    prev = b
  end
end

-- ===== Page Switch =====
local function BCG_ShowPage(key)
  local ui = BCG.ui
  if not ui.frame then return end
  local page = BCG.pages[key]
  if not page then return end

  BCG_RebuildTabs(key)

  if ui.scroll and ui.scroll:GetScrollChild() then
    ui.scroll:GetScrollChild():Hide()
  end
  local content = page.build(ui.frame)
  ui.scroll:SetScrollChild(content)
  ui.currentKey = key

  -- Scrollbar-Handling
  local s = ui.scroll
  if s then
    local name = s.GetName and s:GetName() or nil
    local sb   = (name and _G[name.."ScrollBar"]) or s.ScrollBar
    local up   = name and _G[name.."ScrollBarScrollUpButton"] or nil
    local dn   = name and _G[name.."ScrollBarScrollDownButton"] or nil

    if key == "hub" then
      if sb then sb:Hide(); if sb.SetAlpha then sb:SetAlpha(0) end end
      if up then up:Hide(); if up.SetAlpha then up:SetAlpha(0) end end
      if dn then dn:Hide(); if dn.SetAlpha then dn:SetAlpha(0) end end
      if s.ClearAllPoints then
        s:ClearAllPoints()
        s:SetPoint("TOPLEFT",     ui.frame, "TOPLEFT",     16, -72)
        s:SetPoint("BOTTOMRIGHT", ui.frame, "BOTTOMRIGHT", -20, 20)
      end
      if s.EnableMouseWheel then s:EnableMouseWheel(false) end
      if s.SetVerticalScroll then s:SetVerticalScroll(0) end
    else
      if sb then if sb.SetAlpha then sb:SetAlpha(1) end; if sb.Show then sb:Show() end end
      if up then if up.SetAlpha then up:SetAlpha(1) end; if up.Show then up:Show() end end
      if dn then if dn.SetAlpha then dn:SetAlpha(1) end; if dn.Show then dn:Show() end end
      if s.ClearAllPoints then
        s:ClearAllPoints()
        s:SetPoint("TOPLEFT",     ui.frame, "TOPLEFT",     16, -72)
        s:SetPoint("BOTTOMRIGHT", ui.frame, "BOTTOMRIGHT", -36, 20)
      end
      if s.EnableMouseWheel then s:EnableMouseWheel(true) end
    end
  end
end
BCG.ShowPage = BCG_ShowPage

-- ===== Main Frame =====
local function BCG_CreateMainFrame()
  if BCG.ui.frame then return BCG.ui.frame end

  local f = CreateFrame("Frame", "BashyoCraftingGuideMainFrame", UIParent)
  f:SetWidth(500); f:SetHeight(480)
  f:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
  f:SetMovable(true); f:EnableMouse(true)
  f:RegisterForDrag("LeftButton")
  f:SetScript("OnDragStart", function() f:StartMoving() end)
  f:SetScript("OnDragStop",  function() f:StopMovingOrSizing() end)

  if f.SetBackdrop then
    f:SetBackdrop({
      bgFile="Interface\\DialogFrame\\UI-DialogBox-Background",
      edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border",
      tile=true, tileSize=32, edgeSize=32,
      insets={left=8,right=8,top=8,bottom=8}
    })
  end

  local title = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
  title:SetPoint("TOP", f, "TOP", 0, -14)
  title:SetText("BashyoCraftingGuide")

  local close = CreateFrame("Button", nil, f, "UIPanelCloseButton")
  close:SetPoint("TOPRIGHT", f, "TOPRIGHT", -5, -5)

  if not BCG.ui.copyright then
    local cp = f:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    cp:SetFont(cp:GetFont(), 9)
    cp:SetText("|cffaaaaaa by Bashyo|r")
    cp:SetPoint("TOPRIGHT", f, "TOPRIGHT", -35, -460)
    BCG.ui.copyright = cp
  end

  local scroll = CreateFrame("ScrollFrame", "BashyoCraftingGuideScroll", f, "UIPanelScrollFrameTemplate")
  scroll:SetPoint("TOPLEFT",     f, "TOPLEFT",     16, -72)
  scroll:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -36, 20)

  BCG.ui.frame  = f
  BCG.ui.scroll = scroll
  return f
end

-- ===== Slash Command =====
function BashyoCraftingGuide_Show()
  local f = BCG_CreateMainFrame()
  f:Show()
  if not BCG.ui.currentKey then BCG_ShowPage("hub") else BCG_ShowPage(BCG.ui.currentKey) end
end

if type(SlashCmdList) ~= "table" then SlashCmdList = {} end
SLASH_BASHYOCRAFTINGGUIDE1 = "/bashyo"
SLASH_BASHYOCRAFTINGGUIDE2 = "/bcg"
SlashCmdList["BASHYOCRAFTINGGUIDE"] = function()
  BashyoCraftingGuide_Show()
end

-- ===== Addon Loaded =====
local ev = CreateFrame("Frame")
ev:RegisterEvent("PLAYER_LOGIN")
ev:SetScript("OnEvent", function()
  msg("loaded. Use |cffffff00/bcg|r to open.")
end)

-- ===== Bank Cache System (jetzt für ALLE registrierten Berufe) =====
local bankEv = CreateFrame("Frame")
bankEv:RegisterEvent("BANKFRAME_OPENED")
bankEv:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
bankEv:RegisterEvent("BANKFRAME_CLOSED")
bankEv:RegisterEvent("PLAYER_LOGIN")

bankEv:SetScript("OnEvent", function(_, evt)
  BashyoCraftingGuide_SV = BashyoCraftingGuide_SV or {}
  BashyoCraftingGuide_SV.bankCache = BashyoCraftingGuide_SV.bankCache or {}

  if evt == "BANKFRAME_OPENED" or evt == "PLAYERBANKSLOTS_CHANGED" then
    -- Versuche alle registrierten Professionen zu aktualisieren
    if BashyoCraftingGuide and BashyoCraftingGuide.Data then
      local Data = BashyoCraftingGuide.Data

      -- 1) Wenn ein Registry vorhanden ist (neue Architektur)
      if type(Data.Get) == "function" and type(Data._byKey) == "table" then
        for _, D in pairs(Data._byKey) do
          if D and D.MAT_ITEM_IDS and D.SplitCounts then
            for matName, _ in pairs(D.MAT_ITEM_IDS) do
              -- Aufruf aktualisiert intern den Bank-Cache für die ItemIDs
              local _bags, _bank = D.SplitCounts(matName)
            end
          end
        end

      -- 2) Fallback: nur Leatherworking bekannt (alte Architektur)
      elseif Data.Leatherworking and Data.Leatherworking.MAT_ITEM_IDS and Data.Leatherworking.SplitCounts then
        local D = Data.Leatherworking
        for matName, _ in pairs(D.MAT_ITEM_IDS) do
          local _bags, _bank = D.SplitCounts(matName)
        end
      end
    end
  end
end)