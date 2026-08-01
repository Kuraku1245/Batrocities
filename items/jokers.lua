--- STEAMODDED HEADER
--- MOD_NAME: Batrocities
--- MOD_ID: Batrocities
--- MOD_AUTHOR: People?
--- MOD_DESCRIPTION: Inside joke mod for friends 
--- PREFIX: Batrocities
----------------------------------------------------------
----------- MOD CODE -------------------------------------

-- CheeseMan
--[[SMODS.Atlas{
    key = 'CheeseMan',
    path = 'CheeseMan.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'CheeseMan',
    loc_txt = {
        name = 'Cheese Man',
        text = {
            'For each {C:attention}Joker{} sold or destroyed,',
            'this Joker gains {X:mult,C:white}X#3#{} Mult.',
            'Selling {C:attention}Jokers{} gives no money.',
            '{C:inactive}(Currently {X:mult,C:white}X#2#{} Mult){}'
        }
    },
    atlas = 'CheeseMan',
    pools = {["Batrocities"] = true},

    rarity = 4,
    cost = 20,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {xmult_base = 1, xmult = 1, xmult_gain = 0.25}},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_base, card.ability.extra.xmult, card.ability.extra.xmult_gain } }
    end,

    calculate = function(self, card, context)
        if context.selling_card or context.destroy_card then 
            card.ability.extra.xmult = card.ability.extra.xmult+card.ability.extra.xmult_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED
            }
        elseif context.joker_main then 
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}]]

-- Blurpiny
SMODS.Atlas{
    key = 'Blurpiny',
    path = 'Blurpiny.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Blurpiny',
    loc_txt = {
        name = 'Blurpiny',
        text = {
            'Copies ability of ',
            '{C:attention}Joker{} to the left'
        }
    },
    atlas = 'Blurpiny',
    pools = {["Batrocities"] = true},

    rarity = 3,
    cost = 9,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i - 1] end
            end
            local compatible = other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            return { main_end = main_end }
        end
    end,
    calculate = function(self, card, context)
        local other_joker = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i - 1] end
        end
        return SMODS.blueprint_effect(card, other_joker, context)
    end
}

-- NotFunny
--[[SMODS.Atlas{
    key = 'NotFunny',
    path = 'NotFunny.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'NotFunny',
    loc_txt = {
        name = 'Not Funny',
        text = {
            'Flushes can be played with one',
            'card being a different suit'
        }
    },
    atlas = 'NotFunny',
    pools = {["Batrocities"] = true},
    
    rarity = 1,
    cost = 3,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

}]]

-- MessyCanvas
SMODS.Atlas{
    key = 'MessyCanvas',
    path = 'MessyCanvas.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'MessyCanvas',
    loc_txt = {
        name = 'Messy Canvas',
        text = {
            'Scored cards give {C:mult}+#1#{} mult',
            'per different {C:attention}suit{} scored.'
        }
    },
    atlas = 'MessyCanvas',
    pools = {["Batrocities"] = true},
    
    rarity = 1,
    cost = 5,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { mult_gain = 1, mult = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_gain }}
    end,

    calculate = function(self, card, context)
        local suits = {}
        if context.before then 
            for k, v in pairs(context.scoring_hand) do
                suits[v.base.suit] = true
            end
            for k, v in pairs(suits) do
                card.ability.extra.mult = card.ability.extra.mult + 1
            end
        end
        if context.individual and context.cardarea == G.play then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.after then 
            card.ability.extra.mult = 0
        end
    end
}

--LookWhatIFound
--[[SMODS.Atlas{
    key = 'LookWhatIFound',
    path = 'LookWhatIFound.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'LookWhatIFound',
    loc_txt = {
        name = 'Look What I Found!',
        text = {
            '{C:green}#1# in #4#{} chance to generate', 
            'a {C:spectral}Spectral{} card when opening a booster pack.'
        }
    },
    atlas = 'LookWhatIFound',
    pools = {["Batrocities"] = true},
    
    rarity = 3,
    cost = 7,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

}]]

--DiscountMachine
SMODS.Atlas{
    key = 'DiscountMachine',
    path = 'DiscountMachine.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'DiscountMachine',
    loc_txt = {
        name = 'Discount Machine',
        text = {
            'Prices are {C:attention}#1#% cheaper{}.',
            '{C:inactive}Thanks new technology.{}'
        }
    },
    atlas = 'DiscountMachine',
    pools = {["Batrocities"] = true},

    rarity = 2,
    cost = 6,
    pos = {x = 0, y = 0},
	pixel_size = { w = 52, h = 37 },
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { percent = 25 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.percent }}
    end,

    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.discount_percent = G.GAME.discount_percent + card.ability.extra.percent
                for _, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.discount_percent = G.GAME.discount_percent - card.ability.extra.percent
                for _, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end
}

--GabbaGhoul
SMODS.Atlas{
    key = 'GabbaGhoul',
    path = 'GabbaGhoul.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'GabbaGhoul',
    loc_txt = {
        name = 'Gabba Ghoul',
        text = {
            '{C:blue}+50{} Chips per {C:spectral}Spectral{}',
            'card used this run.',
            '{C:inactive}(Currently {C:blue}+#1#{C:inactive} Chips)'
        }
    },
    atlas = 'GabbaGhoul',
    pools = {["Batrocities"] = true},

    rarity = 1,
    cost = 5,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {chips = 0}},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips + ((G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral or 0)*50)}}
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "Spectral" then
            return {
                message = "+".. 50
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips +
                    ((G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral or 0)*50)
            }
        end
    end,
}

--EvilAndTwisted2006ChevySilverado(We promised to make everything referencing this say the full name)
SMODS.Atlas{
    key = 'EvilAndTwisted2006ChevySilverado',
    path = 'EvilAndTwisted2006ChevySilverado.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'EvilAndTwisted2006ChevySilverado',
    loc_txt = {
        name = 'Evil And Twisted 2006 Chevy Silverado',
        text = {
            'Quintuples the chance for {C:dark_edition}Negative{} Jokers',
            '{C:inactive}(It stacks){}'
        }
    },
    atlas = 'EvilAndTwisted2006ChevySilverado',
    pools = {["Batrocities"] = true},

    rarity = 2,
    cost = 8,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { rate = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.rate } }
    end,
}

--NetValue
--[[SMODS.Atlas{
    key = 'NetValue',
    path = 'NetValue.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'NetValue',
    loc_txt = {
        name = 'Net Value',
        text = {
            '{X:red,C:white}+0.5x{} Mult per each {C:money}$75{} earned this run.',
            '{C:inactive}(Currently {X:red,C:white}X1{C:inactive}, total {C:money}$nuhuh)'
        }
    },
    atlas = 'NetValue',
    pools = {["Batrocities"] = true},

    rarity = 3,
    cost = 9,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

}]]

--OrbOfEmptiness
SMODS.Atlas{
    key = 'OrbOfEmptiness',
    path = 'OrbOfEmptiness.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'OrbOfEmptiness',
    loc_txt = {
        name = 'Orb Of Emptiness',
        text = {
            'Gains {X:mult,C:white}X#1#{} Mult per unused consumable slot.', 
            '{C:inactive}(Currently {X:red,C:white}X#2#{C:inactive})'
        }
    },
    atlas = 'OrbOfEmptiness',
    pools = {["Batrocities"] = true},

    rarity = 2,
    cost = 6,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {xmult = 0.75}},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, G.consumeables and math.max(1, (((G.consumeables.config.card_limit - #G.consumeables.cards)*0.75)+1) + #SMODS.find_card("OrbOfEmptiness", true)) or 1 } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = math.max(1, 
                ((G.consumeables.config.card_limit - #G.consumeables.cards)*card.ability.extra.xmult)+1)
            }
        end
    end
}

--NaturesTouch
SMODS.Atlas{
    key = 'NaturesTouch',
    path = 'NaturesTouch.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'NaturesTouch',
    loc_txt = {
        name = 'Natures Touch',
        text = {
            'Generates a {C:dark_edition}Negative{} lovers at ',
            'the start of round. {C:spades}W{}{C:hearts}i{}{C:clubs}l{}{C:diamonds}d{} cards ', 
            ' cannot be debuffed by suit blinds.',
            'Scored {C:spades}w{}{C:hearts}i{}{C:clubs}l{}{C:diamonds}d{} cards give {X:red,C:white}X#1#{} ',
            'Mult when scored.'
        }
    },
    atlas = 'NaturesTouch',
    pools = {["Batrocities"] = true},

    rarity = 4,
    cost = 20,
    pos = {x=0, y=0},
    soul_pos = { x = 1, y = 0 },
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { xmult = 1.5 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'btct_artcreditDoneInOne', set = 'Other'}
		return { vars = { card.ability.extra.xmult, localize('m_wild') } }
	end,
    
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.other_card.debuff then
            if SMODS.has_enhancement(context.other_card, 'm_wild') then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
        if context.setting_blind then
            SMODS.add_card{key = 'c_lovers', edition = 'e_negative'}
        end
	end

}

--LilLad
SMODS.Atlas{
    key = 'LilLad',
    path = 'LilLad.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'LilLad',
    loc_txt = {
        name = 'Lil Lad',
        text = {
            'Gains {X:red,C:white}#1#x{} Mult if', 
            'poker hand is a High Card.',
            '{C:inactive}(Currently {X:red,C:white}X#3#{C:inactive})'
        }
    },
    atlas = 'LilLad',
    pools = {["Batrocities"] = true},

    rarity = 2,
    cost = 6,
    pos = {x=0, y=0},
	pixel_size = { w = 21, h = 26 },
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { xmult_gain = 0.05, xmult = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_gain, localize('High Card'), card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == "High Card" then
            if not context.blueprint then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED
            }
        end
    end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end

}
--Skwob
SMODS.Atlas{
    key = 'Skwob',
    path = 'Skwob.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Skwob',
    loc_txt = {
        name = 'Skwob',
        text = {
            '{C:chips}+#5#{} Chips, {C:mult}+#6#{} Mult.',
            'Add {C:chips}+#4#{} Chips and {C:mult}+#2#{} Mult by the',
            'amount of {C:attention}Shape{} Jokers owned.',
            '{C:inactive}(Currently {C:chips}+#3#{}{C:inactive} Chips, {C:mult}+#1#{}{C:inactive} Mult)'
        }
    },
    atlas = 'Skwob',
    pools = { ["Shape"] = true, ["Batrocities"] = true },
    
    rarity = 1,
    cost = 4,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {mult = 3, mult_gain = 2, chips = 30, chips_gain = 20, chips_base = 30, mult_base = 3}},

    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.mult, center.ability.extra.mult_gain,center.ability.extra.chips, center.ability.extra.chips_gain, center.ability.extra.chips_base, center.ability.extra.mult_base}  }
	end,

    calculate = function(self, card, context)
    shapecount = 0
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Shape then
            shapecount = shapecount + 1
        end
    end
    card.ability.extra.chips = ((shapecount-1) * card.ability.extra.chips_gain) + card.ability.extra.chips_base
    card.ability.extra.mult = ((shapecount-1) * card.ability.extra.mult_gain) + card.ability.extra.mult_base
    if context.joker_main then
        return {
            chips = card.ability.extra.chips,
            mult = card.ability.extra.mult
        }
    end
end,
}

-- Tim
SMODS.Atlas{
    key = 'Tim',
    path = 'Tim.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Tim',
    loc_txt = {
        name = 'Tim',
        text = {
            '{X:red,C:white}X1.5{} Mult if 2 or less {C:blue}hands{} remain.', 
            '{C:attention}Always{} active against boss blinds.',
            '{C:attention}+{}{X:red,C:white}X0.1{} Mult per {C:attention}Shape{} Joker',
            '{C:inactive}(Currently {X:red,C:white}X#1#{}{C:inactive} Mult)'
        }
    },
    atlas = 'Tim',
    pools = { ["Shape"] = true, ["Batrocities"] = true },

    rarity = 1,
    cost = 5,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {xmult = 1.5, xmult_gain = 1}},

    loc_vars = function(self, info_queue, center)
        return { vars = {center.ability.extra.xmult, center.ability.extra.xmult_gain}}
    end,

    calculate = function(self, card, context)
    local shapecount = 0
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Shape then
            shapecount = shapecount + 1
        end
    end
    card.ability.extra.xmult = (((shapecount * card.ability.extra.xmult_gain)/10)+1.5)
    if context.joker_main then
        if G.GAME.current_round.hands_left <= 2 or (G.GAME.blind:get_type() == 'Boss') then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
end,
}

