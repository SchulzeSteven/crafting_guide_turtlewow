local BCG = BashyoCraftingGuide
local Common = BCG.PageCommon
local Data   = BCG.Data
local makeD  = Data._makeD

local PROF = {
key = "leatherworking",
names = {"Leatherworking","Lederverarbeitung"},
label = "Leatherworking",
prefix = "lw",
}

Common.RegisterProfession(PROF)

----------------------------------------------------------------------
-- LEATHERWORKING data (copied from original version)
----------------------------------------------------------------------

local D_LW = makeD()

D_LW.VENDOR_MATS = {
  ["Coarse Thread"] = true,
  ["Fine Thread"]   = true,
  ["Silken Thread"] = true,
  ["Rune Thread"]   = true,
  ["Salt"]          = true,
  ["Gray Dye"]      = true,
  ["Black Dye"]     = true,
}

D_LW.CREATED_MATS = {
  ["Cured Medium Hide"] = true,
  ["Cured Heavy Hide"]  = true,
}

D_LW.MAT_ICONS = {
  ["Light Leather"]        = "Interface\\Icons\\INV_Misc_LeatherScrap_03",
  ["Medium Leather"]       = "Interface\\Icons\\INV_Misc_LeatherScrap_05",
  ["Heavy Leather"]        = "Interface\\Icons\\INV_Misc_LeatherScrap_07",
  ["Thick Leather"]        = "Interface\\Icons\\INV_Misc_LeatherScrap_08",
  ["Rugged Leather"]       = "Interface\\Icons\\INV_Misc_LeatherScrap_02",
  ["Light Hide"]           = "Interface\\Icons\\inv_misc_pelt_wolf_ruin_02",
  ["Medium Hide"]          = "Interface\\Icons\\inv_misc_pelt_boar_ruin_02",
  ["Heavy Hide"]           = "Interface\\Icons\\inv_misc_pelt_wolf_ruin_03",
  ["Thick Hide"]           = "Interface\\Icons\\INV_Misc_Pelt_Bear_02",
  ["Rugged Hide"]          = "Interface\\Icons\\INV_Misc_Pelt_Bear_01",
  ["Ruined Leather Scraps"]= "Interface\\Icons\\inv_misc_pelt_bear_ruin_05",
  ["Coarse Thread"]        = "Interface\\Icons\\inv_fabric_linen_03",
  ["Fine Thread"]          = "Interface\\Icons\\inv_fabric_wool_02",
  ["Silken Thread"]        = "Interface\\Icons\\inv_fabric_silk_02",
  ["Rune Thread"]          = "Interface\\Icons\\spell_shadow_antimagicshell",
  ["Salt"]                 = "Interface\\Icons\\INV_Misc_Dust_02",
  ["Gray Dye"]             = "Interface\\Icons\\inv_drink_10",
  ["Black Dye"]            = "Interface\\Icons\\inv_potion_63",
  ["Cured Medium Hide"]    = "Interface\\Icons\\inv_misc_pelt_bear_02",
  ["Cured Heavy Hide"]     = "Interface\\Icons\\inv_misc_pelt_wolf_02",
  ["Light Armor Kit"]      = "Interface\\Icons\\INV_Misc_ArmorKit_17",
  ["Embossed Leather Gloves"] = "Interface\\Icons\\INV_Gauntlets_05",
  ["Fine Leather Belt"]    = "Interface\\Icons\\INV_Belt_04",
  ["Dark Leather Boots"]   = "Interface\\Icons\\INV_Boots_05",
  ["Dark Leather Belt"]    = "Interface\\Icons\\INV_Belt_03",
  ["Heavy Armor Kit"]      = "Interface\\Icons\\INV_Misc_ArmorKit_16",
  ["Barbaric Shoulders"]   = "Interface\\Icons\\INV_Shoulder_08",
  ["Guardian Gloves"]      = "Interface\\Icons\\INV_Gauntlets_05",
  ["Thick Armor Kit"]      = "Interface\\Icons\\INV_Misc_ArmorKit_07",
  ["Nightscape Headband"]  = "Interface\\Icons\\inv_helmet_40",
  ["Nightscape Pants"]     = "Interface\\Icons\\INV_Pants_11",
  ["Rugged Armor Kit"]     = "Interface\\Icons\\INV_Misc_ArmorKit_09",
  ["Wolfshead Helm"]     = "Interface\\Icons\\inv_helmet_04",
  ["Helm of Fire"]     = "Interface\\Icons\\inv_helmet_08",
  ["Dragonscale Gauntlets"]     = "Interface\\Icons\\inv_gauntlets_10",
  ["Dragonscale Breastplate"]     = "Interface\\Icons\\inv_chest_chain_07",
  ["Green Dragonscale Gauntlets"]     = "Interface\\Icons\\inv_gauntlets_12",
  ["Blue Dragonscale Leggings"]     = "Interface\\Icons\\inv_pants_mail_15",
  ["Gauntlets of the Sea"]     = "Interface\\Icons\\inv_gauntlets_30",
  ["Feathered Breastplate"]     = "Interface\\Icons\\inv_chest_leather_06",
  ["Wicked Leather Gauntlets"] = "Interface\\Icons\\INV_Gauntlets_31",
  ["Wicked Leather Headband"]  = "Interface\\Icons\\inv_misc_bandage_13",
  ["Pattern: Hide of the Wild"]  = "Interface\\Icons\\inv_scroll_04",
  ["Pattern: Warbear Woolies"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Warbear Harness"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Corehound Belt"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Corehound Boots"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Devilsaur Leggings"]  = "Interface\\Icons\\inv_scroll_05",
  ["Pattern: Devilsaur Gauntlets"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Frostsaber Tunic"]  = "Interface\\Icons\\inv_scroll_06",
  ["Pattern: Frostsaber Gloves"]  = "Interface\\Icons\\inv_scroll_06",
  ["Pattern: Frostsaber Leggings"]  = "Interface\\Icons\\inv_scroll_06",
  ["Pattern: Frostsaber Boots"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Chimeric Vest"]  = "Interface\\Icons\\inv_scroll_06",
  ["Pattern: Chimeric Leggings"]  = "Interface\\Icons\\inv_scroll_06",
  ["Pattern: Chimeric Boots"]  = "Interface\\Icons\\inv_scroll_06",
  ["Pattern: Chimeric Gloves"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Ironfeather Breastplate"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Ironfeather Shoulders"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Shifting Cloak"]  = "Interface\\Icons\\inv_scroll_04",
  ["Pattern: Molten Belt"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Molten Helm"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Stormshroud Gloves"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Stormshroud Shoulders"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Stormshroud Armor"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Stormshroud Pants"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Living Leggings"]  = "Interface\\Icons\\inv_scroll_05",
  ["Pattern: Living Shoulders"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Living Breastplate"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Volcanic Leggings"]  = "Interface\\Icons\\inv_scroll_06",
  ["Pattern: Volcanic Breastplate"]  = "Interface\\Icons\\inv_scroll_06",
  ["Pattern: Volcanic Shoulders"]  = "Interface\\Icons\\inv_scroll_06",
  ["Pattern: Dreamscale Breastplate"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Chromatic Gauntlets"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Black Dragonscale Boots"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Black Dragonscale Leggings"]  = "Interface\\Icons\\inv_scroll_05",
  ["Pattern: Black Dragonscale Shoulders"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Black Dragonscale Breastplate"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Blue Dragonscale Shoulders"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Blue Dragonscale Breastplate"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Red Dragonscale Breastplate"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Green Dragonscale Leggings"]  = "Interface\\Icons\\inv_scroll_03",
  ["Pattern: Green Dragonscale Breastplate"]  = "Interface\\Icons\\inv_scroll_03",
}

D_LW.RECIPE_ITEM_IDS = {
  ["Light Armor Kit"]        = 2304,
  ["Embossed Leather Gloves"]= 4239,
  ["Fine Leather Belt"]      = 4246,
  ["Dark Leather Boots"]     = 2315,
  ["Dark Leather Belt"]      = 4248,
  ["Heavy Armor Kit"]        = 2313,
  ["Barbaric Shoulders"]     = 5964,
  ["Guardian Gloves"]        = 5966,
  ["Thick Armor Kit"]        = 8173,
  ["Nightscape Headband"]    = 8176,
  ["Nightscape Pants"]       = 8193,
  ["Rugged Armor Kit"]       = 15564,
  ["Wolfshead Helm"]         = 8345,
  ["Helm of Fire"]           = 8348,
  ["Dragonscale Gauntlets"]  = 8347,
  ["Dragonscale Breastplate"] = 8367,
  ["Green Dragonscale Gauntlets"] = 20296,
  ["Blue Dragonscale Leggings"]  = 20295,
  ["Gauntlets of the Sea"]   = 8346,
  ["Feathered Breastplate"]  = 8349,
  ["Wicked Leather Gauntlets"]= 15083,
  ["Wicked Leather Headband"]= 15086,
  ["Pattern: Hide of the Wild"]= 18518,
  ["Pattern: Warbear Woolies"]= 20254,
  ["Pattern: Warbear Harness"]= 20253,
  ["Pattern: Corehound Belt"]= 19332,
  ["Pattern: Corehound Boots"]= 17022,
  ["Pattern: Devilsaur Leggings"]= 15772,
  ["Pattern: Devilsaur Gauntlets"]= 15758,
  ["Pattern: Frostsaber Tunic"]= 15779,
  ["Pattern: Frostsaber Gloves"]= 15761,
  ["Pattern: Frostsaber Leggings"]= 15747,
  ["Pattern: Frostsaber Boots"]= 15740,
  ["Pattern: Chimeric Vest"]= 15755,
  ["Pattern: Chimeric Leggings"]= 15746,
  ["Pattern: Chimeric Boots"]= 15737,
  ["Pattern: Chimeric Gloves"]= 15729,
  ["Pattern: Ironfeather Breastplate"]= 15760,
  ["Pattern: Ironfeather Shoulders"]= 15735,
  ["Pattern: Shifting Cloak"]= 18519,
  ["Pattern: Molten Belt"]= 19333,
  ["Pattern: Molten Helm"]= 17023,
  ["Pattern: Stormshroud Gloves"]= 21548,
  ["Pattern: Stormshroud Shoulders"]= 15764,
  ["Pattern: Stormshroud Armor"]= 15753,
  ["Pattern: Stormshroud Pants"]= 15741,
  ["Pattern: Living Leggings"]= 15752,
  ["Pattern: Living Shoulders"]= 15734,
  ["Pattern: Living Breastplate"]= 15771,
  ["Pattern: Volcanic Leggings"]= 15732,
  ["Pattern: Volcanic Breastplate"]= 15749,
  ["Pattern: Volcanic Shoulders"]= 15775,
  ["Pattern: Dreamscale Breastplate"]= 20382,
  ["Pattern: Chromatic Gauntlets"]= 19331,
  ["Pattern: Black Dragonscale Boots"]= 17025,
  ["Pattern: Black Dragonscale Leggings"]= 15781,
  ["Pattern: Black Dragonscale Shoulders"]= 15770,
  ["Pattern: Black Dragonscale Breastplate"]= 15759,
  ["Pattern: Blue Dragonscale Shoulders"]= 15763,
  ["Pattern: Blue Dragonscale Breastplate"]= 15751,
  ["Pattern: Red Dragonscale Breastplate"]= 15730,
  ["Pattern: Green Dragonscale Leggings"]= 15733,
  ["Pattern: Green Dragonscale Breastplate"]= 15726,
}

D_LW.MAT_ITEM_IDS = {
  ["Light Leather"]   = 2318,
  ["Medium Leather"]  = 2319,
  ["Heavy Leather"]   = 4234,
  ["Thick Leather"]   = 4304,
  ["Rugged Leather"]  = 8170,
  ["Light Hide"]      = 783,
  ["Medium Hide"]     = 4232,
  ["Heavy Hide"]      = 4235,
  ["Thick Hide"]      = 8169,
  ["Rugged Hide"]     = 8171,
  ["Ruined Leather Scraps"] = 2934,
  ["Coarse Thread"]   = 2320,
  ["Fine Thread"]     = 2321,
  ["Silken Thread"]   = 4291,
  ["Rune Thread"]     = 14341,
  ["Salt"]            = 4289,
  ["Gray Dye"]        = 4340,
  ["Black Dye"]       = 2325,
  ["Cured Medium Hide"]= 4233,
  ["Cured Heavy Hide"] = 4236,
}

D_LW.SORT_WEIGHT = {
  ["Ruined Leather Scraps"] = 1,

  ["Light Leather"]   = 2,
  ["Medium Leather"]  = 3,
  ["Heavy Leather"]   = 4,
  ["Thick Leather"]   = 5,
  ["Rugged Leather"]  = 6,

  ["Light Hide"]      = 10,
  ["Medium Hide"]     = 11,
  ["Heavy Hide"]      = 12,
  ["Thick Hide"]      = 13,
  ["Rugged Hide"]     = 14,

  ["Coarse Thread"]   = 20,
  ["Fine Thread"]     = 21,
  ["Silken Thread"]   = 22,
  ["Rune Thread"]     = 23,

  ["Salt"]            = 30,
  ["Gray Dye"]        = 31,
  ["Black Dye"]       = 32,

  ["Cured Medium Hide"]= 40,
  ["Cured Heavy Hide"] = 41,
}

D_LW.GUIDE_STEPS = {
  { from = 1,   to = 30,  mats = { ["Ruined Leather Scraps"] = 90 } },
  { from = 30,  to = 45,  mats = { ["Light Leather"]         = 18 } },
  { from = 45,  to = 55,  mats = { ["Light Hide"]            = 10, ["Salt"] = 10 } },
  { from = 55,  to = 85,  mats = { ["Light Leather"]         = 90, ["Coarse Thread"] = 60 } },
  { from = 85,  to = 100, mats = { ["Light Leather"]         = 90, ["Coarse Thread"] = 30 } },
  { from = 100, to = 115, mats = { ["Medium Hide"]           = 15, ["Salt"] = 15 } },
  { from = 115, to = 125, mats = { ["Medium Leather"]        = 40, ["Fine Thread"] = 20, ["Gray Dye"] = 10 } },
  { from = 125, to = 135, mats = { ["Medium Leather"]        = 48, ["Fine Thread"] = 24, ["Gray Dye"] = 12 } },
  { from = 135, to = 150, mats = { ["Cured Medium Hide"]     = 15, ["Fine Thread"] = 30, ["Gray Dye"] = 15 } },
  { from = 150, to = 155, mats = { ["Medium Leather"]        = 25 } },
  { from = 155, to = 160, mats = { ["Heavy Hide"]            = 5,  ["Salt"] = 15 } },
  { from = 160, to = 180, mats = { ["Heavy Leather"]         = 110, ["Fine Thread"] = 22 } },
  { from = 180, to = 190, mats = { ["Heavy Leather"]         = 80, ["Cured Heavy Hide"] = 10, ["Fine Thread"] = 20 } },
  { from = 190, to = 200, mats = { ["Heavy Leather"]         = 40, ["Cured Heavy Hide"] = 10, ["Silken Thread"] = 10 } },
  { from = 200, to = 220, mats = { ["Thick Leather"]         = 100, ["Silken Thread"] = 20 } },
  { from = 220, to = 230, mats = { ["Thick Leather"]         = { total = 55, unit = 5 }, ["Silken Thread"] = { total = 22, unit = 2 } } },
  { from = 230, to = 250, mats = { ["Thick Leather"]         = 280, ["Silken Thread"] = 80 } },
  { from = 250, to = 260, mats = { ["Rugged Leather"]        = 60 } },
  { from = 260, to = 290, mats = { ["Rugged Leather"]        = 256, ["Black Dye"] = 32, ["Rune Thread"] = 32 } },
  { from = 290, to = 300, mats = { ["Rugged Leather"]        = 120, ["Black Dye"] = 10, ["Rune Thread"] = 10 } },
}

D_LW.RECIPE_STEPS = {
  { from = 1,   to = 30,  name = "Light Leather",          icon = "Light Leather",          count = 30 },
  { from = 30,  to = 45,  name = "Light Armor Kit",        icon = "Light Armor Kit",        count = 18, approx = true },
  { from = 45,  to = 55,  name = "Cured Light Hide",       icon = "Light Hide",             count = 10 },
  { from = 55,  to = 85,  name = "Embossed Leather Gloves",icon = "Embossed Leather Gloves",count = 30 },
  { from = 85,  to = 100, name = "Fine Leather Belt",      icon = "Fine Leather Belt",      count = 15 },
  { from = 100, to = 115, name = "Cured Medium Hide",      icon = "Medium Hide",            count = 15 },
  { from = 115, to = 135, name = "Dark Leather Boots",     icon = "Dark Leather Boots",     count = 22, approx = true },
  { from = 135, to = 150, name = "Dark Leather Belt",      icon = "Dark Leather Belt",      count = 15 },
  { from = 150, to = 155, name = "Heavy Leather",          icon = "Heavy Leather",          count = 5 },
  { from = 155, to = 160, name = "Cured Heavy Hide",       icon = "Heavy Hide",             count = 5 },
  { from = 160, to = 180, name = "Heavy Armor Kit",        icon = "Heavy Armor Kit",        count = 22, approx = true },
  { from = 180, to = 190, name = "Barbaric Shoulders",     icon = "Barbaric Shoulders",     count = 10 },
  { from = 190, to = 200, name = "Guardian Gloves",        icon = "Guardian Gloves",        count = 10 },
  { from = 200, to = 220, name = "Thick Armor Kit",        icon = "Thick Armor Kit",        count = 20 },
  { from = 220, to = 230, name = "Nightscape Headband",    icon = "Nightscape Headband",    count = 11, approx = true },
  { from = 230, to = 250, name = "Nightscape Pants",       icon = "Nightscape Pants",       count = 20 },
  { from = 250, to = 260, name = "Rugged Armor Kit",       icon = "Rugged Armor Kit",       count = 12, approx = true },
  { from = 260, to = 290, name = "Wicked Leather Gauntlets",icon ="Wicked Leather Gauntlets",count=32, approx = true },
  { from = 290, to = 300, name = "Wicked Leather Headband",icon="Wicked Leather Headband",  count = 10 },
}

D_LW.RECIPE_SOURCES = {
  -------------------------------------------------------------------
  -- Trainable recipes (taught by specialization trainers / NPCs)
  -------------------------------------------------------------------
  trainable = {
    -- Elemental Leatherworking
    { name = "Helm of Fire",              source = "Taught by Sarah Tanner at Camp Tanner in Searing Gorge" },
    { name = "Gauntlets of the Sea",      source = "Taught by Elemental Leatherworking trainers" },

    -- Dragonscale Leatherworking
    { name = "Dragonscale Gauntlets",     source = "Taught by Dragonscale Leatherworking trainers" },
    { name = "Dragonscale Breastplate",   source = "Taught by Dragonscale Leatherworking trainers" },
    { name = "Green Dragonscale Gauntlets", source = "Taught by Dragonscale Leatherworking trainers" },
    { name = "Blue Dragonscale Leggings", source = "Taught by Dragonscale Leatherworking trainers" },

    -- Tribal Leatherworking
    { name = "Wolfshead Helm",            source = "Taught by Tribal Leatherworking trainers" },
    { name = "Feathered Breastplate",     source = "Taught by Tribal Leatherworking trainers" },
  },

  -------------------------------------------------------------------
  -- Vendor / quest recipes (patterns bought from vendors or rep)
  -------------------------------------------------------------------
  vendorquests = {
    -- Elemental Leatherworking
    { name = "Pattern: Molten Belt",          source = "Sold by Lokhtos Darkbargainer in Blackrock Depths" },
    { name = "Pattern: Molten Helm",          source = "Sold by Lokhtos Darkbargainer in Blackrock Depths" },
    { name = "Pattern: Stormshroud Pants",    source = "Sold by Leonard Porter (Western Plaguelands) and Werg Thickblade (Tirisfal Glades)" },
    { name = "Pattern: Living Shoulders",     source = "Sold by Jangdor Swiftstrider and Pratt McGrubben in Feralas" },

    -- Dragonscale Leatherworking
    { name = "Pattern: Dreamscale Breastplate",     source = "Sold by Aendel Windspear once Exalted with Cenarion Circle" },
    { name = "Pattern: Chromatic Gauntlets",        source = "Sold by Lokhtos Darkbargainer in Blackrock Depths" },
    { name = "Pattern: Black Dragonscale Boots",    source = "Sold by Lokhtos Darkbargainer in Blackrock Depths" },
    { name = "Pattern: Black Dragonscale Breastplate", source = "Sold by Plugger Spazzring in Blackrock Depths (limited supply)" },
    { name = "Pattern: Blue Dragonscale Breastplate",   source = "Sold by Blimo Gadgetspring in Winterspring" },
    { name = "Pattern: Green Dragonscale Breastplate",  source = "Sold by Masat T'andr in Feralas" },

    -- Tribal Leatherworking
    { name = "Warbear Woolies",              source = "Sold by Meilosh once Friendly with Timbermaw Hold" },
    { name = "Warbear Harness",              source = "Sold by Meilosh once Friendly with Timbermaw Hold" },
    { name = "Pattern: Corehound Belt",      source = "Sold by Lokhtos Darkbargainer in Blackrock Depths" },
    { name = "Pattern: Corehound Boots",     source = "Sold by Lokhtos Darkbargainer in Blackrock Depths" },
    { name = "Pattern: Devilsaur Gauntlets", source = "Sold by Nergal in Un'Goro Crater" },
    { name = "Pattern: Frostsaber Boots",    source = "Sold by Qia in Everlook, Winterspring" },
    { name = "Pattern: Chimeric Gloves",     source = "Sold by Blimo Gadgetspring in Azshara" },
    { name = "Pattern: Ironfeather Shoulders", source = "Sold by Gigget Zipcoil in The Hinterlands" },
  },

  -------------------------------------------------------------------
  -- World / mob / instance drops (including caches & world bosses)
  -------------------------------------------------------------------
  drops = {
    -- Elemental Leatherworking
    { name = "Pattern: Shifting Cloak",        source = "Drops from Knot Thimblejack's Cache in Dire Maul" },
    { name = "Pattern: Stormshroud Gloves",    source = "Drops from Princess Tempestria (Winterspring) and The Windreaver (Silithus)" },
    { name = "Pattern: Stormshroud Shoulders", source = "Drops from Son of Arkkoroc in Azshara" },
    { name = "Pattern: Stormshroud Armor",     source = "Drops from Arkkoran Oracle in Azshara" },
    { name = "Pattern: Living Leggings",       source = "Drops from Deadwood Shaman in Felwood" },
    { name = "Pattern: Living Breastplate",    source = "Drops from Decaying Horror in Western Plaguelands" },
    { name = "Pattern: Volcanic Leggings",     source = "Drops from Firegut Brute in Burning Steppes" },
    { name = "Pattern: Volcanic Breastplate",  source = "Drops from Firebrand Grunt in Burning Steppes" },
    { name = "Pattern: Volcanic Shoulders",    source = "Drops from Firebrand Legionnaire in Lower Blackrock Spire" },

    -- Dragonscale Leatherworking
    { name = "Pattern: Black Dragonscale Leggings",   source = "Drops from Anvilrage Captain in Blackrock Depths" },
    { name = "Pattern: Black Dragonscale Shoulders",  source = "Drops from Anvilrage Marshal in Blackrock Depths" },
    { name = "Pattern: Blue Dragonscale Shoulders",   source = "Drops from Cliff Breaker in Azshara" },
    { name = "Pattern: Red Dragonscale Breastplate",  source = "Drops from General Drakkisath in Upper Blackrock Spire" },
    { name = "Pattern: Green Dragonscale Leggings",   source = "Drops from Murk Worm in The Temple of Atal'Hakkar" },

    -- Tribal Leatherworking
    { name = "Pattern: Hide of the Wild",      source = "Drops from Knot Thimblejack's Cache in Dire Maul" },
    { name = "Pattern: Devilsaur Leggings",    source = "Drops from Primal Ooze, Cloned Ooze, Glutinous Ooze and Muculent Ooze in Un'Goro Crater" },
    { name = "Pattern: Frostsaber Tunic",      source = "Drops from Winterfall Ursa in Winterspring" },
    { name = "Pattern: Frostsaber Gloves",     source = "Drops from Winterfall Totemic in Winterspring" },
    { name = "Pattern: Frostsaber Leggings",   source = "Drops from Winterfall Den Watcher in Winterspring" },
    { name = "Pattern: Chimeric Vest",         source = "Drops from high-level mobs in various zones and instances" },
    { name = "Pattern: Chimeric Leggings",     source = "Drops from world bosses: Azuregos, Lethon, Ysondre, Emeriss, Lord Kazzak, Onyxia, Taerar" },
    { name = "Pattern: Chimeric Boots",        source = "Drops from various level 45–59 creatures (skill 275)" },
    { name = "Pattern: Ironfeather Breastplate", source = "Drops from Vilebranch Hideskinner in The Hinterlands" },
  },

  -------------------------------------------------------------------
  -- Special category (keep for consistency; can be used later)
  -------------------------------------------------------------------
  special = {
    -- Currently nothing special flagged for Leatherworking.
    -- You could move e.g. 'Pattern: Hide of the Wild' or 'Pattern: Shifting Cloak'
    -- here if you want to highlight them separately in the UI.
  },
}


BashyoCraftingGuide.Data.Register("leatherworking", D_LW)