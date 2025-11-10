-- BCG_Page_Leatherworking.lua
local BCG = BashyoCraftingGuide

-- kurzhelper für Daten (kann nil sein, wenn Modul fehlt)
local function LW_DATA()
  return (BashyoCraftingGuide and BashyoCraftingGuide.Data and BashyoCraftingGuide.Data.Leatherworking) or nil
end

-- ===== Tooltip-Helper (einmalig) =====
local function GetBCGTooltip()
  if BashyoCraftingGuide and BashyoCraftingGuide.ui then
    if not BashyoCraftingGuide.ui.tip then
      local parent = (BashyoCraftingGuide.ui.frame or UIParent)
      local tip = CreateFrame("GameTooltip", "BashyoCraftingGuideTooltip", parent, "GameTooltipTemplate")
      tip:SetFrameStrata("TOOLTIP")
      tip:SetClampedToScreen(false)
      tip:Hide()
      BashyoCraftingGuide.ui.tip = tip
    end
    return BashyoCraftingGuide.ui.tip
  end
  return GameTooltip
end

local function HideTooltip()
  local tip = GetBCGTooltip()
  if tip and tip.Hide then tip:Hide() end
  if GameTooltip and GameTooltip.Hide then GameTooltip:Hide() end
end

-- =====================================
-- TRAINER-SEITE
-- =====================================
local function AddHeader(parent, anchor, text, color)
  local fs = parent:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
  fs:SetJustifyH("LEFT")
  local c = color or {r=1,g=0.82,b=0}
  fs:SetTextColor(c.r, c.g, c.b)
  fs:SetPoint("TOPLEFT", anchor or parent, anchor and "BOTTOMLEFT" or "TOPLEFT", 0, anchor and -16 or -6)
  fs:SetText(text)
  return fs
end

local function AddTrainerLine(parent, anchor, name, zone, way, color)
  local row = CreateFrame("Frame", nil, parent)
  row:SetWidth(1); row:SetHeight(16)
  row:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -8)

  local dot = row:CreateFontString(nil, "ARTWORK", "GameFontNormal")
  dot:SetPoint("LEFT", row, "LEFT", 0, 0); dot:SetText("•")

  local line = row:CreateFontString(nil, "ARTWORK", "GameFontNormal")
  line:SetPoint("LEFT", dot, "RIGHT", 8, 0)
  line:SetJustifyH("LEFT")

  local c = color or {r=1,g=1,b=1}
  local nameColor = string.format("|cff%02x%02x%02x", c.r*255, c.g*255, c.b*255)
  line:SetText(string.format("%s%s|r: %s |cffaaaaaa%s|r", nameColor, name or "?", zone or "?", way or "?"))
  return row
end

local TRAINERS = {
  { header="Alliance Apprentice and Journeyman Leatherworking Trainers (1–75 and 75–150)",
    color={r=0.58,g=0.8,b=1.0},
    list={
      {"Aayndia Florawind","Ashenvale","35, 52"},
      {"Adele Fielder","Elwynn Forest","46, 62"},
      {"Drakk Stonehand","The Hinterlands","13, 43"},
      {"Fimble Finespindle","Ironforge","40, 32"},
      {"Nadiya Maneweaver","Teldrassil","43, 43"},
      {"Randal Worth","Stormwind City","68, 49"},
      {"Telonis","Darnassus","64, 21"},
    }},
  { header="Horde Apprentice & Journeyman Leatherworking Trainers (1–75 and 75–150)",
    color={r=1.0,g=0.55,b=0.55},
    list={
      {"Arthur Moore","Undercity","70, 58"},
      {"Brawn","Stranglethorn Vale","37, 50"},
      {"Brumn Winterhoof","Arathi Highlands","28, 45"},
      {"Chaw Stronghide","Mulgore","45, 57"},
      {"Hahrana Ironhide","Feralas","74, 43"},
      {"Karolek","Orgrimmar","60, 54"},
      {"Shelenne Rhobart","Tirisfal Glades","65, 60"},
      {"Una","Thunder Bluff","41, 42"},
    }},
  { header="Expert Leatherworking Trainers (150–225)",
    color={r=1.0,g=0.82,b=0.0},
    list={{"Telonis","Darnassus","64, 21",{r=0.58,g=0.8,b=1.0}},{"Una","Thunder Bluff","41, 42",{r=1.0,g=0.55,b=0.55}}}},
  { header="Artisan Leatherworking Trainers (225–300)",
    color={r=1.0,g=0.82,b=0.0},
    list={
      {"Drakk Stonehand","Aerie Peak, The Hinterlands","13, 43",{r=0.58,g=0.8,b=1.0}},
      {"Hahrana Ironhide","Camp Mojache, Feralas","74, 43",{r=1.0,g=0.55,b=0.55}},
    }},
}