--E
SMODS.Atlas{
    key = 'E',
    path = 'E.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'E',
    loc_txt = {
        name = 'E',
        text = {
            '{X:red,C:white}X1{} Mult, Conjures a random',
            ' {C:attention}consumable{} when blind is selected.',
             'Gains {X:red,C:white}X#2#{} Mult per other {C:attention}Shape{} Joker.',
             '{C:inactive}(Currently {X:red,C:white}X#1#{}{C:inactive} Mult){}'
        }
    },
    atlas = 'E',
    pools = { ["Shape"] = true, ["Batrocities"] = true },

    rarity = 3,
    cost = 9,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = {xmult = 1, xmult_gain = 1.5}},

    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.xmult, (center.ability.extra.xmult_gain/10)}  }
	end,

    calculate = function(self, card, context)
        local shapecount = 0
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Shape then
            shapecount = shapecount + 1
        end
    end
    if context.joker_main then
        card.ability.extra.xmult = (((shapecount * card.ability.extra.xmult_gain)/10)+1)
        return {
        xmult = card.ability.extra.xmult
        }
    elseif context.setting_blind then
        local shapecount = 0
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Shape then
            shapecount = shapecount + 1
        end
    end
    local e_real = math.random(1,10) -- randomizer for consumeable
        if e_real <= 4 and ((#G.consumeables.cards + G.GAME.consumeable_buffer) < G.consumeables.config.card_limit) then
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {
                            set = 'Planet',
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
        }))
        elseif e_real > 4 and e_real <= 8 and ((#G.consumeables.cards + G.GAME.consumeable_buffer) < G.consumeables.config.card_limit) then -- theres a little "<=8" (not on purpose)
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {
                            set = 'Tarot',
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
        }))
        elseif e_real > 8 and e_real <= 10 and ((#G.consumeables.cards + G.GAME.consumeable_buffer) < G.consumeables.config.card_limit) then
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {
                            set = 'Spectral',
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
        }))
    end
end
end
}

--Bob
SMODS.Atlas{
    key = 'Bob',
    path = 'Bob.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Bob',
    loc_txt = {
        name = 'Bob',
        text = {
            'Earn {C:money}$2{} at end of round,', 
            'Increase by {C:money}$1{} per {C:attention}Shape{} Joker.',
            '(Bob included)',
            '{C:inactive}(Currently {C:money}$#1#{C:inactive})'
        }
    },
    atlas = 'Bob',
    pools = { ["Shape"] = true, ["Batrocities"] = true },

    rarity = 1,
    cost = 6,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { dollars = 2, dollars_gain = 1} },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.dollars_gain } }
    end,

    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end,

    calculate = function(self, card, context)
    shapecount = 0
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Shape then
            shapecount = shapecount + 1
        end
    end
    card.ability.extra.dollars = ((shapecount*card.ability.extra.dollars_gain)+2)
end,
}


--Dave
SMODS.Atlas{
    key = 'Dave',
    path = 'Dave.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Dave',
    loc_txt = {
        name = 'Dave',
        text = {
            '{C:mult}+#1#{} Mult and {C:money}$#3#{} at the end of round.',
            'Gains {C:mult}+#2#{} Mult and {C:money}$#4#{} when a blind is skipped.',
            '{C:inactive}(Currently {C:red}+#5#{}{C:inactive} Mult and {C:money}$#6#{}{C:inactive}){}'
        }
    },
    atlas = 'Dave',
    pools = { ["Shape"] = true, ["Batrocities"] = true },

    rarity = 2,
    cost = 6,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
     config = { extra = { base_mult = 8, mult_gain = 4, current_mult = 8, base_dollars = 1, dollars_gain = 1, current_dollars = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.base_mult, card.ability.extra.mult_gain, card.ability.extra.base_dollars, card.ability.extra.dollars_gain, card.ability.extra.current_mult, card.ability.extra.current_dollars} }
    end,

    calc_dollar_bonus = function(self, card)
        return card.ability.extra.current_dollars
    end,

    calculate = function(self, card, context)
        if context.skip_blind and not context.blueprint then
            card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.mult_gain
            card.ability.extra.current_dollars = card.ability.extra.current_dollars + card.ability.extra.dollars_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.current_mult
            }
        end
    end
}

--Birght
SMODS.Atlas{
    key = 'Birght',
    path = 'Birght.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Birght',
    loc_txt = {
        name = 'Birght',
        text = {
            'If round is won with a hand', 
            '{C:attention}equal to or larger{} than the',
            ' blind, each {C:attention}Shape{} Joker gives {C:money}$#1#{}'
        }
    },
    atlas = 'Birght',
    pools = { ["Shape"] = true, ["Batrocities"] = true },


    rarity = 2,
    cost = 7,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {dollars = 2} },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars  } }
    end,
    
    calculate = function(self, card, context)
        shapecount = 0
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Shape then
                shapecount = shapecount + 1
            end
        end
        if context.after then
            local scored_chips = to_big(hand_chips or 0) * to_big(mult or 0)
            local blind_chips = to_big(G.GAME.blind.chips or 0)
            if scored_chips > blind_chips then
                return {
                    dollars = (shapecount*card.ability.extra.dollars)
                }
            end
        end
    end,
}

--Craig
SMODS.Atlas{
    key = 'Craig',
    path = 'Craig.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Craig',
    loc_txt = {
        name = 'Craig',
        text = {
            '{C:attention}Craig{} is {C:attention}Craig{}'
        }
    },
    atlas = 'Craig',
    pools = { ["Shape"] = true, ["Batrocities"] = true },

    rarity = 1,
    cost = 5,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {xmult = 1, min = 5, max = 20, tempxmult = 0}},

    loc_vars = function(self, info_queue, center)
        local shape_count = 0
        if G.jokers and G.jokers.cards then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Shape then
                    shape_count = shape_count + 1
                end
            end
        end
        info_queue[#info_queue+1] = {key = 'btct_craig', set = 'Other', vars = {center.ability.extra.xmult, ((center.ability.extra.min + shape_count)/10), center.ability.extra.max, center.ability.extra.tempxmult}}
        return { vars = {center.ability.extra.xmult, ((center.ability.extra.min + shape_count)/10), center.ability.extra.max, center.ability.extra.tempxmult}  }
    end,

    calculate = function(self, card, context)
    if context.setting_blind then
      local shapecount = 0
      for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Shape then
            shapecount = shapecount + 1
        end
            card.ability.extra.tempxmult = (pseudorandom("Craig", (card.ability.extra.min + shapecount), card.ability.extra.max)/10)
            card.ability.extra.xmult = card.ability.extra.tempxmult
    end
    elseif context.joker_main then 
        return {
            xmult = card.ability.extra.xmult
        }
    end
end,
}

--[[Craig
SMODS.Atlas{
    key = 'Craig',
    path = 'Craig.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Craig',
    loc_txt = {
        name = 'Craig',
        text = {
            '{C:attention}Craig{} is {C:attention}Craig{}'
        }
    },
    atlas = 'Craig',
    pools = { ["Shape"] = true, ["Batrocities"] = true },

    rarity = 1,
    cost = 5,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {xmult = 1, min = 50, max = 200, tempxmult = 0, }},

    loc_vars = function(self, info_queue, center)
        local shape_count = 0
        if G.jokers and G.jokers.cards then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Shape then
                    shape_count = shape_count + 10
                end
            end
        end
        info_queue[#info_queue+1] = {key = 'btct_craig', set = 'Other', vars = {center.ability.extra.xmult, ((center.ability.extra.min - shape_count)/50), ((center.ability.extra.max + shape_count)/100), center.ability.extra.tempxmult}}
        return { vars = {center.ability.extra.xmult, ((center.ability.extra.min - shape_count)/50), ((center.ability.extra.max + shape_count)/100), center.ability.extra.tempxmult}  }
    end,

    calculate = function(self, card, context)
    if context.setting_blind then
      local shapecount = 0
      for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Shape then
            shapecount = shapecount + 10
        end
        local minimumcheck = (card.ability.extra.min - shapecount)/50
        if minimumcheck < 0.1 then
            minimumcheck = 0.1
        end
        card.ability.extra.tempxmult = (pseudorandom("Craig", minimumcheck, (card.ability.extra.max + shapecount)/100))
        card.ability.extra.xmult = card.ability.extra.tempxmult
    end
    elseif context.joker_main then 
        return {
            xmult = card.ability.extra.xmult
        }
    end
end,
}]]

--Twinkle
SMODS.Atlas{
    key = 'Twinkle',
    path = 'Twinkle.png',
    px = 71,
    py = 95
}

SMODS.Joker {
	key = 'Twinkle',
    
	loc_txt = {
		name = 'Twinkle',
		text = {
			'Each scored {C:hearts}Heart{} card',
			'Stores {X:red,C:white}X#4#{} mult in this Joker',
            'On the {C:attention}Last hand{}, this Joker',
            'Uses all of its stored {X:red,C:white}XMult{}',
            'Stored {X:red,C:white}XMult{} {C:attention}resets{} when used and',
            '{C:attention}Halves{} when beating a blind',
            '{C:inactive}(Currently {X:red,C:white}X#1#{C:inactive} Mult){}'
		}
	},

    rarity = 3,
    cost = 7,
	pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	config = { extra = { StoredXmult = 1, XMultStoreBase = 0.2, XMultGain = 0.1,XMultStoreGain = 0.2} },
	atlas = 'Twinkle',
    pools = { ["Shape"] = true, ["Batrocities"] = true },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.StoredXmult, card.ability.extra.XMultStoreBase, card.ability.extra.XMultGain, card.ability.extra.XMultStoreGain,  } }
    end,

	calculate = function(self, card, context)
        local shapecount = 0
         for i = 1, #G.jokers.cards do
           if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Shape then
               shapecount = shapecount + 1
            end
        end
        if context.setting_blind then
            card.ability.extra.XMultStoreGain = card.ability.extra.XMultStoreBase + (card.ability.extra.XMultGain * shapecount)
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and not (card.ability.extra.StoredXmult == 1) then
            card.ability.extra.StoredXmult = ((card.ability.extra.StoredXmult - 1) / 2) + 1
            return {
                message = 'Halved!',
                colour = G.C.FILTER
            }
        end
		if context.individual and context.cardarea == G.play and context.other_card:is_suit("Hearts") and not context.blueprint then
            card.ability.extra.StoredXmult = card.ability.extra.StoredXmult + card.ability.extra.XMultStoreGain
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.StoredXmult } }
            }
        end
        if context.joker_main and G.GAME.current_round.hands_left == 0 then
            return {
                xmult = card.ability.extra.StoredXmult
            }
        end
        if context.after and G.GAME.current_round.hands_left == 0 then
            card.ability.extra.StoredXmult = 1
            return {
                message = 'Reset!',
                colour = G.C.FILTER
            }
        end
	end
}

--Grooph
SMODS.Atlas{
    key = 'Grooph',
    path = 'Grooph.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Grooph',
    loc_txt = {
        name = 'Grooph',
        text = {
            '{C:attention}Shape{} Jokers give {X:red,C:white}X#1#{} Mult.'
        }
    },
    atlas = 'Grooph',
    pools = { ["Shape"] = true, ["Batrocities"] = true },

    rarity = 3,
    cost = 7,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {xmult = 1.25} },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.other_joker then
            if (context.other_joker.config.center.pools or {})["Shape"] then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end,
}

-- Windy
SMODS.Atlas{
    key = 'Windy',
    path = 'Windy.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Windy',
    loc_txt = {
        name = 'Windy',
        text = {
            'Scored {C:diamonds}Diamond{} Cards give', 
            '{X:red,C:white}X#1#{} Mult when held in hand,', 
            'gain {X:red,C:white}X#3#{} per',
            'other {C:attention}Shape{} Joker owned',
            '{C:inactive}(Currently {X:red,C:white}X#4#{C:inactive})'
            
        }
    },
    atlas = 'Windy',
    pools = { ["Shape"] = true, ["Batrocities"] = true },

    rarity = 3,
    cost = 8,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { x_mult = 1.2, Xmultgain = 0.1, suit = 'Diamonds', totalmult = 1.2 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, localize(card.ability.extra.suit, 'suits_singular'), card.ability.extra.Xmultgain, card.ability.extra.totalmult} }
    end,

    calculate = function(self, card, context)
    local shapecount = 0
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Shape then
            shapecount = shapecount + 1
        end
    end
    card.ability.extra.totalmult = ((((shapecount - 1) * card.ability.extra.Xmultgain))+card.ability.extra.x_mult)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:is_suit(card.ability.extra.suit) then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                return {
                    x_mult = card.ability.extra.totalmult
                }
            end
        end
    end,
}
--[[ Windy
SMODS.Atlas{
    key = 'Windy',
    path = 'Windy.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Windy',
    loc_txt = {
        name = 'Windy',
        text = {
            'Scored {C:diamonds}Diamond{} Cards give', 
            '{X:red,C:white}X#1#{} Mult when held in hand,', 
            'gain {X:red,C:white}X#3#{} per',
            'other {C:attention}Shape{} Joker owned',
            '{C:inactive}(Currently {X:red,C:white}X#4#{C:inactive})'
            
        }
    },
    atlas = 'Windy',
    pools = { ["Shape"] = true, ["Batrocities"] = true },

    rarity = 3,
    cost = 8,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { x_mult = 1.2, Xmultgain = 0.1, suit = 'Diamonds', totalmult = 1.2 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, localize(card.ability.extra.suit, 'suits_singular'), card.ability.extra.Xmultgain, card.ability.extra.totalmult} }
    end,

    calculate = function(self, card, context)
    local shapecount = 0
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Shape then
            shapecount = shapecount + 1
        end
    end
    card.ability.extra.totalmult = ((((shapecount - 1) * card.ability.extra.Xmultgain))+card.ability.extra.x_mult)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:is_suit(card.ability.extra.suit) then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                return {
                    x_mult = card.ability.extra.totalmult
                }
            end
        end
    end,
}]]

