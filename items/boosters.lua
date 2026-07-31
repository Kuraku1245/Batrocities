--[[ ShapePack

-- NormalSkwobShape
SMODS.Atlas{
    key = 'GeoPackSkwob',
    path = 'GeoPackSkwob.png',
    px = 71,
    py = 95,
}

SMODS.Booster{
    key = 'booster_SGeo',
    group_key = "k_shape_booster_group",
    atlas = 'GeoPackSkwob', 
    pos = { x = 0, y = 0 },
    discovered = true,
    
    draw_hand = false,
    config = {
        extra = 2,
        choose = 1, 
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,

    weight = 0.6,
    cost = 4,
    kind = "ShapePack",
    
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("cc3b49"))
        ease_background_colour({ new_colour = HEX("cc3b49"), special_colour = G.C.RED, contrast = 2 })
    end,

    create_card = function(self, card, i)
        local key = pseudorandom_element(G.P_CENTER_POOLS.Shape, 'booster_SGeo').key
        return { area = G.pack_cards, skip_materialize = true, soulable = false, key_append = "btct_ShapePack", key = key }
    end,

    in_pool = function() return true end
}

-- NormalTimShape
SMODS.Atlas{
    key = 'GeoPackTim',
    path = 'GeoPackTim.png',
    px = 71,
    py = 95,
}

SMODS.Booster{
    key = 'booster_TGeo',
    group_key = "k_shape_booster_group",
    atlas = 'GeoPackTim', 
    pos = { x = 0, y = 0 },
    discovered = true,
    
    draw_hand = false,
    config = {
        extra = 2,
        choose = 1, 
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,

    weight = 0.6,
    cost = 4,
    kind = "ShapePack",
    
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("1d6e2f"))
        ease_background_colour({ new_colour = HEX("1d6e2f"), special_colour = G.C.GREEN, contrast = 2 })
    end,

    create_card = function(self, card, i)
        local key = pseudorandom_element(G.P_CENTER_POOLS.Shape, 'booster_TGeo').key
        return { area = G.pack_cards, skip_materialize = true, soulable = false, key_append = "btct_ShapePack", key = key }
    end,

    in_pool = function() return true end
}

-- JumboDaveShape
SMODS.Atlas{
    key = 'JumboGeoPackDave',
    path = 'JumboGeoPackDave.png',
    px = 71,
    py = 95,
}

SMODS.Booster{
    key = 'booster_DGeoJumbo',
    group_key = "k_shape_booster_group",
    atlas = 'JumboGeoPackDave', 
    pos = { x = 0, y = 0 },
    discovered = true,
    
    draw_hand = false,
    config = {
        extra = 3,
        choose = 1, 
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,

    weight = 0.3,
    cost = 6,
    kind = "ShapePack",
    
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("001da7"))
        ease_background_colour({ new_colour = HEX("001da7"), special_colour = G.C.BLUE, contrast = 2 })
    end,

    create_card = function(self, card, i)
        local key = pseudorandom_element(G.P_CENTER_POOLS.Shape, 'booster_DGeoJumbo').key
        return { area = G.pack_cards, skip_materialize = true, soulable = false, key_append = "btct_ShapePack", key = key }
    end,

    in_pool = function() return true end
}

-- MegaCraigShape
SMODS.Atlas{
    key = 'MegaGeoPackCraig',
    path = 'MegaGeoPackCraig.png',
    px = 71,
    py = 95,
}

SMODS.Booster{
    key = 'booster_CGeoMega',
    group_key = "k_shape_booster_group",
    atlas = 'MegaGeoPackCraig', 
    pos = { x = 0, y = 0 },
    discovered = true,
    
    draw_hand = false,
    config = {
        extra = 3,
        choose = 2, 
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,

    weight = 0.07,
    cost = 8,
    kind = "ShapePack",
    
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("f9f057"))
        ease_background_colour({ new_colour = HEX("f9f057"), special_colour = G.C.YELLOW, contrast = 2 })
    end,

    create_card = function(self, card, i)
        local key = pseudorandom_element(G.P_CENTER_POOLS.Shape, 'booster_CGeoMega').key
        return { area = G.pack_cards, skip_materialize = true, soulable = false, key_append = "btct_ShapePack", key = key }
    end,

    in_pool = function() return true end
}

-- BatrocityPack

-- NormalBlurpinyPack
SMODS.Atlas{
    key = 'BTCTPackBlurpiny',
    path = 'BTCTPackBlurpiny.png',
    px = 71,
    py = 95,
}

SMODS.Booster{
    key = 'booster_BBTCT',
    group_key = "k_btct_booster_group",
    atlas = 'BTCTPackBlurpiny', 
    pos = { x = 0, y = 0 },
    discovered = true,
    
    draw_hand = false,
    config = {
        extra = 2,
        choose = 1, 
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,

    weight = 0.9,
    cost = 4,
    kind = "BTCTPack",
    
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("2a61eb"))
        ease_background_colour({ new_colour = HEX("2a61eb"), special_colour = G.C.BLUE, contrast = 2 })
    end,

    create_card = function(self, card, i)
        local key = pseudorandom_element(G.P_CENTER_POOLS.Batrocities, 'booster_BBTCT').key
        return { area = G.pack_cards, skip_materialize = true, soulable = false, key_append = "btct_ShapePack", key = key }
    end,

    in_pool = function() return true end
}

-- NormalGabbaPack
SMODS.Atlas{
    key = 'BTCTPackGabba',
    path = 'BTCTPackGabba.png',
    px = 71,
    py = 95,
}

SMODS.Booster{
    key = 'booster_GBTCT',
    group_key = "k_btct_booster_group",
    atlas = 'BTCTPackGabba', 
    pos = { x = 0, y = 0 },
    discovered = true,
    
    draw_hand = false,
    config = {
        extra = 2,
        choose = 1, 
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,

    weight = 0.9,
    cost = 4,
    kind = "BTCTPack",
    
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("000000"))
        ease_background_colour({ new_colour = HEX("000000"), special_colour = G.C.WHITE, contrast = 2 })
    end,

    create_card = function(self, card, i)
        local key = pseudorandom_element(G.P_CENTER_POOLS.Batrocities, 'booster_GBTCT').key
        return { area = G.pack_cards, skip_materialize = true, soulable = false, key_append = "btct_ShapePack", key = key }
    end,

    in_pool = function() return true end
}

-- JumboEvilAndTwisted2006ChevySilveradoPack
SMODS.Atlas{
    key = 'BTCTPackEvilAndTwisted2006ChevySilverado',
    path = 'JumboBTCTPackEvilAndTwisted2006ChevySilverado.png',
    px = 71,
    py = 95,
}

SMODS.Booster{
    key = 'booster_EvilAndTwisted2006ChevySilveradoBTCT',
    group_key = "k_btct_booster_group",
    atlas = 'BTCTPackEvilAndTwisted2006ChevySilverado', 
    pos = { x = 0, y = 0 },
    discovered = true,
    
    draw_hand = false,
    config = {
        extra = 4,
        choose = 1, 
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,

    weight = 0.45,
    cost = 6,
    kind = "BTCTPack",
    
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("14334d"))
        ease_background_colour({ new_colour = HEX("14334d"), special_colour = G.C.BLACK , contrast = 2 })
    end,

    create_card = function(self, card, i)
        local key = pseudorandom_element(G.P_CENTER_POOLS.Batrocities, 'booster_EvilAndTwisted2006ChevySilveradoBTCT').key
        return { area = G.pack_cards, skip_materialize = true, soulable = false, key_append = "btct_ShapePack", key = key }
    end,

    in_pool = function() return true end
}

-- MegaCheesemanPack
SMODS.Atlas{
    key = 'BTCTPackCheese',
    path = 'MegaBTCTPackCheese.png',
    px = 71,
    py = 95,
}

SMODS.Booster{
    key = 'booster_CBTCT',
    group_key = "k_btct_booster_group",
    atlas = 'BTCTPackCheese', 
    pos = { x = 0, y = 0 },
    discovered = true,
    
    draw_hand = false,
    config = {
        extra = 4,
        choose = 2, 
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,

    weight = 0.1,
    cost = 8,
    kind = "BTCTPack",
    
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("a85c28"))
        ease_background_colour({ new_colour = HEX("a85c28"), special_colour = G.C.YELLOW , contrast = 2 })
    end,

    create_card = function(self, card, i)
        local key = pseudorandom_element(G.P_CENTER_POOLS.Batrocities, 'booster_CBTCT').key
        return { area = G.pack_cards, skip_materialize = true, soulable = false, key_append = "btct_ShapePack", key = key }
    end,

    in_pool = function() return true end
}]]--