local function BuildTrainer(parent)
  local content = CreateFrame("Frame", nil, parent)
  content:SetWidth(680); content:SetHeight(450)

  local sub = content:CreateFontString(nil, "ARTWORK", "GameFontNormal")
  sub:SetPoint("TOPLEFT", content, "TOPLEFT", 8, -6)
  sub:SetText("Ranks, trainers, and coordinates for Classic.")

  local last = sub
  local total = 40
  for _, block in ipairs(TRAINERS) do
    last = AddHeader(content, last, block.header, block.color); total = total + 24
    for _, t in ipairs(block.list) do
      last = AddTrainerLine(content, last, t[1], t[2], t[3], t[4])
      total = total + 24
    end
  end
  content:SetHeight(total + 20)
  return content
end

-- =====================================
-- SHOPPING-SEITE
-- =====================================
local function GetSkillLevelByAnyName(names)
  local n = GetNumSkillLines()
  for i=1,n do
    local name, isHeader, _, rank = GetSkillLineInfo(i)
    if not isHeader and name then
      for j=1, table.getn(names) do
        if name == names[j] then return rank or 0 end
      end
    end
  end
  return nil
end

local function nextMilestone(s) local t={75,150,225,300} for i=1,4 do if s<t[i] then return t[i] end end return 300 end
local function ceil_safe(x) return math.ceil((x or 0) - 1e-9) end

local function slice_linear(cur,tgt,fromL,toL,total)
  if (total or 0)<=0 then return 0 end
  local start=math.max(cur or 0, fromL); local stop=math.min(tgt or 0, toL)
  if stop<=start then return 0 end
  local share=(stop-start)/(toL-fromL); return ceil_safe(total*share)
end

local function slice_craft(cur,tgt,fromL,toL,total,unit)
  if (total or 0)<=0 or not unit or unit<=0 then return 0 end
  local start=math.max(cur or 0, fromL); local stop=math.min(tgt or 0, toL)
  if stop<=start then return 0 end
  local crafts_total=total/unit
  if math.abs(crafts_total-math.floor(crafts_total+1e-9))>1e-6 then
    return ceil_safe(((stop-start)/(toL-fromL))*total)
  end
  local share=(stop-start)/(toL-fromL)
  return math.ceil(crafts_total*share-1e-9)*unit
end

local function estimateByGuide(cur,tgt)
  if type(cur)~="number" or type(tgt)~="number" or cur>=tgt then return {} end
  local D = LW_DATA()
  if not D or not D.GUIDE_STEPS then return {} end
  local need = {}
  local function add(n,v) if v and v>0 then need[n]=(need[n] or 0)+v end end
  for i=1, table.getn(D.GUIDE_STEPS) do
    local st = D.GUIDE_STEPS[i]
    if cur<st.to and tgt>st.from then
      for name,spec in pairs(st.mats) do
        if type(spec)=="number" then add(name, slice_linear(cur,tgt,st.from,st.to,spec))
        else add(name, slice_craft(cur,tgt,st.from,st.to,spec.total,spec.unit)) end
      end
    end
  end
  return need
end

local LW = { names={"Leatherworking","Lederverarbeitung"}, label="Leatherworking" }
local function calcListTo(target)
  local s = GetSkillLevelByAnyName(LW.names)
  if not s then return "Leatherworking not learned.", {}, nil, nil end
  if s>=target then return string.format("You already have %d in %s.", s, LW.label), {}, nil, nil end
  local mats=estimateByGuide(s,target)
  return string.format("Shopping list for %s %d -> %d (Guide):", LW.label, s, target), mats, s, target
end

