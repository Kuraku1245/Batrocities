--[[ Geo Tag 
SMODS.Atlas{
    key = 'GeoTagSatlas',
    path = 'GeoTag.png',
    px = 32,
    py = 32,
}

SMODS.Tag {
    key = "GeoTagS",
    loc_txt= {
        name = 'Geometric Tag',
        text = { "Gives a free",
                "{C:attention}Geometric Pack{}", }},
    atlas = 'GeoTagSatlas',
    pos = { x = 0, y = 0 },
    min_ante = 1,

    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_btct_booster_SGeo_1
    end,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.SECONDARY_SET.Spectral, function()
                local booster = SMODS.create_card { key = 'p_btct_booster_SGeo', area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

-- Jumbo Geo Tag 
SMODS.Atlas{
    key = 'GeoTagDatlas',
    path = 'JumboGeoTag.png',
    px = 32,
    py = 32,
}

SMODS.Tag {
    key = "GeoTagDJumbo",
    loc_txt= {
        name = 'Jumbo Geometric Tag',
        text = { "Gives a free",
                "{C:attention}Jumbo Geometric Pack{}", }},
    atlas = 'GeoTagDatlas',
    pos = { x = 0, y = 0 },
    min_ante = 2,

    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_btct_booster_DGeoJumbo_1
    end,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.SECONDARY_SET.Spectral, function()
                local booster = SMODS.create_card { key = 'p_btct_booster_DGeoJumbo', area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

-- Mega Geo Tag 
SMODS.Atlas{
    key = 'GeoTagCatlas',
    path = 'MegaGeoTag.png',
    px = 32,
    py = 32,
}

SMODS.Tag {
    key = "GeoTagCMega",
    loc_txt= {
        name = 'Mega Geometric Tag',
        text = { "Gives a free",
                "{C:attention}Mega Geometric Pack{}", }},
    atlas = 'GeoTagCatlas',
    pos = { x = 0, y = 0 },
    min_ante = 3,

    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_btct_booster_CGeoMega_1
    end,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.SECONDARY_SET.Spectral, function()
                local booster = SMODS.create_card { key = 'p_btct_booster_CGeoMega', area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

-- Jumbo Btct tag
SMODS.Atlas{
   key = 'BtctTagatlas',
   path = 'EvilandTwisted2006ChevySilveradoTag.png',
   px = 32,
   py = 32,
}


SMODS.Tag {
   key = "BtctTagatlas",
   loc_txt= {
       name = 'Jumbo Batrocities Tag',
       text = { "Gives a free",
               "{C:attention}Jumbo Batrocities Pack{}", }},
   atlas = 'BtctTagatlas',
   pos = { x = 0, y = 0 },
   min_ante = 2,


   loc_vars = function(self, info_queue, tag)
       info_queue[#info_queue + 1] = G.P_CENTERS.p_btct_booster_EvilAndTwisted2006ChevySilveradoBTCT_1
   end,
   apply = function(self, tag, context)
       if context.type == 'new_blind_choice' then
           local lock = tag.ID
           G.CONTROLLER.locks[lock] = true
           tag:yep('+', G.C.SECONDARY_SET.Spectral, function()
               local booster = SMODS.create_card { key = 'p_btct_booster_EvilAndTwisted2006ChevySilveradoBTCT', area = G.play }
               booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
               booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
               booster.T.w = G.CARD_W * 1.27
               booster.T.h = G.CARD_H * 1.27
               booster.cost = 0
               booster.from_tag = true
               G.FUNCS.use_card({ config = { ref_table = booster } })
               booster:start_materialize()
               G.CONTROLLER.locks[lock] = nil
               return true
           end)
           tag.triggered = true
           return true
       end
   end
}]]--

-- Gemstone tag
SMODS.Atlas{
    key = 'GemTagatlas',
    path = 'GemstoneTag.png',
    px = 32,
    py = 32,
}

SMODS.Tag {
    key = "GemTag",
    loc_txt= {
        name = 'Gemstone Tag',
        text = { "Next base edition shop",
                "Joker is free and",
                "becomes {C:dark_edition}Gemstone{}" }},
    atlas = 'GemTagatlas',
    pos = { x = 0, y = 0 },
    min_ante = 1,
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_btct_gemstone
    end,
    apply = function(self, tag, context)
        if context.type == 'store_joker_modify' then
            if not context.card.edition and not context.card.temp_edition and context.card.ability.set == 'Joker' then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true
                context.card.temp_edition = true
                tag:yep('+', G.C.DARK_EDITION, function()
                    context.card.temp_edition = nil
                    context.card:set_edition("e_btct_gemstone", true)
                    context.card.ability.couponed = true
                    context.card:set_cost()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                tag.triggered = true
                return true
            end
        end
    end,
    in_pool = function(self, args)
        return G.P_CENTERS["e_btct_gemstone"].discovered
    end
}

--[[ Antique tag
SMODS.Atlas{
    key = 'OldTagatlas',
    path = 'AntiqueTag.png',
    px = 32,
    py = 32,
}

SMODS.Tag {
    key = "OldTag",
    loc_txt= {
        name = 'Antique Tag',
        text = { "Next base edition shop",
                "Joker is free and",
                "becomes {C:dark_edition}Antique{}" }},
    atlas = 'OldTagatlas',
    pos = { x = 0, y = 0 },
    min_ante = 1,
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_btct_antique
    end,
    apply = function(self, tag, context)
        if context.type == 'store_joker_modify' then
            if not context.card.edition and not context.card.temp_edition and context.card.ability.set == 'Joker' then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true
                context.card.temp_edition = true
                tag:yep('+', G.C.DARK_EDITION, function()
                    context.card.temp_edition = nil
                    context.card:set_edition("e_btct_antique", true)
                    context.card.ability.couponed = true
                    context.card:set_cost()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                tag.triggered = true
                return true
            end
        end
    end,
    in_pool = function(self, args)
        return G.P_CENTERS["e_btct_antique"].discovered
    end
}]]--