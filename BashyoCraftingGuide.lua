## Title: BashyoCraftingGuide

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
BCG.ui    = {frame=nil, scroll=nil, currentKey=nil, buttons={} }

function BCG:RegisterPage(key, label, buildFunc)
  self.pages[key] = {label=label, build=buildFunc}
end

local function BCG_ShowPage(key)
  local ui = BCG.ui
  if not ui.frame then return end
  local page = BCG.pages[key]
  if not page then return end

  if ui.scroll and ui.scroll:GetScrollChild() then
    ui.scroll:GetScrollChild():Hide()
  end
  local content = page.build(ui.frame)
  ui.scroll:SetScrollChild(content)
  ui.currentKey = key
end
BCG.ShowPage = BCG_ShowPage

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
  title:SetText("Leatherworking & Trainer Locations in Turtle WoW")

  local close = CreateFrame("Button", nil, f, "UIPanelCloseButton")
  close:SetPoint("TOPRIGHT", f, "TOPRIGHT", -5, -5)

  -- NEW: copyright note
  if not BCG.ui.copyright then
    local cp = f:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    cp:SetFont(cp:GetFont(), 9)
    cp:SetText("|cffaaaaaa by Bashyo|r")
    cp:SetPoint("TOPRIGHT", f, "TOPRIGHT", -75, -20)
    BCG.ui.copyright = cp
  end

  local function makeNavButton(text, anchor, key)
    local b = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    b:SetWidth(90); b:SetHeight(22)
    if not anchor then
      b:SetPoint("TOPLEFT", f, "TOPLEFT", 16, -40)
    else
      b:SetPoint("LEFT", anchor, "RIGHT", 8, 0)
    end
    b:SetText(text)
    b:SetScript("OnClick", function() BCG_ShowPage(key) end)
    BCG.ui.buttons[key] = b
    return b
  end

  local homeBtn = makeNavButton("Home", nil, "home")
  local shopBtn = makeNavButton("Shopping", homeBtn, "shopping")

  local scroll = CreateFrame("ScrollFrame", "BashyoCraftingGuideScroll", f, "UIPanelScrollFrameTemplate")
  scroll:SetPoint("TOPLEFT",  f, "TOPLEFT",  16, -72)
  scroll:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -36, 20)

  BCG.ui.frame  = f
  BCG.ui.scroll = scroll
  return f
end

function BashyoCraftingGuide_Show()
  local f = BCG_CreateMainFrame()
  f:Show()
  if not BCG.ui.currentKey then BCG_ShowPage("home") else BCG_ShowPage(BCG.ui.currentKey) end
end

if type(SlashCmdList) ~= "table" then SlashCmdList = {} end
SLASH_BASHYOCRAFTINGGUIDE1 = "/bashyo"
SLASH_BASHYOCRAFTINGGUIDE2 = "/bcg"
SlashCmdList["BASHYOCRAFTINGGUIDE"] = function()
  BashyoCraftingGuide_Show()
end

local ev = CreateFrame("Frame")
ev:RegisterEvent("PLAYER_LOGIN")
ev:SetScript("OnEvent", function()
  msg("loaded. Use |cffffff00/bashyo|r or |cffffff00/bcg|r to open.")
end)

-- Keep the bank cache updated
local bankEv = CreateFrame("Frame")
bankEv:RegisterEvent("BANKFRAME_OPENED")
bankEv:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
bankEv:RegisterEvent("BANKFRAME_CLOSED")
bankEv:RegisterEvent("PLAYER_LOGIN")

bankEv:SetScript("OnEvent", function(_, evt)
  -- Ensure SavedVariables structure
  BashyoCraftingGuide_SV = BashyoCraftingGuide_SV or {}
  BashyoCraftingGuide_SV.bankCache = BashyoCraftingGuide_SV.bankCache or {}

  -- When bank is open: rescan all and refresh cache
  if evt == "BANKFRAME_OPENED" or evt == "PLAYERBANKSLOTS_CHANGED" then
    if BashyoCraftingGuide and BashyoCraftingGuide.Data and BashyoCraftingGuide.Data.Leatherworking then
      local D = BashyoCraftingGuide.Data.Leatherworking
      for _, id in pairs(D.MAT_ITEM_IDS or {}) do
        local _bags, _bank = D.SplitCounts( (function()
          for n, v in pairs(D.MAT_ITEM_IDS) do if v == id then return n end end
        end)() )
      end
    end
  end
end)