-- eine Zeile im Material-Block
local LEFT_PADDING, ROW_H = 16, 22
local function CreateMatRow(parent, index, mat, count, delta)   -- <— delta dazu
  local row = CreateFrame("Frame", nil, parent)
  row:SetWidth(360); row:SetHeight(ROW_H)
  if index==1 then
    row:SetPoint("TOPLEFT", parent, "TOPLEFT", LEFT_PADDING, -2)
  else
    row:SetPoint("TOPLEFT", parent._lastRow, "BOTTOMLEFT", 0, -4)
  end
  parent._lastRow = row

  local D = LW_DATA()

  local tex = row:CreateTexture(nil, "ARTWORK"); tex:SetWidth(18); tex:SetHeight(18)
  tex:SetPoint("LEFT", row, "LEFT", 0, 0)
  local icon = (D and D.IconFor and D.IconFor(mat)) or "Interface\\Icons\\INV_Misc_QuestionMark"
  tex:SetTexture(icon)

  local fs = row:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
  fs:SetPoint("LEFT", tex, "RIGHT", 6, 0)

  -- Text: benötigte Menge + (abgezogen aus Inventar)
  local need  = tonumber(count or 0) or 0
  local took  = tonumber(delta or 0) or 0
  local tail  = (took > 0) and (" |cff88ff88(-"..took..")|r") or ""
  fs:SetText(mat.."  x"..need..tail)

  local badge = row:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
  badge:SetPoint("RIGHT", row, "RIGHT", 0, 0)
  if D and D.IsVendor and D.IsVendor(mat) then
    badge:SetText("|cffffff00[Vendor]|r")
  elseif D and D.IsCreated and D.IsCreated(mat) then
    badge:SetText("|cffaaaaaa[AH/Created]|r")
  else
    badge:SetText("|cff00ff00[AH/Farm]|r")
  end

  local function attachHover(target)
    local hot = CreateFrame("Frame", nil, row)
    hot:SetFrameLevel(row:GetFrameLevel() + 1)
    hot:SetAllPoints(target)
    hot:EnableMouse(true)
    hot:SetScript("OnEnter", function()
      local have = ((D and D.CountInBagsAndBank) and D.CountInBagsAndBank(mat)) or 0
      local need = tonumber(count or 0) or 0
      local remaining = math.max(need - have, 0)

      local bags, bank = 0, 0
      if D and D.SplitCounts then bags, bank = D.SplitCounts(mat) end

      local parentFrame = (BashyoCraftingGuide and BashyoCraftingGuide.ui and BashyoCraftingGuide.ui.frame) or UIParent
      local tip = GetBCGTooltip(); if not tip then return end
      tip:SetOwner(hot, "ANCHOR_NONE")
      tip:ClearAllPoints()
      tip:SetParent(parentFrame)
      tip:SetClampedToScreen(false)

      local x = (hot:GetRight() or 0) - (parentFrame:GetLeft() or 0) + 10
      local y = (parentFrame:GetTop() or 0) - (hot:GetTop() or 0) + 8
      local maxX = (parentFrame:GetWidth() or 640) - 260
      local maxY = (parentFrame:GetHeight() or 480) - 120
      if x < 8 then x = 8 elseif x > maxX then x = maxX end
      if y < 8 then y = 8 elseif y > maxY then y = maxY end
      tip:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", x, -y)

      tip:ClearLines()
      tip:AddLine(mat, 1, 0.82, 0, true)
      tip:AddLine(string.format("You have: |cff88ff88%d|r", have))
      tip:AddLine(string.format("Need: |cffffff00%d|r", need))
      tip:AddLine(string.format("Remaining: |cffff5555%d|r", remaining))

      local locText
      if have == 0 then
        locText = "Location: none"
      elseif bags > 0 and bank > 0 then
        locText = string.format("Location: Inventory (%d), Bank (%d)", bags, bank)
      elseif bags > 0 then
        locText = string.format("Location: Inventory (%d)", bags)
      else
        locText = string.format("Location: Bank (%d)", bank)
      end
      tip:AddLine(locText, 0.7, 0.7, 0.7)
      tip:Show()
    end)
    hot:SetScript("OnLeave", HideTooltip)
  end

  attachHover(tex)
  attachHover(fs)

  return row
end