--Fuse
SMODS.Atlas{
    key = 'Fuse',
    path = 'Fuse.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Fuse',
    loc_txt = {
        name = 'Fuse',
        text = {
            'Eternal when bought, {X:red,C:white}X#3#{} Mult.', 
            'After {C:attention}#1#{} rounds, debuff and', 
            'remove eternal, and lose {C:money}$#4#{}.'
        }
    },
    atlas = 'Fuse',
    pools = { ["Shape"] = true, ["Batrocities"] = true },

    rarity = 2,
    cost = 2,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { rounds_left = 3, round_change = 1, xmult = 2.5, moneyLoss = 10, eternal = true } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.rounds_left, card.ability.extra.round_change, card.ability.extra.xmult, card.ability.extra.moneyLoss } }
    end,
    calculate = function(self, card, context)
        card.ability.eternal = true 
    if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.rounds_left - card.ability.extra.round_change <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                card.ability.eternal = false 
                return {
                    dollars = card.ability.extra.moneyLoss * -1,
                    message = 'Exploded!',
                    colour = G.C.FILTER
                }
            else
                card.ability.extra.rounds_left = card.ability.extra.rounds_left - card.ability.extra.round_change
                return {
                    message = '-1 Round',
                    colour = G.C.FILTER
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,

}

--SwaggyCrab
SMODS.Atlas{
    key = 'SwaggyCrab',
    path = 'SwaggyCrab.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'SwaggyCrab',
    loc_txt = {
        name = 'Swaggy Crab',
        text = {
            '{C:attention}#1#{} free {C:green}Rerolls, {C:money}$#2#{} at end of round,', 
            'Jacks give {C:money}$#3#{} when scored.'
        }
    },
    atlas = 'SwaggyCrab',
    pools = {["Batrocities"] = true},

    rarity = "btct_Elite",
    cost = 17,
    pos = {x = 0, y = 0},
    soul_pos = { x = 1, y = 0 },
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { rerolls = 2, dollars = 7, jack_dollars = 2} },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.rerolls, card.ability.extra.dollars, card.ability.extra.jack_dollars } }
    end,

    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end,

    add_to_deck = function(self, card, from_debuff)
        SMODS.change_free_rerolls(card.ability.extra.rerolls)
    end,
    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_free_rerolls(-card.ability.extra.rerolls)
    end,

    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 11 then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.jack_dollars
            return {
                dollars = card.ability.extra.jack_dollars,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end
    end
    
}

--GamblerAtHeart
SMODS.Atlas{
    key = 'GamblerAtHeart',
    path = 'GamblerAtHeart.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'GamblerAtHeart',
    loc_txt = {
        name = 'Gambler At Heart',
        text = {
            '7s have a {C:green}#6# in #3#{} chance to give {X:red,C:white}X#2#{} Mult,', 
            'and a {C:green}#6# in #5#{} chance to give {C:money}$#4#{}.'
        }
    },
    atlas = 'GamblerAtHeart',
    pools = {["Batrocities"] = true},

    rarity = 2,
    cost = 6,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { xmult = 1.7, dollars = 7, xmult_odds = 2, dollars_odds = 10} },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal, card.ability.extra.xmult, card.ability.extra.xmult_odds, card.ability.extra.dollars, card.ability.extra.dollars_odds, G.GAME.probabilities.normal } }
    end,

    calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:get_id() == 7 then
        return {
            xmult = pseudorandom('GamblerAtHeart') < G.GAME.probabilities.normal / card.ability.extra.xmult_odds and card.ability.extra.xmult or nil,
            dollars = pseudorandom('GamblerAtHeart') < G.GAME.probabilities.normal / card.ability.extra.dollars_odds and card.ability.extra.dollars or nil
        }
    end
end
}

--Dealer
SMODS.Atlas{
    key = 'Dealer',
    path = 'Dealer.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = 'Dealer',
    loc_txt = {
        name = 'Dealer',
        text = {
            'Retrigger',
            'each played',
            '{C:attention}#1#{}, {C:attention}#2#{}, and {C:attention}#3#{}.'
        }
    },
    atlas = 'Dealer',
    pools = {["Batrocities"] = true },

    rarity = 2,
    cost = 6,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    config = { extra = { card1 = 6, card2 = 7, card3 = 8, repetitions = 1 } },

    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.card1, center.ability.extra.card2, center.ability.extra.card3}}
	end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card:get_id() == card.ability.extra.card1 or
                context.other_card:get_id() == card.ability.extra.card2 or
                context.other_card:get_id() == card.ability.extra.card3 then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end
}

--BlueLobster
SMODS.Atlas{
    key = 'BlueLobster',
    path = 'BlueLobster.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'BlueLobster',
    loc_txt = {
        name = 'Blue Lobster',
        text = {
            '{X:blue,C:white}X#1#{} Chips'
        }
    },
    atlas = 'BlueLobster',
    pools = {["Batrocities"] = true},

    rarity = 1,
    cost = 5,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {xchips = 1.35}},

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'btct_bluelobster', set = 'Other', vars = {center.ability.extra.xchips}}
		return { vars = {center.ability.extra.xchips}}
	end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xchips = card.ability.extra.xchips
            }
        end
    end
}

SMODS.Sound({key = "MichaelKaboom", path = "MichaelKaboom.ogg",})

--MichaelWave
SMODS.Atlas{
    key = 'MichaelWave',
    path = 'MichaelWave.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'MichaelWave',
    loc_txt = {
        name = 'Michael Wave',
        text = {
            '{C:mult}+#1#{} Mult, self-destructs if a {C:blue}Foil{}', 
            'Card scores or a {C:blue}Foil{} Joker activates.'
        }
    },
    atlas = 'MichaelWave',
    pools = {["Batrocities"] = true},

    rarity = 1,
    cost = 4,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,

    config = { extra = {mult = 12}},

    loc_vars = function(self, info_queue, center, card)
		return { vars = {center.ability.extra.mult}}
	end,

    calculate = function(self, card, context)
        local exploded = false
        if context.other_joker and context.other_joker.edition then
            if context.other_joker.edition.foil == true then
                return {
                    message = 'NOOO, MICHAEL!!!',
                    play_sound('btct_MichaelKaboom'),
                    SMODS.destroy_cards(card, nil, nil, true),
                    exploded = true
                }
            end
            elseif context.individual and context.cardarea == G.play and  context.other_card.edition and context.other_card.edition.foil == true then
                return {
                    message = 'NOOO, MICHAEL!!!',
                    play_sound('btct_MichaelKaboom'),
                    SMODS.destroy_cards(card, nil, nil, true),
                    exploded = true
                }
            end
        if context.joker_main and exploded == false then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

--TheTimer
--[[SMODS.Atlas{
    key = 'TheTimer',
    path = 'TheTimer.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'TheTimer',
    loc_txt = {
        name = 'THE TIMER',
        text = {
            '{C:chips}+200{} Chips, {C:chips}-20{} Chips every 4 seconds',
            'spent in round. Resets after round is finished.',
            '{C:inactive}(Currently {C:chips}+ Not working :({}{C:inactive} Chips){}'
        }
    },
    atlas = 'TheTimer',
    pools = {["Batrocities"] = true},

    rarity = 1,
    cost = 4,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

}]]

--VeryBigRock
SMODS.Atlas{
    key = 'VeryBigRock',
    path = 'VeryBigRock.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'VeryBigRock',
    loc_txt = {
        name = 'Very Big Rock',
        text = {
            'Stone Cards give',
            '{C:mult}+#1#{} Mult when scored.'
        }
    },
    atlas = 'VeryBigRock',
    pools = {["Batrocities"] = true},

    rarity = 1,
    cost = 4,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { mult = 5 } },
    	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, localize('m_stone') } }
	end,
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.other_card.debuff then
            if SMODS.has_enhancement(context.other_card, 'm_stone') then
            return {
                mult = card.ability.extra.mult
            }
            end
        end
    end
}

-- Mosaic
SMODS.Atlas{
    key = 'Mosaic',
    path = 'Mosaic.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Mosaic',
    loc_txt = {
        name = 'Mosaic',
        text = {
            'Gains {C:mult}+#1#{} Mult per each',
            '{C:attention}Unique{} poker hand played.',
            '{C:inactive}(Currently {C:mult}+#2#{}{C:inactive} Mult){}'
        }
    },
    atlas = 'Mosaic',
    pools = {["Batrocities"] = true},

    rarity = 1,
    cost = 5,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { mult_gain = 2.5, mult = 0, played_hands = {}, } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_gain, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
    if context.before and context.main_eval and not context.blueprint then
        for k, v in pairs(G.GAME.hands) do
            if G.GAME.hands[k].played > 0 and not card.ability.extra.played_hands[k] then
                card.ability.extra.played_hands[k] = true
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            end
        end
    end
    if context.joker_main then
        return {
            mult = card.ability.extra.mult
        }
    end
    end
}

-- FlushCave
--[[SMODS.Atlas{
    key = 'FlushCave',
    path = 'FlushCave.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'FlushCave',
    loc_txt = {
        name = 'Flush Cave',
        text = {
            '{C:attention}Stone{} cards count as {C:spades}w{}{C:hearts}i{}{C:clubs}l{}{C:diamonds}d{} cards.'
        }
    },
    atlas = 'FlushCave',
    pools = {["Batrocities"] = true},

    rarity = 2,
    cost = 4,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

}]]

-- HowHungry
SMODS.Atlas{
    key = 'HowHungry',
    path = 'HowHungry.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'HowHungry',
    loc_txt = {
        name = 'How Hungry?',
        text = {
            'Each used {C:attention}consumable{} gives',
 		'{X:blue,C:white}X#1#{} Chips.',
        '{C:inactive}(Currently {X:blue,C:white}X#2#{}{C:inactive} Chips){}'
        }
    },
    atlas = 'HowHungry',
    pools = {["Batrocities"] = true},

    rarity = 2,
    cost = 6,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { Xchips = 1, Xchips_mod = 0.03 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xchips_mod, card.ability.extra.Xchips } }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint then
            card.ability.extra.Xchips = card.ability.extra.Xchips + card.ability.extra.Xchips_mod
            return {
                message = localize { type = 'variable', key = 'a_xchips', vars = { card.ability.extra.Xchips } }
            }
        end
        if context.joker_main then
            return {
                xchips = card.ability.extra.Xchips
            }
        end
    end
}

--[[ BigOopsies
SMODS.Atlas{
    key = 'BigOopsies',
    path = 'BigOopsies.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'BigOopsies',
    loc_txt = {
        name = 'Big Oopsies',
        text = {
            "Floppr (main artist) here.",
            'Im respriting almost all the jokers,',
            'so look forward to that ig.',
            'Also this {C:attention}retriggers played Aces{}.'
        }
    },
    atlas = 'BigOopsies',
    rarity = 2,
    cost = 5,
	pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pools = {["Batrocities"] = true},
    config = { extra = { repetitions = 1 } },
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card:get_id() == 14 then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end
}]]-- Joker byebye ig

