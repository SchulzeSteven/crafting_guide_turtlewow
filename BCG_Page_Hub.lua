-- BCG_Page_Hub.lua
BashyoCraftingGuide = BashyoCraftingGuide or {}
local BCG = BashyoCraftingGuide

local function BuildHub(parent)
  local f = CreateFrame("Frame", nil, parent)
  f:SetWidth(640); f:SetHeight(420)

  -- Addon description (centered, multi-line)
  local desc = f:CreateFontString(nil, "ARTWORK", "GameFontNormal")
  desc:ClearAllPoints()
  desc:SetPoint("TOP", f, "TOP", -90, 0)
  desc:SetWidth(450)
  desc:SetJustifyH("CENTER")
  desc:SetJustifyV("TOP")
  desc:SetSpacing(3)
  desc:SetText(
    "|cff33ff33B|rashyo|cff33ff33C|rafting|cff33ff33G|ruide helps you manage and level your professions more efficiently.\n\n" ..
    "• Central hub to access all supported professions.\n" ..
    "• Each profession offers pages such as |cff33ff33Trainer|r and |cff33ff33Shopping|r to organize your workflow.\n" ..
    "• Shopping lists |cff33ff33automatically calculate|r how many materials you still need, based on your |cff33ff33inventory|r and |cff33ff33bank|r contents.\n" ..
    "• The addon tracks item counts in your bags and caches your bank items when opened — using that data even when the bank is closed.\n" ..
    "• Item icons, crafting sources, and helpful |cff33ff33tooltips|r make it easy to see what’s missing and where to obtain it.\n" ..
    "• Designed for |cff33ff33Turtle WoW|r.\n" ..
    "• Fully scrollable, movable interface with tabs and a profession hub accessible via |cff33ff33/bcg|r.\n"
  )

  -- Untertitel zentrieren
  local sub = f:CreateFontString(nil, "ARTWORK", "GameFontNormal")
  sub:SetText("Choose a profession")
  sub:ClearAllPoints()
  sub:SetPoint("TOP", f, "TOP", -92, -220)
  sub:SetWidth(600)
  sub:SetJustifyH("CENTER")

  -- Button-Erstellung
  local function makeProfButton(text, x, y, onClick)
    local b = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    b:SetWidth(120); b:SetHeight(28)
    b:SetPoint("TOPLEFT", f, "TOPLEFT", x, y)
    b:SetText(text)
    if onClick then
      b:SetScript("OnClick", onClick)
    end
    return b  
  end

  -- === Alphabetisch sortierte Profession-Buttons (3 Reihen, 2 Spalten, mittig) ===
  local LEFT_X  = 80
  local RIGHT_X = 260

  -- Reihe 1
  makeProfButton("Alchemy",       LEFT_X,  -240, function()
    if BCG and BCG.ShowPage then BCG.ShowPage("al_trainer") end
  end)

  makeProfButton("Blacksmithing", RIGHT_X, -240, function()
    if BCG and BCG.ShowPage then BCG.ShowPage("bs_trainer") end
  end)

  -- Reihe 2
  makeProfButton("Enchanting",    LEFT_X,  -280, function()
    if BCG and BCG.ShowPage then BCG.ShowPage("en_trainer") end
  end)

  makeProfButton("Engineering",   RIGHT_X, -280, function()
    if BCG and BCG.ShowPage then BCG.ShowPage("eng_trainer") end
  end)

  -- Reihe 3
  makeProfButton("Leatherworking",LEFT_X,  -320, function()
    if BCG and BCG.ShowPage then BCG.ShowPage("lw_trainer") end
  end)

  makeProfButton("Tailoring",     RIGHT_X, -320, function()
    if BCG and BCG.ShowPage then BCG.ShowPage("ta_trainer") end
  end)

  -- Reihe 4 – Jewelcrafting (grau, inaktiv)
  local jewel = makeProfButton("Jewelcrafting", 170, -360)
  jewel:Disable()
  jewel:GetNormalTexture():SetVertexColor(0.5, 0.5, 0.5)
  jewel:GetHighlightTexture():SetVertexColor(0.5, 0.5, 0.5)
  jewel:GetDisabledTexture():SetVertexColor(0.4, 0.4, 0.4)

  -- Kleiner grauer Text rechts neben dem Button
  local label = f:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall")
  label:SetText("(Coming soon)")
  label:SetTextColor(0.7, 0.7, 0.7)  -- hellgrau
  label:SetPoint("LEFT", jewel, "RIGHT", 0, 0) -- 10px rechts vom Button


  -- Optionaler Tooltip
  jewel:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:AddLine("Jewelcrafting", 1, 1, 1)
    GameTooltip:AddLine("Coming soon!", 0.7, 0.7, 0.7)
    GameTooltip:Show()
  end)
  jewel:SetScript("OnLeave", function() GameTooltip:Hide() end)


  return f
end

BCG:RegisterPage("hub", "Professions", BuildHub)