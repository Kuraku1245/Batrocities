Batrocities = {}
Batrocities.config = SMODS.current_mod.config

-- Replication
SMODS.Atlas{
    key = 'Replication',
    path = 'ReplicationVoucher.png',
    px = 71,
    py = 95,
}
SMODS.Voucher {
    key = 'Replication',
    loc_txt = {
        name = 'Replication',
        text = {
            '{C:attention}+#1#{} voucher slot',
            'available in shop'
        }
    },
    atlas = 'Replication',
    pos = { x = 0, y = 0 },
    config = { extra = { voucher_size = 1 } },
    unlocked = true,

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.voucher_size } }
	end,

	redeem = function(self, card)
		SMODS.change_voucher_limit(card.ability.extra.voucher_size)
	end,
}

-- Mitosis
SMODS.Atlas{
    key = 'Mitosis',
    path = 'MitosisVoucher.png',
    px = 71,
    py = 95,
}
SMODS.Voucher {
    key = 'Mitosis',
    loc_txt = {
        name = 'Mitosis',
        text = {
            '{C:attention}+#1#{} voucher slot',
            'available in shop'
        }
    },
    atlas = 'Mitosis',
    pos = { x = 0, y = 0 },
    config = { extra = { voucher_size = 1 } },
    unlocked = true,
	requires = { "v_btct_Replication" },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.voucher_size } }
	end,

	redeem = function(self, card)
		SMODS.change_voucher_limit(card.ability.extra.voucher_size)
	end,
}

-- Cloning
SMODS.Atlas{
    key = 'Cloning',
    path = 'CloneVoucher.png',
    px = 71,
    py = 95,
}
SMODS.Voucher {
    key = 'Cloning',
    loc_txt = {
        name = 'Cloning',
        text = {
            --'{C:edition}freaky{}'
            '{C:attention}+#1#{} voucher slot',
            'available in shop'
        }
    },
    atlas = 'Cloning',
    pos = { x = 0, y = 0 },
    config = { extra = { voucher_size = 1 } },
    unlocked = true,
    requires = { "v_btct_Mitosis" },
    pools = { ["T3V"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.voucher_size } }
    end,

    redeem = function(self, card)
        SMODS.change_voucher_limit(card.ability.extra.voucher_size)
    end,
}

-- Unboxing
SMODS.Atlas{
    key = 'Unboxing',
    path = 'UnboxingVoucher.png',
    px = 71,
    py = 95,
}
SMODS.Voucher {
    key = 'Unboxing',
    loc_txt = {
        name = 'Unboxing',
        text = {
            '{C:attention}+#1#{} booster slot',
            'available in shop'
        }
    },
    atlas = 'Unboxing',
    pos = { x = 0, y = 0 },
    config = { extra = { booster_size = 1 } },
    unlocked = true,

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.booster_size } }
	end,

	redeem = function(self, card)
		SMODS.change_booster_limit(card.ability.extra.booster_size)
	end,
}

--[[ Reveal
SMODS.Atlas{
    key = 'Reveal',
    path = 'RevealVoucher.png',
    px = 71,
    py = 95,
}
SMODS.Voucher {
    key = 'Reveal',
    loc_txt = {
        name = 'Reveal',
        text = {
            '{C:attention}+#1#{} card in',
            'booster packs'
        }
    },
    atlas = 'Reveal',
    pos = { x = 0, y = 0 },
    config = { extra = { booster_size = 1 } },
    unlocked = true,
    requires = { "v_btct_Unboxing" },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.booster_size } }
	end,

	calculate = function(self, card, context)
        --[[if context.create_card and context.card then
            local card = context.card
            local is_booster_pack = card.ability.set == "Booster"
            if is_booster_pack and card.config.extra.booster_size then
               card.ability.extra = card.ability.extra + card.config.extra.booster_size
            end
        end--
    end,
}]]

-- Gloves
SMODS.Atlas{
    key = 'Gloves',
    path = 'GlovesVoucher.png',
    px = 71,
    py = 95,
}
SMODS.Voucher {
    key = 'Gloves',
    loc_txt = {
        name = 'Gloves',
        text = {
            'Permanently',
            'gain {C:blue}+#1#{} hand',
            'each round'
        }
    },
    atlas = 'Gloves',
    pos = { x = 0, y = 0 },
    config = { extra = { hands = 1 } },
    unlocked = true,
    requires = { 'v_nacho_tong' },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hands } }
    end,

    redeem = function(self, card)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        ease_hands_played(card.ability.extra.hands)
    end,
}

-- Landfill
SMODS.Atlas{
    key = 'Landfill',
    path = 'LandfillVoucher.png',
    px = 71,
    py = 95,
}
SMODS.Voucher {
    key = 'Landfill',
    loc_txt = {
        name = 'Landfill',
        text = {
            'Permanently',
            'gain {C:red}+#1#{} discard',
            'each round'
        }
    },
    atlas = 'Landfill',
    pos = { x = 0, y = 0 },
    config = { extra = { discards = 1 } },
    unlocked = true,
	requires = { "v_recyclomancy" },
	pools = { ["T3V"] = true },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.discards } }
	end,

	redeem = function(self, card)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
        ease_discard(card.ability.extra.discards)
    end,
}