-- Sandwich
SMODS.Atlas{
    key = 'Sandwich',
    path = 'Sandwich.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Sandwich',
    loc_txt = {
        name = 'Sandwich',
        text = {
            '{X:red,C:white}X#1#{} Mult,',
 		    '{C:attention}Decreases{} by {X:red,C:white}X#2#{}',
            'mult per round.'
        }
    },
    atlas = 'Sandwich',
    pools = {["Batrocities"] = true},

    rarity = 3,
    cost = 6,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { xmult_loss = 0.5, xmult = 3 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'btct_artcreditPiero', set = 'Other'}
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_loss } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.xmult - card.ability.extra.xmult_loss <= 1 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = localize('k_eaten_ex'),
                    colour = G.C.BLUE
                }
            else
                card.ability.extra.xmult = card.ability.extra.xmult - card.ability.extra.xmult_loss
                return {
                    message = localize { type = 'variable', key = 'a_xmult_minus', vars = { card.ability.extra.xmult_loss } },
                    colour = G.C.RED
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

-- DeadlyBeast
SMODS.Atlas{
    key = 'DeadlyBeast',
    path = 'DeadlyBeast.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'DeadlyBeast',
    loc_txt = {
        name = 'Deadly Beast',
        text = {
            'Gains {C:mult}+#1#{} mult per {C:spades}w{}{C:hearts}i{}{C:clubs}l{}{C:diamonds}d{} card scored.',
            '{C:inactive}(Currently {C:mult}+#3#{}{C:inactive} mult){}'
        }
    },
    atlas = 'DeadlyBeast',
    pools = {["Batrocities"] = true},

    rarity = 2,
    cost = 5,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { mult_gain = 1, mult = 0 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'btct_artcreditDoneInOne', set = 'Other'}
        return { vars = { card.ability.extra.mult_gain, localize('m_wild'), card.ability.extra.mult } }
    end,
        calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_wild') and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Prototype
SMODS.Atlas{
    key = 'Prototype',
    path = 'Prototype.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Prototype',
    loc_txt = {
        name = 'Prototype',
        text = {
            'Copies the {C:attention}third{} Joker', 
            '{C:inactive}(left to right){}'
        }
    },
    atlas = 'Prototype',
    pools = {["Batrocities"] = true},

    rarity = 3,
    cost = 10,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

        loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            local compatible = G.jokers.cards[3] and G.jokers.cards[3] ~= card and
                G.jokers.cards[3].config.center.blueprint_compat
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            return { main_end = main_end }
        end
    end,
    calculate = function(self, card, context)
        local ret = SMODS.blueprint_effect(card, G.jokers.cards[3], context)
        if ret then
            ret.colour = G.C.RED
        end
        return ret
    end,
}

-- SteelPress
SMODS.Atlas{
   key = 'SteelPress',
   path = 'SteelPress.png',
   px = 71,
   py = 95
}
SMODS.Joker{
   key = 'SteelPress',
   loc_txt = {
       name = 'Steel Press',
       text = {
           '{C:attention}Steel{} cards give an extra',
           '{X:red,C:white}X#1#{} Mult when held in hand'
       }
   },
   atlas = 'SteelPress',
   pools = {["Batrocities"] = true},
   rarity = 2,
   cost = 5,
   pos = {x=0, y=0},
   unlocked = true,
   discovered = false,
   blueprint_compat = true,
   eternal_compat = true,
   perishable_compat = true,
   config = { extra = { xmult = 1.25 } },
   loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        return { vars = { card.ability.extra.xmult } }
   end,
   calculate = function(self, card, context)
       if context.individual and context.cardarea == G.hand and not context.end_of_round and SMODS.has_enhancement(context.other_card, 'm_steel') then
           if context.other_card.debuff then
               return {
                   message = localize('k_debuffed'),
                   colour = G.C.RED
               }
           else
               return {
                   x_mult = card.ability.extra.xmult
               }
           end
       end
   end,
}

-- LockIn
SMODS.Atlas{
    key = 'LockIn',
    path = 'LockIn.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'LockIn',
    loc_txt = {
        name = 'Lock In',
        text = {
            'Retrigger the first played card once per', 
            '{C:attention}unscoring{} card played in hand.'
        }
    },
    atlas = 'LockIn',
    pools = {["Batrocities"] = true},

    rarity = 2,
    cost = 6,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { repetitions = nil } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'btct_artcreditDoneInOne', set = 'Other'}
        return { vars = { card.ability.extra.repetitions } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card == context.scoring_hand[1] then
            card.ability.extra.repetitions = #context.full_hand - #context.scoring_hand
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end,
}

-- TheBasher
SMODS.Atlas{
    key = 'TheBasher',
    path = 'TheBasher.png',
    px = 71,
    py = 95
}

SMODS.Sound({key = "Bonk!", path = "Bonk!.ogg",})

SMODS.Joker{
    key = 'TheBasher',
    loc_txt = {
        name = 'The Basher',
        text = {
       '{C:clubs}Club{} cards gain {X:red,C:white}X#2#{} Mult',
       'per joker this card destroys.',
        ' When {C:attention}blind{} is selected, this joker',
        'destroys the joker to the right.',
        '{C:inactive}(Currently {X:red,C:white}X#1#{}{C:inactive} Mult){}'
        }
    },
    atlas = 'TheBasher',
    pools = {["Batrocities"] = true},

    rarity = 3,
    cost = 7,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { xmult = 1, xmult_gain = 0.04 }, path = "Bonk!.ogg" },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
            if my_pos and G.jokers.cards[my_pos + 1] and not G.jokers.cards[my_pos + 1].ability.eternal and not G.jokers.cards[my_pos + 1].getting_sliced then
                local sliced_card = G.jokers.cards[my_pos + 1]
                sliced_card.getting_sliced = true -- Make sure to do this on destruction effects
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.joker_buffer = 0
                        card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                        card:juice_up(0.8, 0.8)
                        sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
                        play_sound('btct_Bonk!', 0.9 + math.random() * 0.08)
                        return true
                    end
                }))
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult +card.ability.extra.xmult_gain} },
                    colour = G.C.RED,
                    no_juice = true
                    
                }
            end
        end
        if context.individual and context.cardarea == G.play then
            if  context.other_card:is_suit("Clubs") then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        end
    end
}

-- Spoon
SMODS.Atlas{
    key = 'Spoon',
    path = 'Spoon.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Spoon',
    loc_txt = {
        name = 'Spoon?',
        text = {
        '{C:spades}Spade{} cards give {X:blue,C:white}X#2#{} Chips',
        'per {C:red}Discard{} used this round.',
        'Resets after round.',
        '{C:inactive}(Currently {X:blue,C:white}X#1#{}{C:inactive} Chips){}'
        }
    },
    atlas = 'Spoon',
    pools = {["Batrocities"] = true},

    rarity = 3,
    cost = 7,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { xchips = 1, xchips_gain = 0.2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips, card.ability.extra.xchips_gain } }
    end,
    calculate = function(self, card, context)
        if context.pre_discard and not context.blueprint then
            card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.xchips_gain
            return {
                message = localize('k_upgrade_ex'),
            }
        end
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Spades") then
                return {
                    xchips = card.ability.extra.xchips
                }
            end
        end
        if context.end_of_round and context.cardarea == G.jokers then
            card.ability.extra.xchips = 1
            return {
                message = localize('k_reset'),
            }
        end
    end
}

-- Bootleg
SMODS.Atlas{
    key = 'Bootleg',
    path = 'Bootleg.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Bootleg',
    loc_txt = {
        name = 'Bootleg Joker',
        text = {
    
            '{C:red}Crimson{} seals have a {C:green}#2# in #3#{}',
            'chance to retrigger when played.',
            '{C:planet}Cerulean{} seals have a {C:green}#2# in #4#{}',
            'chance to spawn a {C:planet}planet{} card of',
            'the {C:attention}winning hand{} when held in hand.'
        }
    },
    atlas = 'Bootleg',
    pools = {["Batrocities"] = true},
    
    rarity = 1,
    cost = 4,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { repetitions = 1, oddsCrim = 2, oddsCeru = 4 } },
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars, (G.GAME.probabilities.normal or 1), card.ability.extra.oddsCrim, card.ability.extra.oddsCeru } }
	end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card.seal == 'btct_SealCrimson' then
            if pseudorandom('Bootleg') < G.GAME.probabilities.normal / card.ability.extra.oddsCrim then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
        if context.end_of_round and context.individual and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and pseudorandom('Bootleg') < G.GAME.probabilities.normal / card.ability.extra.oddsCeru and context.other_card.seal == 'btct_SealCerulean' then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = function()
                    if G.GAME.last_hand_played then
                        local _planet = nil
                        for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                            if v.config.hand_type == G.GAME.last_hand_played then
                                _planet = v.key
                            end
                        end
                        if _planet then
                            SMODS.add_card({ key = _planet })
                        end
                        G.GAME.consumeable_buffer = 0
                    end
                    return true
                end
            }))
            return { 
                message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet
            }
        end
    end,
}

-- TrashCan
--[[SMODS.Atlas{
    key = 'TrashCan',
    path = 'TrashCan.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'TrashCan',
    loc_txt = {
        name = 'Trash Can',
        text = {
            'Discarded cards count {C:attention}twice{}.'
        }
    },
    atlas = 'TrashCan',
    pools = {["Batrocities"] = true},

    rarity = 1,
    cost = 4,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
}]]

-- InsuranceFraud
SMODS.Atlas{
    key = 'InsuranceFraud',
    path = 'InsuranceFraud.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'InsuranceFraud',
    loc_txt = {
        name = 'Insurance Fraud',
        text = {
            'Earn {C:money}$#1#{} at end of round,',
            ' {C:green}#2# in #3#{} chance to get caught.'
        }
    },
    atlas = 'InsuranceFraud',
    pools = {["Batrocities"] = true},

    rarity = 1,
    cost = 6,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,

    config = { extra = { dollars = 6, odds = 4 } },
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,

    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end,

	calculate = function(self, card, context)
		if context.joker_main then
			return {
				dollars_mod = card.ability.extra.dollars,
                card.ability.extra.dollars == 6
			}
		end
		if context.end_of_round and not context.repetition and context.game_over == false and not context.blueprint then
			if pseudorandom('InsuranceFraud') < G.GAME.probabilities.normal / card.ability.extra.odds then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true;
							end
						}))
						return true
					end
				}))
				return {
					message = 'Caught!'
				}
			else
				return {
					message = 'Safe!'
				}
			end
		end
	end
}

-- PetRock
SMODS.Atlas{
    key = 'PetRock',
    path = 'PetRock.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'PetRock',
    loc_txt = {
        name = 'Pet Rock',
        text = {
            'Retrigger all {C:attention}stone{} cards.',
            '{C:inactive}(Through the power of emotional support){}'
        }
    },
    atlas = 'PetRock',
    pools = {["Batrocities"] = true},
	rarity = 1,
    cost = 4,
	pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	config = { extra = { repetitions = 1 } },
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, 'm_stone') then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end
}

--TWOPAIR!!!
SMODS.Atlas{
    key = 'TWOPAIR',
    path = 'TWOPAIR.png',
    px = 71,
    py = 95
}
SMODS.Joker{
    key = 'TWOPAIR',
    loc_txt = {
        name = 'TWO PAIR!!!',
        text = {
            'Gain {C:money}$#1#{} if poker ',
            'hand is a {C:attention}Two Pair{}.'
        }
    },
    atlas = 'TWOPAIR',
    pools = {["Batrocities"] = true},

    rarity = 2,
    cost = 6,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { dollars = 2} },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars}}
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == "Two Pair" then
            return {
                dollars = card.ability.extra.dollars
            }
        end
    end
}

-- BottomlessHole
SMODS.Atlas{
    key = 'BottomlessHole',
    path = 'BottomlessHole.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'BottomlessHole',
    loc_txt = {
        name = 'Bottomless Hole',
        text = {
            'If the first played hand ',
            'contains only {C:attention}1 card{},',
            'destroy it and give this',
            'joker {C:mult}+#2#{} mult',
            '{C:inactive}(Currently {}{C:mult}+#1#{}{C:inactive} mult){}'
        }
    },
    atlas = 'BottomlessHole',
    pools = {["Batrocities"] = true},

    rarity = 2,
    cost = 6,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    config = { extra = {mult = 0, mult_gain = 3} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'btct_artcreditDoneInOne', set = 'Other'}
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
    end,
    calculate = function(self, card, context)
        if context.first_hand_drawn then
            local eval = function() return G.GAME.current_round.hands_used == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.destroy_card and not context.blueprint then
            if #context.full_hand == 1 and context.destroy_card == context.full_hand[1] and G.GAME.current_round.hands_played == 0 then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED,
                remove = true
            }
        end
    end
end
}

-- MSBA
SMODS.Atlas{
    key = 'MSBA',
    path = 'MobilityAssassin.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'MSBA',
    loc_txt = {
        name = 'Mobility Scooter Bitcoin Assassin',
        text = {
            '{X:red,C:white}X#1#{} Mult, {C:money}-$#2#{}',
            'Per {C:hand}hand{} played.'
        }
    },
    atlas = 'MSBA',
    pools = {["Batrocities"] = true},

    rarity = 2,
    cost = 3,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { xmult = 2.5, dollars = 2 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                dollars = card.ability.extra.dollars * -1,
                xmult = card.ability.extra.xmult
            }
        end
    end
}

-- Dementia
SMODS.Atlas{
    key = 'Dementia',
    path = 'Dementia.png',
    px = 71,
    py = 95
}
SMODS.Joker{
    key = 'Dementia',
    loc_txt = {
        name = 'Dementia',
        text = {
            'Upon death, revive and rewind {C:attention}2 Antes{},',
            'This Joker then {C:attention}self-destructs{}.'
        }
    },
    atlas = 'Dementia',
    pools = {["Batrocities"] = true},

    rarity = 3,
    cost = 14,
    pos = {x = 0, y = 0},
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over and context.main_eval then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        ease_ante(-2)
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('tarot1')
                        card:start_dissolve()
                        return true
                    end
                }))
                return {
                    message = 'Huh?',
                    saved = 'Huh?',
                    colour = G.C.RED
                }
        end
    end,
}