-- Rezept-Tooltip
local function ShowRecipeTooltip(owner, recName)
  local frame  = BashyoCraftingGuide and BashyoCraftingGuide.ui and BashyoCraftingGuide.ui.frame
  local anchor = BashyoCraftingGuide and BashyoCraftingGuide.ui and BashyoCraftingGuide.ui.recipesLabel
  local tip    = GetBCGTooltip(); if not tip then return end

  tip:SetOwner(owner or (frame or UIParent), "ANCHOR_NONE")
  tip:ClearAllPoints()
  if anchor and frame then
    tip:SetParent(frame)
    tip:SetPoint("TOPLEFT", anchor, "TOPRIGHT", 200, -30)
  else
    tip:SetPoint("TOPLEFT", owner or UIParent, "TOPRIGHT", 8, 0)
  end

  tip:ClearLines()
  local D = LW_DATA()
  local itemId = D and D.RECIPE_ITEM_IDS and D.RECIPE_ITEM_IDS[recName]
  if itemId and tip.SetHyperlink then
    tip:SetHyperlink("item:"..itemId)
    tip:AddLine(" ", 1,1,1)
  else
    tip:AddLine(recName or "Recipe", 1, 0.82, 0, true)
  end
end

local function CreateRecipeRow(parent, anchor, st)
  local D = LW_DATA()
  local row = CreateFrame("Frame", nil, parent)
  row:SetWidth(520); row:SetHeight(18)
  row:EnableMouse(true)

  if anchor then
    row:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -6)
  else
    row:SetPoint("TOPLEFT", parent, "TOPLEFT", LEFT_PADDING, -(parent._recipes_y0 or 0))
  end

  -- aktueller Skill
  local skill = GetSkillLevelByAnyName({"Leatherworking","Lederverarbeitung"}) or 0

  -- Rot, wenn der Abschnitt abgeschlossen ist
  local isReached = (skill >= (st.to or 0))
  local nameColor = isReached and "|cffff5555" or "|cffffffff" -- rot oder weiß
  local rangeGray = isReached and "|cffffaaaa" or "|cffaaaaaa" -- heller grau-ton

  -- Menge dynamisch reduzieren (linear über den Abschnitt)
  local shownCount = st.count or 0
  if skill > (st.from or 0) and skill < (st.to or 0) then
    local totalRange = (st.to - st.from)
    local progress   = skill - st.from
    local ratio      = 1 - (progress / totalRange)
    shownCount = math.max(1, math.ceil(shownCount * ratio))
  elseif skill >= (st.to or 0) then
    shownCount = 0    -- Abschnitt komplett -> nichts mehr craften
  end

  -- Levelbereich
  local lvl = row:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall")
  lvl:SetJustifyH("LEFT"); lvl:SetWidth(80)
  lvl:SetPoint("LEFT", row, "LEFT", LEFT_PADDING, 0)
  lvl:SetText(string.format("%s%d – %d|r", rangeGray, st.from or 0, st.to or 0))

  -- Menge
  local cnt = row:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
  cnt:SetJustifyH("RIGHT"); cnt:SetWidth(28)
  cnt:SetPoint("LEFT", lvl, "RIGHT", -10, 0)
  cnt:SetText(string.format("%s%s%d|r", nameColor, st.approx and "~" or "", shownCount))

  -- Icon
  local icon = row:CreateTexture(nil, "ARTWORK")
  icon:SetWidth(14); icon:SetHeight(14)
  icon:SetPoint("LEFT", cnt, "RIGHT", 8, 0)
  icon:SetTexture(((D and D.IconFor) and D.IconFor(st.icon or st.name)) or "Interface\\Icons\\INV_Misc_QuestionMark")

  -- Name
  local txt = row:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
  txt:SetPoint("LEFT", icon, "RIGHT", 6, 0)
  txt:SetText(string.format("%s%s|r", nameColor, st.name or "?"))

  -- (Optionaler Tooltip, falls du ihn willst)
  local function addHover(target)
    local h = CreateFrame("Frame", nil, row)
    h:SetAllPoints(target); h:EnableMouse(true)
    h:SetScript("OnEnter", function() ShowRecipeTooltip(h, st.name) end)
    h:SetScript("OnLeave", HideTooltip)
  end
  addHover(icon); addHover(txt)

  return row
end


