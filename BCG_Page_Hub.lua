-- BCG_Page_Hub.lua
BashyoCraftingGuide = BashyoCraftingGuide or {}
local BCG = BashyoCraftingGuide

local function BuildHub(parent)
  local f = CreateFrame("Frame", nil, parent)
  f:SetWidth(640); f:SetHeight(420)

  local title = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
  title:SetPoint("TOPLEFT", f, "TOPLEFT", 12, -10)
  title:SetText("BashyoCraftingGuide")

  local sub = f:CreateFontString(nil, "ARTWORK", "GameFontNormal")
  sub:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
  sub:SetText("Choose a profession:")

  local function makeProfButton(text, x, y, onClick)
    local b = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    b:SetWidth(160); b:SetHeight(28)
    b:SetPoint("TOPLEFT", f, "TOPLEFT", x, y)
    b:SetText(text)
    b:SetScript("OnClick", onClick)
    return b
  end

  -- Leatherworking (öffnet die LW-Section; Tabs erscheinen automatisch)
  makeProfButton("Leatherworking", 12, -58, function()
    if BCG.ShowPage then BCG.ShowPage("lw_trainer") end
  end)

  -- Platzhalter für weitere Berufe:
  -- makeProfButton("Blacksmithing", 182, -58, function() BCG.ShowPage("bs_trainer") end)
  -- makeProfButton("Alchemy",       352, -58, function() BCG.ShowPage("al_trainer") end)

  return f
end

BCG:RegisterPage("hub", "Professions", BuildHub)