-- Toilet
SMODS.Atlas{
    key = 'Toilet',
    path = 'Toilet.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Toilet',
    loc_txt = {
        name = 'Toilet',
        text = {
            '{X:red,C:white}X#1#{} Mult if played hand ',
            'contains a {C:attention}Full House{},',
            '{X:blue,C:white}X#2#{} Chips if played hand ',
            'contains a {C:attention}Flush{}.'
        }
    },
    atlas = 'Toilet',
    pools = {["Batrocities"] = true},

    rarity = 3,
    cost = 8,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { Xmult = 3, Xchips = 1.75, typeHouse = 'Full House', typeFlush = 'Flush', typeFlushHouse = 'Flush House' } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult, card.ability.extra.Xchips, localize(card.ability.extra.typeHouse, 'poker_hands'), localize(card.ability.extra.typeFlush, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.typeFlush]) then
            if context.joker_main and next(context.poker_hands[card.ability.extra.typeHouse]) then
                return {
                    xchips = card.ability.extra.Xchips,
                    xmult = card.ability.extra.Xmult
                }
            else 
                return {
                    xchips = card.ability.extra.Xchips
                }
            end
        end
        if context.joker_main and next(context.poker_hands[card.ability.extra.typeHouse]) then
            if context.joker_main and next(context.poker_hands[card.ability.extra.typeFlush]) then
                return {
                    xchips = card.ability.extra.Xchips,
                    xmult = card.ability.extra.Xmult
                }
            else 
                return {
                    xmult = card.ability.extra.Xmult
                }
            end
        end
    end
}

--[[IWLSCAN
SMODS.Atlas{
    key = 'CoolAtNite',
    path = 'CoolAtNite.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'CoolAtNite',
    loc_txt = {
        name = 'It Would Look so Cool at Nite',
        text = {
            'Played {C:spades}Spades{} and {C:clubs}Clubs{}',
            'have a {C:green}#1# in #2#{} chance to become',
            '{C:attention}Astral{} when played'
        }
    },
    atlas = 'CoolAtNite',
    pools = {["Batrocities"] = true},

    rarity = 1,
    cost = 6,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { odds = 3 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'btct_CoolAtNite')
        info_queue[#info_queue + 1] = {key = 'btct_artcreditDoneInOne', set = 'Other'}
        info_queue[#info_queue + 1] = G.P_CENTERS.m_btct_astral
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card:is_suit('Spades', nil, true) or scored_card:is_suit('Clubs', nil, true) then
                    if SMODS.pseudorandom_probability(card, 'btct_CoolAtNite', 1, card.ability.extra.odds) then
                        scored_card:set_ability('m_btct_astral', nil, true)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                scored_card:juice_up()
                                return true
                            end
                        }))
                    end
                end
            end
        end
    end
}]]--

--[[ RockEater
SMODS.Atlas{
   key = 'RockEater',
   path = 'RockEater.png',
   px = 71,
   py = 95
}


SMODS.Joker{
   key = 'RockEater',
   loc_txt = {
       name = 'Rock Eater',
       text = {
           'When played,{C:attention} Stone Cards{}',
           'have a {C:green}#1# in #2#{} chance to turn',
           'into{C:attention} Steel{} or{C:attention} Gold{} cards',
           'with {C:dark_edition}Foil{}, {C:dark_edition}Holographic{},',
           '{C:dark_edition}Gemstone{}, or {C:dark_edition}Polychrome{}',
           'after scoring.',
           
       }
   },
   atlas = 'RockEater',
   pools = {["Batrocities"] = true},
   rarity = 2,
   cost = 4,
   pos = {x=0, y=0},
   unlocked = true,
   discovered = false,
   blueprint_compat = false,
   eternal_compat = true,
   perishable_compat = true,
   config = { extra = { odds = 6 } },
   loc_vars = function(self, info_queue, card)
       local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'btct_RockEater')
       info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
       info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
       info_queue[#info_queue + 1] = G.P_CENTERS.e_btct_gemstone
       info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
       return { vars = { numerator, denominator } }
   end,
   calculate = function(self, card, context)
       if context.before and context.main_eval and not context.blueprint then
           for _, scored_card in ipairs(context.scoring_hand) do
               if SMODS.has_enhancement(context.other_card, 'm_stone') then
                   if SMODS.pseudorandom_probability(card, 'btct_RockEater', 1, card.ability.extra.odds) then
                       if SMODS.pseudorandom_probability(card, 'btct_RockEater', 1, 2) == 1 then
                       scored_card:set_ability('m_steel', nil, true)
                       else
                       scored_card:set_ability('m_gold', nil, true)
                       end
                       G.E_MANAGER:add_event(Event({
                           func = function()
                               local edition = SMODS.poll_edition { key = "btct_RockEater", guaranteed = true, no_negative = true, options = { 'e_polychrome', 'e_btct_gemstone', 'e_holo', 'e_foil' } }
                               scored_card:juice_up()
                               return true
                           end
                       }))
                   end
               end
           end
       end
   end
}]]--

--[[ Malfunction
SMODS.Atlas{
    key = 'Malfunction',
    path = 'MalfunctionCombined.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Malfunction',
    loc_txt = {
        name = 'Malfunction',
        text = {
            'After {C:attention}1 round{}, sell this joker',
            'To make a random {C:uncommon}Uncommon{} Joker.',
            '{C:inactive}(Currently{} {C:attention:}#2#{}{C:inactive}/#1#){}'
        }
    },
    atlas = 'Malfunction',
    pools = {["Batrocities"] = true},

    rarity = 1,
    cost = 5,
    pos = {x=1, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,

    draw = function(self, card, layer)
    end,
    config = { extra = { rounds = 0, total_rounds = 1 } },
    loc_vars = function(self, info_queue, card)
        local main_end
        if G.jokers and G.jokers.cards then
            for _, joker in ipairs(G.jokers.cards) do
                if joker.edition and joker.edition.negative then
                    main_end = {}
                    localize { type = 'other', key = 'remove_negative', nodes = main_end, vars = {} }
                    break
                end
            end
        end
        return { vars = { card.ability.extra.total_rounds, card.ability.extra.rounds }, main_end = main_end }
    end,
    calculate = function(self, card, context)
        if context.selling_self and (card.ability.extra.rounds >= card.ability.extra.total_rounds) and not context.blueprint then
            local jokers = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card then
                    jokers[#jokers + 1] = G.jokers.cards[i]
                end
            end
                if #G.jokers.cards <= G.jokers.config.card_limit then
                    SMODS.add_card {
                            set = 'Joker',
                            rarity = 'Uncommon',
                            key_append = 'btct_malfunction'
                        }
                        G.GAME.joker_buffer = 0
                    return { message = 'Generated!' }
                else
                    return { message = localize('k_no_room_ex') }
                    
                end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.rounds = card.ability.extra.rounds + 1
            if card.ability.extra.rounds == card.ability.extra.total_rounds then
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
            end
            return {
                message = (card.ability.extra.rounds < card.ability.extra.total_rounds) and
                    (card.ability.extra.rounds .. '/' .. card.ability.extra.total_rounds) or
                    localize('k_active_ex'),
            }
        end
    end
}]]

-- Yoink
SMODS.Atlas{
    key = 'Yoink',
    path = 'Yoink.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Yoink',
    loc_txt = {
        name = 'Yoink',
        text = {
            'Gains {C:chips}+#2#{} chip per',
            'card held in hand ',
            'after hand is scored',
            '{C:inactive}(Currently{} {C:chips}+#1#{} {C:inactive}Chips){}'
        }
    },
    atlas = 'Yoink',
    pools = {["Batrocities"] = true},

    rarity = 2,
    cost = 5,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { base_chips = 0, chip_gain = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.base_chips, card.ability.extra.chip_gain } }
end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and not context.blueprint then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                card.ability.extra.base_chips = card.ability.extra.base_chips + card.ability.extra.chip_gain
            end
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.BLUE
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.base_chips,
            }
        end
    end
}

-- ZapMcCar
SMODS.Atlas{
    key = 'ZapMcCar',
    path = 'ZapMcCar.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'ZapMcCar',
    loc_txt = {
        name = 'Zap McCar',
        text = {
            '{C:chips}+#2#{} chips per Ante',
            '{C:chips}-#3#{} chips per Round',
            '{C:inactive}(Currently{} {C:chips}+#1#{} {C:inactive}Chips){}'
        }
    },
    atlas = 'ZapMcCar',
    pools = {["Batrocities"] = true},

    rarity = 1,
    cost = 5,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { AnteChips = 60, RoundChips = 20, CurrentChips = 0 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.CurrentChips, card.ability.extra.AnteChips, card.ability.extra.RoundChips } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            card.ability.extra.CurrentChips = (G.GAME.round_resets.ante * card.ability.extra.AnteChips)
            card.ability.extra.CurrentChips = card.ability.extra.CurrentChips - (G.GAME.round * card.ability.extra.RoundChips)
        end          
        if context.joker_main then
            return {
                chips = card.ability.extra.CurrentChips
            }
        end
    end,
}

-- LeprechaunCereal
SMODS.Atlas{
    key = 'LeprechaunCereal',
    path = 'LeprechaunCereal.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'LeprechaunCereal',
    loc_txt = {
        name = 'Leprechaun Cereal',
        text = {
            'Retrigger all played',
            '{C:attention}lucky{} cards.'
        }
    },
    atlas = 'LeprechaunCereal',
    pools = {["Batrocities"] = true},

    rarity = 2,
    cost = 6,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { repetitions = 1 } },
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, 'm_lucky') then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end
}

-- HighRoller
SMODS.Atlas{
    key = 'HighRoller',
    path = 'HighRoller.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'HighRoller',
    loc_txt = {
        name = 'High Roller',
        text = {
            'This joker gains {X:red,C:white}X0.15{} mult',
            'if played hand is a {C:attention}#2#{},',
            'Poker hand changes',
            'after round played',
            '{C:inactive}Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult{}'
        }
    },
    atlas = 'HighRoller',
    pools = {["Batrocities"] = true},

    rarity = 3,
    cost = 9,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { Xmult = 1, poker_hand = 'High Card', Xmult_gain = 0.15 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult, localize(card.ability.extra.poker_hand, 'poker_hands', card.ability.extra.Xmult_gain) } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and context.scoring_name == card.ability.extra.poker_hand then
            if not context.blueprint then
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
                return{
                    message = localize('k_upgrade_ex'),
                    colour = G.C.RED
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.Xmult
                
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local _poker_hands = {}
            for k, v in pairs(G.GAME.hands) do
                if v.visible and k ~= card.ability.extra.poker_hand then
                    _poker_hands[#_poker_hands + 1] = k
                end
            end
            card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, pseudoseed('btct_HighRoller'))
            return {
                message = localize('k_reset')
            }
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        local _poker_hands = {}
        for k, v in pairs(G.GAME.hands) do
            if v.visible and k ~= card.ability.extra.poker_hand then
                _poker_hands[#_poker_hands + 1] = k
            end
        end
        card.ability.extra.poker_hand = pseudorandom_element(_poker_hands,
            pseudoseed((card.area and card.area.config.type == 'title') and 'btct_false_HighRoller' or 'btct_HighRoller'))
    end
}

-- Pilk
SMODS.Atlas{
    key = 'Pilk',
    path = 'Pilk.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Pilk',
    loc_txt = {
        name = 'Pilk',
        text = {
            '{C:attention}+#3#{} {C:blue}Hand{}, {C:attention}+#4#{} {C:red}Discard{},',
            'Self destructs after {C:attention}#1#{} rounds'
        }
    },
    atlas = 'Pilk',
    pools = {["Batrocities"] = true},

    rarity = 1,
    cost = 4,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    config = { extra = { rounds_left = 3, round_change = 1, hands = 1, discards = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.rounds_left, card.ability.extra.round_change, card.ability.extra.hands, card.ability.extra.discards } }
    end,

    calculate = function(self, card, context)
    if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.rounds_left - card.ability.extra.round_change <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = 'Mmmm, ymmuy',
                    colour = G.C.FILTER
                }
            else
                card.ability.extra.rounds_left = card.ability.extra.rounds_left - card.ability.extra.round_change
                return {
                    message = 'Full of pilk',
                    colour = G.C.FILTER
                }
            end
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
        ease_discard(card.ability.extra.discards)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        ease_hands_played(card.ability.extra.hands)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards
        ease_discard(-card.ability.extra.discards)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
        ease_hands_played(-card.ability.extra.hands)
    end
    
}

-- Burber
SMODS.Atlas{
    key = 'Burber',
    path = 'Burber.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Burber',
    loc_txt = {
        name = 'Burber',
        text = {
            '{X:red,C:white}X#1#{} Mult, lose',
            '{X:red,C:white}X#2#{} Mult per card {C:attention}purchased{}'
        }
    },
    atlas = 'Burber',
    pools = {["Batrocities"] = true},

    rarity = 2,
    cost = 4,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { xmult = 2, xmult_loss = 0.2 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'btct_artcreditDoneInOne', set = 'Other'}
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_loss } }
    end,
    calculate = function(self, card, context)
        if context.buying_card and not context.blueprint and not (context.card == card) then
            if card.ability.extra.xmult - card.ability.extra.xmult_loss <= 1 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = localize('k_eaten_ex'),
                    colour = G.C.FILTER
                }
            else
            card.ability.extra.xmult = card.ability.extra.xmult - card.ability.extra.xmult_loss
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult_loss * -1 } },
                colour = G.C.RED,
            }
        end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