-- Inventar von Bedarf abziehen
local function ApplyInventoryToMats(mats)
  local D = LW_DATA()
  if type(mats) ~= "table" then return false end
  if not D then return false end
  mats._invDelta = {}
  local changed = false
  for mat, need in pairs(mats) do
    if type(need) == "number" and need > 0 then
      local have = (D.CountInBagsAndBank and D.CountInBagsAndBank(mat)) or 0
      if have > 0 then
        local newNeed = need - have
        if newNeed < 0 then newNeed = 0 end
        if newNeed ~= need then
          mats[mat] = newNeed
          mats._invDelta[mat] = have
          changed = true
        end
      end
    end
  end
  if next(mats._invDelta) == nil then mats._invDelta = nil end
  return changed
end

local function BuildShopping(parent)
  local content = CreateFrame("Frame", nil, parent)
  content:SetWidth(640); content:SetHeight(480)

  local hint = content:CreateFontString(nil, "ARTWORK", "GameFontNormal")
  hint:SetPoint("TOPLEFT", content, "TOPLEFT", 8, -4)
  hint:SetText("Guide shopping lists. Choose a milestone:")

  -- Manual Mode Toggle
  local testMode = false
  local testChk = CreateFrame("CheckButton", nil, content, "UICheckButtonTemplate")
  testChk:SetPoint("TOPLEFT", content, "TOPLEFT", 300, -20)
  testChk.text = testChk:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
  testChk.text:SetPoint("LEFT", testChk, "RIGHT", 2, 0)
  testChk.text:SetText("Show All Ranks")
  local currentTarget = nil

  testChk:SetScript("OnClick", function()
    testMode = testChk:GetChecked() and true or false
    if not currentTarget then
      local s = GetSkillLevelByAnyName({"Leatherworking","Lederverarbeitung"}) or 0
      currentTarget = nextMilestone(s) or 75
    end
    render(currentTarget)
  end)


  local function makeBtn(caption, x, onClick)
    local b = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    b:SetWidth(70); b:SetHeight(22)
    b:SetPoint("TOPLEFT", content, "TOPLEFT", 8 + x, -24)
    b:SetText(caption)
    b:SetScript("OnClick", onClick)
    return b
  end

  local matsArea = CreateFrame("Frame", nil, content)
  matsArea:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -58)
  matsArea:SetWidth(620); matsArea:SetHeight(100)

  local rule = content:CreateTexture(nil, "ARTWORK")
  rule:SetTexture("Interface\\Buttons\\WHITE8x8"); rule:SetVertexColor(1,1,1,0.15)

  local recipesLabel = content:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
  recipesLabel:SetTextColor(1,0.82,0); recipesLabel:SetText("RECIPES")
  BashyoCraftingGuide.ui.recipesLabel = recipesLabel

  local recipeArea = CreateFrame("Frame", nil, content)

  local function bracketStartFor(target)
    if target <= 75 then return 1
    elseif target <= 150 then return 75
    elseif target <= 225 then return 150
    else return 225 end
  end
  local function calcListForRange(fromL, toL)
    local mats = estimateByGuide(fromL, toL)
    return string.format("Shopping list %d -> %d (Guide):", fromL, toL), mats, fromL, toL
  end

  function render(target)
    currentTarget = target
    HideTooltip()

    matsArea._lastRow = nil
    for _, c in ipairs({matsArea:GetChildren()}) do if c.Hide then c:Hide() end end

    local title, mats, fromL, toL
    if testMode then
      local fromB = bracketStartFor(target)
      title, mats, fromL, toL = calcListForRange(fromB, target)
    else
      title, mats, fromL, toL = calcListTo(target)
    end
    hint:SetText(title or "")

    if type(mats) == "table" then
      local invChanged = ApplyInventoryToMats(mats)
      if invChanged and title then
        hint:SetText(title .. " |cff88ff88(Inventory applied)|r")
      end
    else
      mats = {}
    end

    local keys, kN = {}, 0
    for k,_ in pairs(mats) do if k ~= "_invDelta" then kN = kN + 1; keys[kN] = k end end

    local D = LW_DATA()
    local less = (D and D.SortKeyLess) or function(a,b) return tostring(a) < tostring(b) end
    for i=2, kN do
      local v = keys[i]; local j = i - 1
      while j >= 1 and less(v, keys[j]) do keys[j+1] = keys[j]; j = j - 1 end
      keys[j+1] = v
    end

    -- innerhalb von function render(target)