-- Overstock Prime
SMODS.Atlas{
    key = 'OverstockPrime',
    path = 'OverstockPrimeVoucher.png',
    px = 71,
    py = 95,
}
SMODS.Voucher {
    key = 'OverstockPrime',
    loc_txt = {
        name = 'Overstock Prime',
        text = {
            '{C:attention}+#1#{} card slot',
            'available in shop'
        }
    },
    atlas = 'OverstockPrime',
    pos = { x = 0, y = 0 },
    config = { extra = { shop_size = 1 } },
    unlocked = true,
	requires = { "v_overstock_plus" },
	pools = { ["T3V"] = true },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.shop_size } }
	end,

	redeem = function(self, card)
		G.E_MANAGER:add_event(Event({
            func = function()
                change_shop_size(card.ability.extra.shop_size)
                return true
            end
        }))
	end,
}

-- Darkmatter
SMODS.Atlas{
    key = 'Darkmatter',
    path = 'DarkmatterVoucher.png',
    px = 71,
    py = 95,
}
SMODS.Voucher {
    key = 'Darkmatter',
    loc_txt = {
        name = 'Dark matter',
        text = {
            "{C:dark_edition}+#1#{} Joker Slot",
            "{C:blue}-#2#{} hand",
        }
    },
    atlas = 'Darkmatter',
    pos = { x = 0, y = 0 },
    config = { extra = { slots = 1, deduction = 1 } },
    unlocked = true,
	requires = { "v_antimatter" },
	pools = { ["T3V"] = true },

    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' and (card.config.center.discovered or card.bypass_discovery_center) then
            card.children.center:draw_shader('negative', nil, card.ARGS.send_to_shader)
            card.children.center:draw_shader('negative_shine', nil, card.ARGS.send_to_shader)
        end
    end,

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.slots, card.ability.extra.deduction } }
	end,

	redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                if G.jokers then
                    G.jokers.config.card_limit = G.jokers.config.card_limit + 1
                end
                return true
            end,
        }))
		G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.deduction
        ease_hands_played(-card.ability.extra.deduction)
	end,
}

-- TarotMonopoly
SMODS.Atlas{
    key = 'TarotMonopoly',
    path = 'TarotMonopolyVoucher.png',
    px = 71,
    py = 95,
}
SMODS.Voucher {
    key = 'TarotMonopoly',
    loc_txt = {
        name = 'Tarot Monopoly',
        text = {
            "{C:tarot}Tarot{} cards appear",
            "{C:attention}#1#X{} more frequently",
            "in the shop",
            "{C:inactive}(You can now change the{}",
            "{C:inactive}tarot rate in config){}"
        }
    },
    atlas = 'TarotMonopoly',
    pos = { x = 0, y = 0 },
    config = { extra = { rate = Batrocities.config.tarotM_rateChange, display = 6 } },
    unlocked = true,
	requires = { "v_tarot_tycoon" },
	pools = { ["T3V"] = true },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.display } }
	end,

	redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                if card.ability.extra.rate == 1 then
                    G.GAME.tarot_rate = 4 * 1
                    return true
                elseif card.ability.extra.rate == 2 then
                    G.GAME.tarot_rate = 4 * 2.4
                    return true
                elseif card.ability.extra.rate == 3 then
                    G.GAME.tarot_rate = 4 * 4.7335
                    return true
                elseif card.ability.extra.rate == 4 then
                    G.GAME.tarot_rate = 4 * 8
                    return true
                elseif card.ability.extra.rate == 5 then
                    G.GAME.tarot_rate = 4 * 12.2
                    return true
                elseif card.ability.extra.rate == 6 then
                    G.GAME.tarot_rate = 4 * 17.333
                    return true
                else
                    G.GAME.tarot_rate = G.GAME.tarot_rate
                    return true
                end
            end
        }))
    end,
}

-- PlanetMonopoly
SMODS.Atlas{
    key = 'PlanetMonopoly',
    path = 'PlanetMonopolyVoucher.png',
    px = 71,
    py = 95,
}
SMODS.Voucher {
    key = 'PlanetMonopoly',
    loc_txt = {
        name = 'Planet Monopoly',
        text = {
            "{C:planet}Planet{} cards appear",
            "{C:attention}#1#X{} more frequently",
            "in the shop",
        }
    },
    atlas = 'PlanetMonopoly',
    pos = { x = 0, y = 0 },
    config = { extra = { rate = Batrocities.config.planetM_rateChange, display = 6 } },
    unlocked = true,
	requires = { "v_planet_tycoon" },
	pools = { ["T3V"] = true },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.display } }
	end,

	redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                if card.ability.extra.rate == 1 then
                    G.GAME.planet_rate = 4 * 1
                    return true
                elseif card.ability.extra.rate == 2 then
                    G.GAME.planet_rate = 4 * 2.4
                    return true
                elseif card.ability.extra.rate == 3 then
                    G.GAME.planet_rate = 4 * 4.7335
                    return true
                elseif card.ability.extra.rate == 4 then
                    G.GAME.planet_rate = 4 * 8
                    return true
                elseif card.ability.extra.rate == 5 then
                    G.GAME.planet_rate = 4 * 12.2
                    return true
                elseif card.ability.extra.rate == 6 then
                    G.GAME.planet_rate = 4 * 17.333
                    return true
                else
                    G.GAME.planet_rate = G.GAME.planet_rate
                    return true
                end
            end
        }))
    end,
}