-- Peteza
SMODS.Atlas{
    key = 'Peteza',
    path = 'Peteza.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Peteza',
    loc_txt = {
        name = 'Peteza',
        text = {
            '{X:red,C:white}X#1#{} Mult, lose',
            ' {X:red,C:white}X#2#{} Mult per {C:attention}reroll{}'
        }
    },
    atlas = 'Peteza',
    pools = {["Batrocities"] = true},

    rarity = 2,
    cost = 4,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { xmult = 2, xmult_loss = 0.5 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'btct_artcreditDoneInOne', set = 'Other'}
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_loss } }
    end,
    calculate = function(self, card, context)
        if context.reroll_shop and not context.blueprint then
            if card.ability.extra.xmult - card.ability.extra.xmult_loss <= 1 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = localize('k_eaten_ex'),
                    colour = G.C.FILTER
                }
            else
            card.ability.extra.xmult = card.ability.extra.xmult - card.ability.extra.xmult_loss
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult_loss * -1 } },
                colour = G.C.RED,
            }
        end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

-- Starfruit
SMODS.Atlas{
    key = 'Starfruit',
    path = 'Starfruit.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Starfruit',
    loc_txt = {
        name = 'Starfruit',
        text = {
            'Creates the {C:planet}planet{} for your most played',
            'poker hand at start of round,',
            'self destructs after {C:attention}#1#{} rounds'
        }
    },
    atlas = 'Starfruit',
    pools = {["Batrocities"] = true },

    rarity = 3,
    cost = 8,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { rounds_left = 3, round_change = 1} },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.rounds_left, card.ability.extra.round_change, card.ability.extra.hands, card.ability.extra.discards } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            local card_type = 'Planet'
            local _planet = 0
            local _handname, _played = 'High Card', -1
            for hand_key, hand in pairs(G.GAME.hands) do
                if hand.played > _played then
                    _played = hand.played
                    _handname = hand_key
                end
            end
            local most_played = _handname
            for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                if v.config.hand_type == most_played then
                    _planet = v.key
                end
            end
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {
                            set = 'Planet',
                            area = G.consumeables,
                            key = _planet,
                            key_append = 'Starfruit'
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
            }))
            return{message = "ymmuy"}
        end
        if context.end_of_round and context.game_over == false and not context.blueprint then
            if card.ability.extra.rounds_left - card.ability.extra.round_change <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = localize('k_eaten_ex'),
                    colour = G.C.FILTER
                }
            else
                card.ability.extra.rounds_left = card.ability.extra.rounds_left - card.ability.extra.round_change
                return {
                    message = '-1 Round',
                    colour = G.C.FILTER
                }
            end
        end
    end
}--

-- Spamton
SMODS.Atlas{
    key = 'Spamton',
    path = 'Spamton.png',
    px = 71,
    py = 95
}

SMODS.Sound({key = "Spam1", path = "Spam1.ogg",})
SMODS.Sound({key = "Spam2", path = "Spam2.ogg",})
SMODS.Sound({key = "Spam3", path = "Spam3.ogg",})
SMODS.Sound({key = "Fingers", path = "Fingers(1st).ogg",})
SMODS.Sound({key = "Explain", path = "Explain(2nd).ogg",})
SMODS.Sound({key = "Strings", path = "Strings(3rd).ogg",})
SMODS.Sound({key = "Heart", path = "Heart(4th).ogg",})
local SpamtonVoice = {'btct_Fingers', 'btct_Explain', 'btct_Strings', 'btct_Heart'}
local SpamtonEEEE = {'btct_Spam1', 'btct_Spam2', 'btct_Spam3',}

SMODS.Joker{
    key = 'Spamton',
    loc_txt = {
        name = 'Shady Salesman',
        text = {
            'PLAY [[{C:attention}1{}, {C:attention}9{}, {C:attention}9{}, or {C:attention}7{}]] FOR',
            'SPECIL PRIZE OF [[{X:red,C:white}X#1#{}]],',
            'AND IF YOU`RE A [[BIG SHOT]]',
            'EARNING [[{C:attention}maximum interest{}]],',
            'RELISH IN THE SWEET SWEET',
            'DEAL OF [[{X:red,C:white}X#2#{}]] INSTEAD!!!'
        }
    },
    atlas = 'Spamton',
    pools = {["Batrocities"] = true },

    rarity = 3,
    cost = 8,
    pos = {x=0, y=0},
    soul_pos = { x = 1, y = 0 },
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { Xmultbase = 1.35, Xmultcap = 1.7, Pipisodds = 20, Voiceodds = 100 } },
    loc_vars = function(self, info_queue, card)
        local n1, d1 = SMODS.get_probability_vars(card, 1, card.ability.extra.Voiceodds, 'spamton_voice')
        local n2, d2 = SMODS.get_probability_vars(card, 1, card.ability.extra.Pipisodds, 'spamton_pipis')
        return { vars = { card.ability.extra.Xmultbase, card.ability.extra.Xmultcap, n1, d1, n2, d2 } }
    end,
    calculate = function(self, card, context)
        local voice_odds = card.ability.extra.Voiceodds or 1
        local pipis_odds = card.ability.extra.Pipisodds or 1

        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 14 or
                context.other_card:get_id() == 9 or
                context.other_card:get_id() == 7 then
                if to_big(G.GAME.dollars) >= to_big(G.GAME.interest_cap) then
                    if SMODS.pseudorandom_probability(card, 'spamton_voice', 1, voice_odds, 'spamton_voice') then
                        local sound = pseudorandom_element(SpamtonVoice, 'Spamton')
                        play_sound(sound)
                        return {
                            xmult = card.ability.extra.Xmultcap
                        }
                    else
                        local sound = pseudorandom_element(SpamtonEEEE, 'Spamton')
                        play_sound(sound)
                        return {
                            xmult = card.ability.extra.Xmultcap
                        }
                    end
                else
                    if SMODS.pseudorandom_probability(card, 'spamton_voice', 1, voice_odds, 'spamton_voice') then
                        local sound = pseudorandom_element(SpamtonVoice, 'Spamton')
                        play_sound(sound)
                        return {
                            xmult = card.ability.extra.Xmultbase
                        }
                    else
                        local sound = pseudorandom_element(SpamtonEEEE, 'Spamton')
                        play_sound(sound)
                        return {
                            xmult = card.ability.extra.Xmultbase
                        }
                    end
                end
            end
        end
        if context.setting_blind then
            if SMODS.pseudorandom_probability(card, 'spamton_pipis', 1, pipis_odds, 'spamton_pipis') then
                local card = create_card('Joker', G.Jokers, nil, nil, nil, nil, 'j_btct_Pipis')
                card.sell_cost = -1
                card:add_to_deck()
                G.jokers:emplace(card)
                if SMODS.pseudorandom_probability(card, 'spamton_voice', 1, voice_odds, 'spamton_voice') then
                    local sound = pseudorandom_element(SpamtonVoice, 'Spamton')
                    play_sound(sound)
                    return {
                        xmult = card.ability.extra.Xmultcap,
                        message = 'Pipis',
                        colour = G.C.BLUE
                    }
                else
                    local sound = pseudorandom_element(SpamtonEEEE, 'Spamton')
                    play_sound(sound)
                    return {
                        xmult = card.ability.extra.Xmultbase,
                        message = 'Pipis',
                        colour = G.C.BLUE
                    }
                end
            end
        end
    end
}

-- Pipis
SMODS.Atlas{
    key = 'Pipis',
    path = 'Pipis.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Pipis',
    loc_txt = {
        name = 'Pipis',
        text = {
            'An invasive species',
            'of freshwater clam'
        }
    },
    atlas = 'Pipis',
    pools = {["Batrocities"] = true},

    rarity = 1,
    cost = -2,
    pos = {x=0, y=0},
    pixel_size = { w = 60, h = 48 },
    hidden = true,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { mult = -4, round = 0 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.round } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.round = card.ability.extra.round + 1
        end
        if context.setting_blind then
            if card.ability.extra.round > 0 then
            local card = create_card('Joker', G.Jokers, nil, nil, nil, nil, 'j_btct_Pipis')
            card.sell_cost = -1
            card:add_to_deck()
            G.jokers:emplace(card)
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
    
}

-- Gold Goldfish
SMODS.Atlas{
    key = 'GGFish',
    path = 'GoldGoldfish.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'GGFish',
    loc_txt = {
        name = 'Gold Goldfish',
        text = {
            'Gives {C:money}$#2#{} at end of round,',
            'gains {C:money}$#1#{} per {C:money}Gold{} card in deck'
        }
    },
    atlas = 'GGFish',
    pools = {["Batrocities"] = true},

    rarity = 1,
    cost = 6,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { moneyGain = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_gold

        local gold_amount = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_gold') then gold_amount = gold_amount + 1 end
            end
        end
        return { vars = { card.ability.extra.moneyGain, card.ability.extra.moneyGain * gold_amount } }
    end,
    
    calc_dollar_bonus = function(self, card)
        local gold_amount = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_gold') then gold_amount = gold_amount + 1 end
            end
        return card.ability.extra.moneyGain * gold_amount
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_gold') then
                return true
            end
        end
        return false
    end
}

-- Fortnite Card
SMODS.Atlas{
    key = 'Fortnite', -- ila babaji
    path = 'FortniteCard.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Fortnite',
    loc_txt = {
        name = '$19 Fortnite Card',
        text = {
            'At the {C:attention}end of every round{}',
            'gain {C:money}#1# sell value{}, {C:green}#2# in #3#{} chance',
            'that the code gets stolen.'
        }
  },
    atlas = 'Fortnite',
    pools = {["Batrocities"] = true},

    rarity = 1,
    cost = 5,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,

    config = { extra = { price = 5, odds = 5 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'btct_artcreditPiero', set = 'Other'}
        return { vars = { card.ability.extra.price, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } } 
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if pseudorandom('Fortnite') < G.GAME.probabilities.normal / card.ability.extra.odds then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true;
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = 'Stolen!'
                }
            else
                card.ability.extra_value = card.ability.extra_value + card.ability.extra.price
                card:set_cost()
                return {
                    message = localize('k_val_up'),
                    colour = G.C.MONEY
                }
            end 
        end
    end
}

-- Shuriken Underwear
SMODS.Atlas{
    key = 'ShurikenUnderwear',
    path = 'ShurikenUnderwear.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = 'ShurikenUnderwear',
    
    loc_txt = {
        name = 'Shuriken Underwear',
        text = {
            '{C:green}#2# in #3#{} chance to spawn an {C:attention}Underwear{}', 
            'at start of round, otherwise this',
            'joker destroys an existing {C:attention}Underwear{}. If',
            'there are no {C:attention}Underwear{} to shuriken, this joker',
            'destroys itself. This joker gains {C:mult}+#1#{} Mult per ',
            '{C:attention}Underwear{} shurikened. If you have more than',
            '3 {C:attention}Underwear{} this joker will always shuriken.',
            '{C:inactive}(Currently {C:mult}+#4#{} {C:inactive}Mult){}'
        }
    },
    atlas = 'ShurikenUnderwear',
    pools = {["Batrocities"] = true },
    rarity = 3,
    cost = 9,
    pos = {x = 0, y = 0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
 
    config = { extra = { multbase = 9, oddsoutoff = 3, multcurrent = 0 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.j_btct_Underwear
        return { vars = { card.ability.extra.multbase, (G.GAME.probabilities.normal*2), card.ability.extra.oddsoutoff, card.ability.extra.multcurrent } } 
    end,

    calculate = function(self, card, context)
    if context.setting_blind and not context.blueprint then
        local underweardetection = #SMODS.find_card('j_btct_Underwear')
        if underweardetection < 4 then
            if SMODS.pseudorandom_probability(card, 'ShurikenUnderwear', (G.GAME.probabilities.normal*2), card.ability.extra.oddsoutoff) then
                SMODS.add_card({key = 'j_btct_Underwear', edition = 'e_negative'})
                return {
                    message = 'More!',
                    colour = G.C.FILTER
                    }
            else
                if next(SMODS.find_card('j_btct_Underwear')) then
                    SMODS.destroy_cards(SMODS.find_card('j_btct_Underwear')[1])
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "multcurrent",
                        scalar_value = "multbase",
                        scaling_message = {
                            message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.multbase}},
                            colour = G.C.MULT
                        }})
                else
                    SMODS.destroy_cards(card, nil, nil, true)
                    return {
                    message = 'Shurikened!',
                    colour = G.C.FILTER
                    }
                end
            end
        else
            SMODS.destroy_cards(SMODS.find_card('j_btct_Underwear')[1])
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "multcurrent",
                scalar_value = "multbase",
                scaling_message = {
                    message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.multbase}},
                    colour = G.C.MULT
                }})
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.multcurrent
            }
        end
    end
}