local count = 0
for i=1, kN do
  local m, n = keys[i], mats[keys[i]]
  if n and n > 0 then
    count = count + 1
    local delta = mats._invDelta and mats._invDelta[m] or 0   -- <—
    CreateMatRow(matsArea, count, m, n, delta)                -- <—
  end
end


    local inner_h = math.max(20, count * (ROW_H + 4))
    matsArea:SetWidth(620); matsArea:SetHeight(inner_h)

    if not (fromL and toL) then
      if rule and rule.Hide then rule:Hide() end
      if recipesLabel and recipesLabel.Hide then recipesLabel:Hide() end
      for _, c in ipairs({recipeArea:GetChildren()}) do if c.Hide then c:Hide() end end
      recipeArea:SetWidth(620); recipeArea:SetHeight(1); recipeArea:Hide()
      content:SetHeight(inner_h + 20)
      local ui = BashyoCraftingGuide.ui
      if ui and ui.scroll and ui.scroll.UpdateScrollChildRect then ui.scroll:UpdateScrollChildRect() end
      return
    end

    rule:Show()
    rule:ClearAllPoints()
    rule:SetPoint("TOPLEFT",  content, "TOPLEFT",  LEFT_PADDING, -(inner_h + 104))
    rule:SetPoint("TOPRIGHT", content, "TOPRIGHT", -20,          -(inner_h + 104))
    rule:SetHeight(1)

    recipesLabel:Show()
    recipesLabel:ClearAllPoints()
    recipesLabel:SetPoint("BOTTOMLEFT", rule, "TOPLEFT", 18, 2)
    recipesLabel:SetJustifyH("LEFT")

    for _, c in ipairs({recipeArea:GetChildren()}) do if c.Hide then c:Hide() end end
    HideTooltip()
    recipeArea:Show()
    recipeArea:ClearAllPoints()
    recipeArea:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -(inner_h + 100 + 22))
    recipeArea:SetWidth(620); recipeArea:SetHeight(10)

    local steps = (D and D.RECIPE_STEPS) or {}
    local last, rcount = nil, 0
    for i=1, table.getn(steps) do
      local st = steps[i]
      if (toL > st.from) and (fromL < st.to) then
        rcount = rcount + 1
        last = CreateRecipeRow(recipeArea, last, st)
      end
    end

    local recipes_h = (rcount > 0) and (rcount * 18 + (rcount - 1) * 6) or 0
    recipeArea:SetWidth(620); recipeArea:SetHeight(recipes_h)

    content:SetHeight(inner_h + 24 + 22 + recipes_h + 20)
    local ui = BashyoCraftingGuide.ui
    if ui and ui.scroll and ui.scroll.UpdateScrollChildRect then ui.scroll:UpdateScrollChildRect() end
  end

  -- Buttons
  makeBtn("1-75",    0,   function() render(75)   end)
  makeBtn("75-150",  74,  function() render(150)  end)
  makeBtn("150-225", 148, function() render(225)  end)
  makeBtn("225-300", 222, function() render(300)  end)

  -- Live-Updates
  local bagWatcher = CreateFrame("Frame", nil, content)
  bagWatcher:RegisterEvent("BAG_UPDATE")
  bagWatcher:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
  bagWatcher:RegisterEvent("BANKFRAME_OPENED")
  bagWatcher:RegisterEvent("BANKFRAME_CLOSED")
  bagWatcher:SetScript("OnEvent", function() if currentTarget then render(currentTarget) end end)

  -- Initial
  local s = GetSkillLevelByAnyName({"Leatherworking","Lederverarbeitung"}) or 0
  local init = (s and nextMilestone(s)) or 75
  render(init)

  return content
end

-- in BuildShopping(...) NACH der Definition von render(...)
local skillWatcher = CreateFrame("Frame", nil, content)
skillWatcher:RegisterEvent("SKILL_LINES_CHANGED")
skillWatcher:RegisterEvent("CHAT_MSG_SKILL") -- Classic-Fallback
skillWatcher:SetScript("OnEvent", function()
  if currentTarget then render(currentTarget) end
end)


-- ================= Register pages =================
BCG:RegisterPage("lw_trainer",  "Trainer",  BuildTrainer)
BCG:RegisterPage("lw_shopping", "Shopping", BuildShopping)