-- Money Beanstalk
SMODS.Atlas{
    key = 'MoneyBeanstalk',
    path = 'MoneyBeanstalkVoucher.png',
    px = 71,
    py = 95,
}

SMODS.Voucher {
    key = 'MoneyBeanstalk',
    atlas = 'MoneyBeanstalk',
    loc_txt = {
        name = 'Money Beanstalk',
        text = {
            'Raise the cap on',
            'interest earned in',
            'each round to {C:money}$30{}'
        }
    },
    config = { extra = { cap = 150 } },
    unlocked = true,
    requires = { 'v_money_tree' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cap } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.interest_cap = card.ability.extra.cap
                return true
            end
        }))
    end
}

-- Fossil
SMODS.Atlas{
    key = 'Fossil',
    path = 'FossilVoucher.png',
    px = 71,
    py = 95,
}

SMODS.Voucher {
    key = 'Fossil',
    atlas = 'Fossil',
    loc_txt = {
        name = 'Fossil',
        text = {
            '{C:attention}-#1#{} Ante,',
            '{C:attention}-#1#{} hand size',
            'each round'
        }
    },
    config = { extra = { deduction = 1 } },
    unlocked = true,
    requires = { 'v_petroglyph'},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.deduction } }
    end,
    redeem = function(self, card)
        ease_ante(-card.ability.extra.deduction)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - card.ability.extra.deduction

        G.hand:change_size(-card.ability.extra.deduction)
    end
}

-- Easel
SMODS.Atlas{
    key = 'Easel',
    path = 'EaselVoucher.png',
    px = 71,
    py = 95,
}

SMODS.Voucher {
    key = 'Easel',
    atlas = 'Easel',
    loc_txt = {
        name = 'Easel',
        text = {
            '{C:attention}+#1#{} hand size',
        }
    },
    unlocked = true,
    requires = { 'v_palette'},
    config = { extra = { size = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.size } }
    end,
    redeem = function(self, card)
        G.hand:change_size(card.ability.extra.size)
    end
}

-- GhastlyGlobe
SMODS.Atlas{
    key = 'GhastlyGlobe',
    path = 'GhastlyGlobeVoucher.png',
    px = 71,
    py = 95,
}
SMODS.Voucher {
    key = 'GhastlyGlobe',
    loc_txt = {
        name = 'Ghastly Globe',
        text = {
            '{C:spectral}Spectral{} cards can',
            'appear in shop,',
            'if spectrals can already', 
            'appear in shop, this',
            'instead {C:attention}doubles{}',
            'spectral chance'
        }
    },
    atlas = 'GhastlyGlobe',
    pos = { x = 0, y = 0 },
    config = { extra = { spectral_rate = 2 } },
    unlocked = true,
    requires = { "v_omen_globe" },
    pools = { ["T3V"] = true },

     loc_vars = function(self, info_queue, back)
        return { vars = {self.config.spectral_rate} }
    end,

    redeem = function(self, card)
        if G.GAME.spectral_rate > 0 then
        G.GAME.spectral_rate = G.GAME.spectral_rate * 2
        else
        G.GAME.spectral_rate = 2
        end
    end,
}

-- Superstar
SMODS.Atlas{
   key = 'Superstar',
   path = 'SuperstarVoucher.png',
   px = 71,
   py = 95,
}
SMODS.Voucher {
   key = 'Superstar',
   loc_txt = {
       name = 'Superstar',
       text = {
           '{C:dark_edition}Foil{}, {C:dark_edition}Holographic{}, and',
           '{C:dark_edition}Polychrome{} cards',
           'appear {C:attention}#1#X{} more often'
       }
   },
   atlas = 'Superstar',
   pos = { x = 0, y = 0 },
   config = { extra = { rate = 8 } },
   unlocked = false,
   requires = { 'v_glow_up' },
   loc_vars = function(self, info_queue, card)
       return { vars = { card.ability.extra.rate } }
   end,
   redeem = function(self, card)
       G.E_MANAGER:add_event(Event({
           func = function()
               G.GAME.edition_rate = card.ability.extra.rate
               return true
           end
       }))
   end
}


--Scattered Deck
SMODS.Atlas{
    key = 'DScattered',
    path = 'ScatteredDeck.png',
    px = 71,
    py = 95,
}

SMODS.Back({
    key = "DScattered",
    loc_txt = {
        name = "Scattered Deck",
        text={
            "Randomly enhance {C:attention}3{} random ranks"
        },
    },
    
    pos = { x = 0, y = 0 },
    order = 1,
    atlas = "DScattered",
    unlocked = true,
})