-- Underwear
SMODS.Atlas{
    key = 'Underwear',
    path = 'Underwear.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = 'Underwear',
    
    loc_txt = {
        name = 'Underwear',
        text = {
            'Target Practice'
        }
    },
    atlas = 'Underwear',
    pools = {["Batrocities"] = true },
    rarity = 1,
    cost = 0,
    pos = {x = 0, y = 0},
    pixel_size = { w = 71, h = 50 },
    hidden = true,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    config = { extra = {} },
}

-- Banana Tetris
SMODS.Atlas{
    key = 'BananaTetrisAtlas',
    path = 'BananaTetris.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = 'BananaTetris',
    
    loc_txt = {
        name = 'Banana Tetris',
        text = {
            'Scored cards permanently',
            'gain {X:red,C:white}X#1#{} Mult'
        }
    },
    atlas = 'BananaTetrisAtlas',
    pools = {["Batrocities"] = true },
    rarity = "btct_Elite",
    cost = 12,
    pos = {x = 0, y = 0},
    soul_pos = { x = 0, y = 1},
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    config = { extra = { xmult = 0.05 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_x_mult = (context.other_card.ability.perma_x_mult or 0) +
                card.ability.extra.xmult
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
        end
    end
}

-- Floppr
SMODS.Atlas{
    key = 'FlopprAtlas',
    path = 'Floppr.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = 'Floppr',
    
    loc_txt = {
        name = 'Floppr',
        text = {
            'Aces give {X:red,C:white}X#1#{} Mult when scored'
        }
    },
    atlas = 'FlopprAtlas',
    pools = {["Batrocities"] = true },
    rarity = "btct_Elite",
    cost = 14,
    pos = {x = 0, y = 0},
    soul_pos = { x = 1, y = 0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    config = { extra = { xmult = 2, checkmark = false, to_base = false } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 14 then
            checkmark = true
            to_base = true
            return {
                xmult = card.ability.extra.xmult
            }
        end
        --[[if context.final_scoring_step then
            if checkmark then
                self.soul_pos.y = 2
                self.soul_pos.x = 0
                checkmark = false
            else
                self.soul_pos.y = 6
                self.soul_pos.x = 0
            end
        end]]
    end
}

-- Kuraku
SMODS.Atlas{
    key = 'KurakuAtlas',
    path = 'Kuraku.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = 'Kuraku',
    
    loc_txt = {
        name = 'Kuraku',
        text = {
            'Scored 2s, 3s, 4s, and 5s give ',
            '{X:red,C:white}X#1#{} Mult when scored.',
            '{X:red,C:white}Xmult{} is increased by {X:red,C:white}X#3#{} Mult',
            'per played 2, 3, 4, or 5',
            'if it is played only once, otherwise ',
            'it gains {X:red,C:white}X#2#{} Mult.',
            'Resets after hand played '
            --[['AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
            'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
            'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
            'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
            'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
            'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
            'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
            'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
            'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',]]--
        }
    },
    atlas = 'KurakuAtlas',
    pools = {["Batrocities"] = true },
    rarity = "btct_Elite",
    cost = 14,
    pos = {x = 0, y = 0},
    soul_pos = { x = 1, y = 0},
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    config = { extra = { xmult = 1.5, xmult_gain = 0.15, xmult_gain_unique = 0.25 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain, card.ability.extra.xmult_gain_unique } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind then
            local active2 = true
            local active3 = true
            local active4 = true
            local active5 = true
            card.ability.extra.xmult = 1.5
        end
        if context.before then
            local active2 = true
            local active3 = true
            local active4 = true
            local active5 = true
            for k, v in pairs(context.scoring_hand) do
                if v:get_id() == 2 and active2 then
                    active2 = false;
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain_unique
                elseif v:get_id() == 3 and active3 then
                    active3 = false;
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain_unique
                elseif v:get_id() == 4 and active4 then
                    active4 = false;
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain_unique
                elseif v:get_id() == 5 and active5 then
                    active5 = false;
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain_unique
                elseif v:get_id() == 2 or v:get_id() == 3 or v:get_id() == 4 or v:get_id() == 5 then
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                end
            end
        end
        if context.individual and context.cardarea == G.play and (context.other_card:get_id() == 2 or context.other_card:get_id() == 3 or context.other_card:get_id() == 4 or context.other_card:get_id() == 5 ) then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.after then
            local active2 = true
            local active3 = true
            local active4 = true
            local active5 = true
        end
        if context.after and context.individual then
            card.ability.extra.xmult = 1.5
        end
    end
}

-- Doneinone
SMODS.Atlas{
    key = 'Doneinone',
    path = 'Doneinone.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Doneinone',
    loc_txt = {
        name = 'Doneinone',
        text = {
            'Scored {C:attention}Jacks{} permanently gain {X:red,C:white}X#1#{} Mult',
            'Scored {C:attention}Spades{} permanently gain {C:chips}+#2#{} Chips',
            'Retriggers {C:attention}Jacks{} of {C:spades}Spades{}'
        }
    },
    atlas = 'Doneinone',
    pools = {["Batrocities"] = true},

    rarity = 'btct_Elite',
    cost = 12,
    pos = {x=0, y=0},
    soul_pos = { x = 1, y = 0},
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { JackMult = 0.05, SpadeChips = 10, repetitions = 1}, },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'btct_artcreditDoneInOne', set = 'Other'}
        return { vars = { card.ability.extra.JackMult, card.ability.extra.SpadeChips} }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 11 and not context.other_card.debuff then
            if context.other_card:is_suit("Spades") then
                context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) +
                card.ability.extra.SpadeChips
                context.other_card.ability.perma_x_mult = (context.other_card.ability.perma_x_mult or 0) +
                card.ability.extra.JackMult
                return {
                  message = localize('k_upgrade_ex'),
                    colour = G.C.UI.TEXT_INACTIVE
                }
            else
            context.other_card.ability.perma_x_mult = (context.other_card.ability.perma_x_mult or 0) +
                card.ability.extra.JackMult
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
        end
        end
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Spades") and not context.other_card.debuff then
            context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) +
                card.ability.extra.SpadeChips
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS
            }
        end
        if context.repetition and context.cardarea == G.play and context.other_card:get_id() == 11 and context.other_card:is_suit("Spades") then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end
}

-- 3
SMODS.Atlas{
    key = '3',
    path = '3.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = '3',
    loc_txt = {
        name = '3',
        text = {
            'If played hand contains a {C:attention}Three of a Kind{}', 
            'and three {C:attention}3s{}, the first three {C:attention}3s{}',
            'give {X:red,C:white}X#1#{} Mult when scored'
        }
    },
    atlas = '3',
    pools = {["Batrocities"] = true},

    rarity = "btct_Elite",
    cost = 13,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
     config = { extra = { xmult = 3, type = 'Three of a Kind' } },
   loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, localize(card.ability.extra.type, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and next(context.poker_hands[card.ability.extra.type]) then
            if (context.other_card:get_id() == 3 and context.other_card == context.scoring_hand[1]) or (context.other_card:get_id() == 3 and context.other_card == context.scoring_hand[2]) or (context.other_card:get_id() == 3 and context.other_card == context.scoring_hand[3]) then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        end
    end
}

-- Swarmling
SMODS.Atlas{
    key = 'Swarmling',
    path = 'Swarmling.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Swarmling',
    loc_txt = {
        name = 'Swarmling',
        text = {
            '{X:red,C:white}X#1#{} Mult, double Mult', 
            'per other {C:attention}Swarmling{}'
        }
    },
    atlas = 'Swarmling',
    pools = {["Batrocities"] = true},

    rarity = 1,
    cost = 5,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { xmult = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        swarmlingcount = 0
        card.ability.extra.xmult = 1
        for i = 1, #G.jokers.cards do
             if G.jokers.cards[i].config.center.key == "j_btct_Swarmling" then
                swarmlingcount = swarmlingcount + 1
            end
        end
        for i = 1, swarmlingcount - 1 do
                card.ability.extra.xmult = card.ability.extra.xmult * 2
        end
         if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

-- Infinitesimal Extremity
SMODS.Atlas{
    key = 'Infinitesimal',
    path = 'InfinitesimalExtremity.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Infinitesimal',
    loc_txt = {
        name = 'Infinitesimal Extremity',
        text = {
            '{X:red,C:white}X#1#{} Mult, {X:red,C:white}X#2#{} less mult per', 
            '{C:attention}card{} in played hand.'
        }
    },
    atlas = 'Infinitesimal',
    pools = {["Batrocities"] = true},
    rarity = 3,
    cost = 10,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { xmult = 6, xmultLoss = 1 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmultLoss } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult - (card.ability.extra.xmultLoss * #context.full_hand)
            }
        end
    end
}

-- Checkmate
SMODS.Atlas{
   key = 'Checkmate',
   path = 'Checkmate.png',
   px = 71,
   py = 95
}


SMODS.Joker{
    key = 'Checkmate',
    loc_txt = {
        name = 'Checkmate',
        text = {
            'If played hand contains a {C:attention}King{},',
            'destroy the {C:attention}first{} king scored',
            'and this Joker gains {C:chips}+#2#{} Chips.',
            '{C:inactive}(Currently:{} {C:chips}+#1#{}{C:inactive} Chips){}'
        }
    },
    atlas = 'Checkmate',
    pools = {["Batrocities"] = true},


    rarity = 2,
    cost = 6,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,


    config = { extra = { currentChips = 0, addChips = 20 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.currentChips, card.ability.extra.addChips } }
    end,
    calculate = function(self, card, context)
        local is_first_face = nil
        if context.joker_main then
            for _, playing_card in ipairs(context.scoring_hand) do 
                if playing_card:get_id() == 13 and not playing_card.debuff then 
                    is_first_face = playing_card
                    break
                end
            end
            if is_first_face then
                card.ability.extra.currentChips = card.ability.extra.currentChips + card.ability.extra.addChips
                SMODS.destroy_cards(is_first_face)
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.BLUE,
                }
            end
            return {
                chips = card.ability.extra.currentChips
            }
        end
    end
}

--[[ Exponential Flush
SMODS.Atlas{
   key = 'ExponentialFlush',
   path = 'ExponentialFlush.png',
   px = 71,
   py = 95
}


SMODS.Joker{
   key = 'ExponentialFlush',
   loc_txt = {
       name = 'Exponential Flush',
       text = {
           'This Joker {C:attention}Multiplies{} its {X:red,C:white}XMult{}',
           'by {X:red,C:white}X#2#{} if played hand',
           'contains a {C:attention}Straight Flush{}',
           '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
       }
   },
   atlas = 'ExponentialFlush',
   pools = {["Batrocities"] = true},


   rarity = 3,
   cost = 10,
   pos = {x=1, y=0},
   unlocked = true,
   discovered = false,
   blueprint_compat = true,
   eternal_compat = true,
   perishable_compat = true,
   config = { extra = { xmult = 1, xmultScale = 1.25, type = 'Straight Flush' }, },
   loc_vars = function(self, info_queue, card)
       return { vars = { card.ability.extra.xmult, card.ability.extra.xmultScale, localize(card.ability.extra.type, 'poker_hands') } }
   end,
   calculate = function(self, card, context)
       if context.before and not context.blueprint and next(context.poker_hands[card.ability.extra.type]) then
           card.ability.extra.xmult = card.ability.extra.xmult * card.ability.extra.xmultScale
           return {
               message = localize('k_upgrade_ex'),
               colour = G.C.RED
           }
       end
       if context.joker_main then
           return {
               xmult = card.ability.extra.xmult
           }
       end
   end
}]]--

-- Limbo
SMODS.Atlas{
   key = 'Limbo',
   path = 'Limbo.png',
   px = 71,
   py = 95
}
SMODS.Joker{
   key = 'Limbo',
   loc_txt = {
       name = 'Limbo',
       text = {
           '{X:red,C:white}X#1#{} Mult, flip and',
           'shuffle all {C:attention}Joker{} cards',
           'at start of round'
       }
   },
   atlas = 'Limbo',
   pools = {["Batrocities"] = true},


   rarity = 3,
   cost = 8,
   pos = {x=0, y=0},
   unlocked = true,
   discovered = false,
   blueprint_compat = true,
   eternal_compat = true,
   perishable_compat = true,
   config = { extra = { xmult = 4 }, },
   loc_vars = function(self, info_queue, card)
       return { vars = { card.ability.extra.xmult} }
   end,
        calculate = function(self, card, context)
           local passed = true
           for k, v in pairs(G.jokers.cards) do
              if v.facing ~= 'back' then passed = false end
          end
           if passed == false then
             if context.setting_blind and not context.blueprint then
                 if #G.jokers.cards > 0 then
                     G.jokers:unhighlight_all()
                     for _, joker in ipairs(G.jokers.cards) do
                         joker:flip()
                       end
                       if #G.jokers.cards > 1 then
                           G.E_MANAGER:add_event(Event({
                               trigger = 'after',
                               delay = 0.2,
                               func = function()
                                   G.E_MANAGER:add_event(Event({
                                       func = function()
                                           G.jokers:shuffle('aajk')
                                           play_sound('cardSlide1', 0.85)
                                           return true
                                       end,
                                   }))
                                   delay(0.15)
                                   G.E_MANAGER:add_event(Event({
                                       func = function()
                                           G.jokers:shuffle('aajk')
                                           play_sound('cardSlide1', 1.15)
                                           return true
                                       end
                                   }))
                                   delay(0.15)
                                   G.E_MANAGER:add_event(Event({
                                       func = function()
                                           G.jokers:shuffle('aajk')
                                           play_sound('cardSlide1', 1)
                                           return true
                                       end
                                   }))
                                   delay(0.5)
                                   return true
                               end
                           }))
                       end
                   end
               end
           end
           if context.joker_main then
           return {
               xmult = card.ability.extra.xmult
           }
           end
       end
}

--[[ Blender
SMODS.Atlas{
   key = 'Blender',
   path = 'Blender.png',
   px = 71,
   py = 95
}


SMODS.Joker{
   key = 'Blender',
   loc_txt = {
       name = 'Blender',
       text = {
           'If the first played hand',
           'contains only {C:attention}1{} card,',
           'give it a random {C:dark_edition}edition{},',
           '{C:enhanced}enhancement{} and/or {C:attention}seal{},',
           'or {C:attention}duplicate{} it, or',
           '{C:attention}destroy{} it.'
       }
   },
   atlas = 'Blender',
   pools = {["Batrocities"] = true},
   rarity = 2,
   cost = 5,
   pos = {x=0, y=0},
   unlocked = true,
   discovered = false,
   blueprint_compat = false,
   eternal_compat = true,
   perishable_compat = true,
   config = { extra = { oddsSeal = 3, oddsEdition = 5 } },
   loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'btct_artcreditDoneInOne', set = 'Other'}
        return { vars = { card.ability.extra.oddsSeal, card.ability.extra.oddsEdition, G.GAME.probabilities.normal} }
   end,
   calculate = function(self, card, context)
       if context.first_hand_drawn then
           local eval = function() return G.GAME.current_round.hands_used == 0 and not G.RESET_JIGGLES end
           juice_card_until(card, eval, true)
        end
           if context.before and context.full_hand[1] and G.GAME.current_round.hands_played == 0 and #context.full_hand == 1 then
           local num = math.random(1,3)
           if num == 1 then -- Enhance / Seal / Edition
               local random_enhancement = SMODS.poll_enhancement {key = "btct_Blender", guaranteed = true}
               card:set_ability(random_enhancement)
               local seal = math.random(1,card.ability.extra.oddsSeal)
               local edition = math.random(1,card.ability.extra.oddsEdition)
               if seal >= G.GAME.probabilities.normal then
                   local random_seal = SMODS.poll_seal {key = "btct_Blender", guaranteed = true}
                   card:set_seal(random_seal)
               end
               if edition == G.GAME.probabilities.normal then
                   local random_edition = SMODS.poll_edition { key = "btct_Blender", guaranteed = true, no_negative = true }
                   card:set_edition(random_edition)
               end
           elseif num == 2 then -- Destroy / Copy
               local decider = math.random(1,2)
               if decider == 1 then
                   G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                   local card_copied = copy_card(context.full_hand[1], nil, nil, G.playing_card)
                   card_copied:add_to_deck()
                   G.deck.config.card_limit = G.deck.config.card_limit + 1
                   table.insert(G.playing_cards, card_copied)
                   G.hand:emplace(card_copied)
                   card_copied.states.visible = nil
                   G.E_MANAGER:add_event(Event({
                   func = function()
                       card_copied:start_materialize()
                       return true
                   end
                   }))
                   return {
                      message = localize('k_copied_ex'),
                       colour = G.C.CHIPS,
                       func = function()
                         G.E_MANAGER:add_event(Event({
                             func = function()
                                 SMODS.calculate_context({ playing_card_added = true, cards = { card_copied } })
                                 return true
                             end
                         }))
                   end
                   }
               else
                   return {
                       remove = true,
                       delay = 0.45
                   }
               end
           elseif num == 3 then -- Literally nothing :)
               return {
                   message = 'No :)',
                   colour = G.C.FILTER
               }
           end
       end
   end
}

--//DISINTEGRATIONLOOP
SMODS.Atlas{
    key = '8-3',
    path = 'DisintegrationLoop.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = '8-3',
    loc_txt = {
        name = '//DISINTEGRATION LOOP',
        text = {
            'Played {C:attention}8s{} have a {C:attention}fixed{} {C:green}#4# in #3#{} ', --if its really FIXED, then odds1 and odds2 should not be made in config
            'chance to give {X:red,C:white}X#1#{} Mult when {C:attention}scored{}',
            'Otherwise, gain a random {C:planet}Planet{} card'
        }
    },
    atlas = '8-3',
    pools = {["Batrocities"] = true},

    rarity = 3,
    cost = 8,
    pos = {x=0, y=0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { xmult = 1.5, odds1 = 1, odds2 = 5} },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            (context.other_card:get_id() == 8) then
            if pseudorandom('8-3', card.ability.extra.odds1, card.ability.extra.odds2) ~= 5 then
                return {
                    xmult = card.ability.extra.xmult
                }
            else
                extra = {
                        message = localize('k_plus_planet'),
                        message_card = card,
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = (function()
                                    SMODS.add_card {
                                        set = 'Planet',
                                        key_append = '8-3'
                                    }
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end)
                            }))
                        end
                    }
            end
        end
    end,
}]]--

-- Hook?
local oldenegativegetweight = G.P_CENTERS.e_negative.get_weight
SMODS.Edition:take_ownership('negative', {
    get_weight = function(self)
        local weight = oldenegativegetweight(self)
        return weight * 5 ^ #SMODS.find_card("j_btct_EvilAndTwisted2006ChevySilverado")
    end
}, true)

-- to_big thingy (Thanks My GOAT N')
to_big = to_big or function(x) return x end

-- BananaTetrisAnimation
local btct = {ticks = (5)}
local upd = Game.update
local btct_BananaTetris_dt = 0
function Game:update(dt)
    upd(self, dt)
    local BananaTetrisobj = G.P_CENTERS.j_btct_BananaTetris
    btct_BananaTetris_dt = btct_BananaTetris_dt + dt
    if BananaTetrisobj and btct_BananaTetris_dt > 0.1 then
        btct_BananaTetris_dt = btct_BananaTetris_dt - 0.1
        if BananaTetrisobj.pos.x > 94 then 
            BananaTetrisobj.pos.x = 0 
        else
            BananaTetrisobj.pos.x = BananaTetrisobj.pos.x + 1
        end
    end
    for k, v in pairs(G.I.CARD) do
	    if v.children.joker and v.children.joker.atlas == G.ASSET_ATLAS["btct_BananaTetrisAtlas"] then
	    	v.children.joker:set_sprite_pos(BananaTetrisobj.pos)
	    end
    end
end

-- 3Animation
local btct = {ticks = (5)}
local upd = Game.update
local btct_3_dt = 0
function Game:update(dt)
    upd(self, dt)
    local Threeobj = G.P_CENTERS.j_btct_3
    btct_3_dt = btct_3_dt + dt
    if Threeobj and btct_3_dt > 0.1 then
        btct_3_dt = btct_3_dt - 0.1
        if Threeobj.pos.x > 35 then 
            Threeobj.pos.x = 0 
        else
            Threeobj.pos.x = Threeobj.pos.x + 1
        end
    end
    for k, v in pairs(G.I.CARD) do
        if v.children.joker and v.children.joker.atlas == G.ASSET_ATLAS["btct_3Atlas"] then
            v.children.joker:set_sprite_pos(Threeobj.pos)
        end
    end
end

--[[ FlopprAnimations
local btct = {ticks = (5)}
local upd = Game.update
local btct_Floppr_dt = 0
function Game:update(dt)
    upd(self, dt)
    local Flopprobj = G.P_CENTERS.j_btct_Floppr
    btct_Floppr_dt = btct_Floppr_dt + dt
    if Flopprobj and btct_Floppr_dt > 0.1 and Flopprobj.soul_pos.y == 1 then
        btct_Floppr_dt = btct_Floppr_dt - 0.1
        if Flopprobj.soul_pos.x > 2 then 
            Flopprobj.soul_pos.x = 1 
            Flopprobj.soul_pos.y = 0 
        else
            G.E_MANAGER:add_event(Event({
                trigger = "immediate", 
                delay = 0.1, 
                func = function() 
                    Flopprobj.soul_pos.x = Flopprobj.soul_pos.x + 1
                    return true 
                end
            }))
        end
    elseif Flopprobj and btct_Floppr_dt > 0.1 and Flopprobj.soul_pos.y == 2 then
        btct_Floppr_dt = btct_Floppr_dt - 0.1
        if Flopprobj.soul_pos.x > 2 then 
            if Flopprobj.config.extra.to_base then
                Flopprobj.config.extra.to_base = false
                Flopprobj.soul_pos.x = 0
                Flopprobj.soul_pos.y = 7 
            end
        else
            G.E_MANAGER:add_event(Event({
                trigger = "immediate", 
                delay = 0.1, 
                func = function() 
                    Flopprobj.soul_pos.x = Flopprobj.soul_pos.x + 1
                    return true 
                end
            }))
        end
    elseif Flopprobj and btct_Floppr_dt > 0.1 and Flopprobj.soul_pos.y == 3 then
        btct_Floppr_dt = btct_Floppr_dt - 0.1
        if Flopprobj.soul_pos.x > 2 then 
            Flopprobj.soul_pos.x = 0 
        else
            Flopprobj.soul_pos.x = Flopprobj.soul_pos.x + 1
        end
    elseif Flopprobj and btct_Floppr_dt > 0.1 and Flopprobj.soul_pos.y == 4 then
        btct_Floppr_dt = btct_Floppr_dt - 0.1
        if Flopprobj.soul_pos.x > 10 then 
            Flopprobj.soul_pos.x = 0 
            Flopprobj.soul_pos.y = 1 
        else
            Flopprobj.soul_pos.x = Flopprobj.soul_pos.x + 1
        end
    elseif Flopprobj and btct_Floppr_dt > 0.1 and Flopprobj.soul_pos.y == 5 then
        btct_Floppr_dt = btct_Floppr_dt - 0.1
        if Flopprobj.soul_pos.x > 11 then 
            Flopprobj.soul_pos.x = 0 
        else
            Flopprobj.soul_pos.x = Flopprobj.soul_pos.x + 1
        end
    elseif Flopprobj and btct_Floppr_dt > 0.1 and Flopprobj.soul_pos.y == 6 then
        btct_Floppr_dt = btct_Floppr_dt - 0.1
        if Flopprobj.soul_pos.x > 12 then 
            Flopprobj.soul_pos.x = 0 
            Flopprobj.soul_pos.y = 1 
        else
            Flopprobj.soul_pos.x = Flopprobj.soul_pos.x + 1
        end
    elseif Flopprobj and btct_Floppr_dt > 0.1 and Flopprobj.soul_pos.y == 7 then
        btct_Floppr_dt = btct_Floppr_dt - 0.1
        if Flopprobj.soul_pos.x > 16 then 
            Flopprobj.soul_pos.x = 0 
            Flopprobj.soul_pos.y = 1 
        else
            G.E_MANAGER:add_event(Event({
                trigger = "immediate", 
                delay = 0.1, 
                func = function() 
                    Flopprobj.soul_pos.x = Flopprobj.soul_pos.x + 1
                    return true 
                end
            }))
        end
    end
    for k, v in pairs(G.I.CARD) do
	    if v.children.floating_sprite and v.children.floating_sprite.atlas == G.ASSET_ATLAS["btct_FlopprAtlas"] then
	    	v.children.floating_sprite:set_sprite_pos(Flopprobj.soul_pos)
	    end
    end
end]]--

-----------------------------------------------------------
----------- MOD CODE END ----------------------------------
