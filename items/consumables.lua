--[[ Setting Potion Consumable Type
SMODS.ConsumableType {
    key = 'btct_Potion',
    default = 'c_strength',
    loc_txt = {
        name = "Potion"
    },
    primary_colour = HEX('c5dee0'),
    secondary_colour = HEX('c5dee0'),
    collection_rows = { 5, 6 },
    shop_rate = 4
}]]--

-- Planets 

-- Stardust
SMODS.Atlas{
    key = 'atlas_btct_consumeables_Stardust',
    path = 'Stardust.png',
    px = 71,
    py = 95,
}

SMODS.Consumable {
    atlas = 'atlas_btct_consumeables_Stardust',
    key = 'Stardust',
    set = 'Planet',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "Stardust",
        text={
        'Level up a random',
        'Poker Hand {C:attention}twice{}'
        },
    },
    config = { hand_type = 'High Card' },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                
            }
        }
    end,

    use = function(self, card, area)
        card.ability.hand_type = get_random_hand()
        SMODS.smart_level_up_hand(card, card.ability.hand_type, instant, 2)
    end
}

-- Tarots 

-- Blood Moon
SMODS.Atlas{
    key = 'atlas_btct_consumeables_BloodMoon',
    path = 'BloodMoonTarot.png',
    px = 71,
    py = 95,
}

SMODS.Consumable {
    atlas = "atlas_btct_consumeables_BloodMoon",
    key = 'BloodMoon',
    set = 'Tarot',
    pos = { x = 0, y = 0 },
    config = { extra = { seal = 'btct_SealCrimson' }, max_highlighted = 1 },
    loc_txt = {
        name = "Blood Moon",
        text={
        'Add a {C:red}Crimson Seal{} to',
         '{C:attention}#1#{} selected card.'
        },
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conv_card:set_seal(card.ability.extra.seal, nil, true)
                return true
            end
        }))

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,
}

-- Blue Moon
SMODS.Atlas{
    key = 'atlas_btct_consumeables_BlueMoon',
    path = 'BlueMoonTarot.png',
    px = 71,
    py = 95,
}

SMODS.Consumable {
    atlas = "atlas_btct_consumeables_BlueMoon",
    key = 'BlueMoon',
    set = 'Tarot',
    pos = { x = 0, y = 0 },
    config = { extra = { seal = 'btct_SealCerulean' }, max_highlighted = 1 },
    loc_txt = {
        name = "Blue Moon",
        text={
        'Add a {C:blue}Cerulean Seal{} to',
         '{C:attention}#1#{} selected card.'
        },
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conv_card:set_seal(card.ability.extra.seal, nil, true)
                return true
            end
        }))

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,
}

-- Weaken
SMODS.Atlas{
    key = 'atlas_btct_consumeables_Weaken',
    path = 'WeakenTarot.png',
    px = 71,
    py = 95,
}

SMODS.Consumable {
    atlas = "atlas_btct_consumeables_Weaken",
    key = 'Weaken',
    set = 'Tarot',
    pos = { x = 0, y = 0 },
    config = { max_highlighted = 1 },
    loc_txt = {
        name = "Weaken",
        text={
        'Decreases rank of {C:attention}#1#{}',
        'selected card by {C:attention}1{}.',
        },
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    assert(SMODS.modify_rank(G.hand.highlighted[i], -1))
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
}

--[[ Stargaze
SMODS.Atlas{
    key = 'atlas_btct_consumeables_Stargaze',
    path = 'StargazeTarot.png',
    px = 71,
    py = 95,
}

SMODS.Consumable {
    atlas = 'atlas_btct_consumeables_Stargaze',
    key = 'stargaze',
    set = 'Tarot',
    pos = { x = 0, y = 0 },
    config = { max_highlighted = 2, mod_conv = 'm_btct_astral' },
    loc_txt = {
        name = "Stargaze",
        text={
        'Enhances {C:attention}#1#{}',
        'selected cards to',
        '{C:attention}Astral Cards{}',
        },
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}]]--

-- Geode
SMODS.Atlas{
    key = 'atlas_btct_consumeables_Geode',
    path = 'GeodeTarot.png',
    px = 71,
    py = 95,
}

SMODS.Consumable {
    atlas = 'atlas_btct_consumeables_Geode',
    key = 'Geode',
    set = 'Tarot',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "Geode",
        text={
        '{C:green}#1# in #2#{} chance to add',
        --'{C:dark_edition}Antique{} or {C:dark_edition}Gemstone{}',
        '{C:dark_edition}Gemstone{}',
        'to a random {C:attention}Joker{}',
        },
    },

    config = { extra = { odds = 3 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'btct_Geode')
        return { vars = { numerator, denominator } }
    end,

    use = function(self, card, area, copier)
        if SMODS.pseudorandom_probability(card, 'btct_Geode', 1, card.ability.extra.odds) then
            local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)

            local eligible_card = pseudorandom_element(editionless_jokers, 'btct_Geode')
            local edition = poll_edition('btct_Geode', nil, true, true, { 'e_btct_gemstone', 'e_btct_gemstone' } )
            eligible_card:set_edition(edition, true)
            check_for_unlock({ type = 'have_edition' })
        else
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    attention_text({
                        text = localize('k_nope_ex'),
                        scale = 1.3,
                        hold = 1.4,
                        major = card,
                        backdrop_colour = G.C.SECONDARY_SET.Tarot,
                        align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                            'tm' or 'cm',
                        offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                        silent = true
                    })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.06 * G.SETTINGS.GAMESPEED,
                        blockable = false,
                        blocking = false,
                        func = function()
                            play_sound('tarot2', 0.76, 0.4)
                            return true
                        end
                    }))
                    play_sound('tarot2', 1, 0.4)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
    end,
    can_use = function(self, card)
        return next(SMODS.Edition:get_edition_cards(G.jokers, true))
    end
}

-- Super Win
SMODS.Atlas{
    key = 'atlas_btct_consumeables_SuperWin',
    path = 'SuperWinTarot.png',
    px = 71,
    py = 95,
}

SMODS.Consumable {
    atlas = 'atlas_btct_consumeables_SuperWin',
    key = 'superWin',
    set = 'Tarot',
    pos = { x = 0, y = 0 },
    config = { max_highlighted = 2, mod_conv = 'm_btct_counterfeit' },
    loc_txt = {
        name = "SUper wiN 9REAL!!!11!!)",
        text={
        'Enhances {C:attention}#1#{}',
        'selected cards to',
        '{C:attention}Counterfeit Cards{}',
        },
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}

-- Spectrals 

-- Corrupt
SMODS.Atlas{
    key = 'atlas_btct_consumeables_corrupt',
    path = 'Corrupt.png',
    px = 71,
    py = 95,
}

SMODS.Consumable({
    key = "Corrupt",
    set = "Spectral",
    object_type = "Consumable",
    name = "Corrupt",
    loc_txt = {
        name = "Corrupt",
        text={
        'Select {C:attention}#1#{} playing card, {C:green}#2# in #3#{} chance to',
        'apply {C:dark_edition}Negative{} to the selected card.',
        },
    },

	pos = {x = 0, y = 0},
	order = 99,
	atlas = "atlas_btct_consumeables_corrupt",
    unlocked = true,
    cost = 4,
    hidden = false,
    config = {
        max_highlighted = 1,
        odds = 2,
    },

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.odds, 'btct_Corrupt')
        info_queue[#info_queue + 1] = {set = "Edition", key = "e_negative_playing_card", vars = {1}, config = {extra = 1}}
        return {vars = {(card.ability or self.config).max_highlighted, numerator, denominator}}
    end,
    
    use = function(self, card, area, copier)
        if SMODS.pseudorandom_probability(card, 'btct_Corrupt', 1, card.ability.odds) then
            local corrupt_card = G.hand.highlighted[1]
            corrupt_card:set_edition("e_negative")
            card:juice_up(0.3, 0.5)
        else
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    attention_text({
                        text = localize('k_nope_ex'),
                        scale = 1.3,
                        hold = 1.4,
                        major = card,
                        backdrop_colour = G.C.SECONDARY_SET.Spectral,
                        align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                            'tm' or 'cm',
                        offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                        silent = true
                    })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.06 * G.SETTINGS.GAMESPEED,
                        blockable = false,
                        blocking = false,
                        func = function()
                            play_sound('tarot1', 0.76, 0.4)
                            return true
                        end
                    }))
                    play_sound('tarot1', 1, 0.4)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
    end,
})

-- Mixup
SMODS.Atlas{
    key = 'atlas_btct_consumeables_mixup',
    path = 'Mixup.png',
    px = 71,
    py = 95,
}

SMODS.Consumable({
    key = "Mixup",
    set = "Spectral",
    object_type = "Consumable",
    name = "Mixup",
    loc_txt = {
        name = "Mixup",
        text={
        'Select up to {C:attention}#1#{} playing cards,',
        'give them a random enhancement',
        },
    },

	pos = {x=0, y= 0},
	order = 99,
	atlas = "atlas_btct_consumeables_mixup",
    unlocked = true,
    cost = 4,
    hidden = false,

    config = {
        max_highlighted = 4,
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {(card.ability or self.config).max_highlighted}}
    end,
    
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    local random_enhancement = SMODS.poll_enhancement {key = "btct_Mixup", guaranteed = true}
                    G.hand.highlighted[i]:set_ability(random_enhancement)
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
})

-- Duality
--[[SMODS.Atlas{
    key = 'atlas_btct_consumeables_Duality',
    path = 'Duality.png',
    px = 71,
    py = 95,
}

SMODS.Consumable {
    atlas = 'atlas_btct_consumeables_Duality',
    key = 'Duality',
    set = 'Spectral',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "Duality",
        text={
        'Add a {V:2}White{} or {V:1}Black{}', 
        'seal to {C:attention}1{} selected',
        'card in your hand'
        },
    },
     config = { extra = { whiteSeal = 'btct_SealWhite', blackSeal = 'btct_SealBlack' }, max_highlighted = 1 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return { vars = {colours = { HEX('161616'), HEX('bdbdbd') }}, { card.ability.max_highlighted }}
    end,
     use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                if (pseudorandom("atlas_btct_consumeables_Duality",1, 2)) == 1 then
                    conv_card:set_seal(card.ability.extra.whiteSeal, nil, true)
                else
                    conv_card:set_seal(card.ability.extra.blackSeal, nil, true)
                end    
                return true
            end
        }))

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,
}]] -- made hidden cause both seals annoying

-- Empower
SMODS.Atlas{
    key = 'atlas_btct_consumeables_Empower',
    path = 'Empower.png',
    px = 71,
    py = 95,
}

SMODS.Consumable {
    atlas = 'atlas_btct_consumeables_Empower',
    key = 'Empower',
    set = 'Spectral',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "Empower",
        text={
        '{C:attention}Halve{} your {C:money}money{},',
        'Give a random Joker {C:dark_edition}Overcharged{}',
        'and destroy all other {C:attention}Jokers{}',
        },
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_btct_overcharged
        return { vars = { G.GAME.ecto_minus or 1 } }
    end,

    use = function(self, card, area, copier)
        local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local eligible_card = pseudorandom_element(editionless_jokers, pseudoseed('hex'))
                eligible_card:set_edition({ btct_overcharged = true })

                local _first_dissolve = nil
                for _, joker in pairs(G.jokers.cards) do
                    if joker ~= eligible_card and (not joker.ability.eternal) then
                        joker:start_dissolve(nil, _first_dissolve)
                        _first_dissolve = true
                    end
                end
                card:juice_up(0.3, 0.5)
                ease_dollars(math.floor(-G.GAME.dollars / 2), true)
                return true
            end
        }))
    end,
    can_use = function(self, card)
        return next(SMODS.Edition:get_edition_cards(G.jokers, true))
    end
}

-- Crystal
SMODS.Atlas{
    key = 'atlas_btct_consumeables_Crystal',
    path = 'Crystal.png',
    px = 71,
    py = 95,
}

SMODS.Consumable {
    atlas = 'atlas_btct_consumeables_Crystal',
    key = 'Crystal',
    set = 'Spectral',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "Crystal",
        text={
        'Select up to {C:attention}#1#{}',
        'cards, make them {C:attention}Glass{}',
        'or give them {C:dark_edition}Gemstone{} edition',
        },
    },
    config = { extra = { gemstone = 'btct_gemstone', }, max_highlighted = 2 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        info_queue[#info_queue + 1] = G.P_CENTERS.e_btct_gemstone
        return { vars = {(card.ability or self.config).max_highlighted}}
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    if (pseudorandom("atlas_btct_consumeables_Crystal", 1, 2)) == 1 then
                        G.hand.highlighted[i]:set_ability('m_glass', nil, false)
                    else
                        G.hand.highlighted[i]:set_edition('e_btct_gemstone', nil, false)
                    end    
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
}

-- Thunderstorm
SMODS.Atlas{
    key = 'atlas_btct_consumeables_Thunderstorm',
    path = 'Thunderstorm.png',
    px = 71,
    py = 95,
}

SMODS.Consumable {
    atlas = 'atlas_btct_consumeables_Thunderstorm',
    key = 'Thunderstorm',
    set = 'Spectral',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "Thunderstorm",
        text={
        'Select {C:attention}#1#{} card,',
        '{C:green}#2# in #3#{} chance to apply',
        '{C:dark_edition}Overcharged{}, otherwise',
        '{C:attention}destroy{} the card'
        },
    },

    order = 99,
    unlocked = true,
    cost = 4,
    hidden = false,
    config = {
        max_highlighted = 1,
        odds = 2,
    },

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.odds, 'btct_Corrupt')
        info_queue[#info_queue + 1] = {set = "Edition", key = "e_btct_overcharged", vars = {1}, config = {extra = 1}}
        return {vars = {(card.ability or self.config).max_highlighted, numerator, denominator}}
    end,
    
    use = function(self, card, area, copier)
        if SMODS.pseudorandom_probability(card, 'btct_Corrupt', 1, card.ability.odds) then
            local corrupt_card = G.hand.highlighted[1]
            corrupt_card:set_edition("e_btct_overcharged")
            card:juice_up(0.3, 0.5)
        else
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    attention_text({
                        text = localize('k_nope_ex'),
                        scale = 1.3,
                        hold = 1.4,
                        major = card,
                        backdrop_colour = G.C.SECONDARY_SET.Spectral,
                        align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                            'tm' or 'cm',
                        offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                        silent = true
                    })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.06 * G.SETTINGS.GAMESPEED,
                        blockable = false,
                        blocking = false,
                        func = function()
                            play_sound('tarot1', 0.76, 0.4)
                        SMODS.destroy_cards(G.hand.highlighted)
                            return true
                        end
                    }))
                    play_sound('tarot1', 1, 0.4)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
    end,
}

-- Potions

--[[ Glue
SMODS.Atlas{
   key = 'atlas_btct_consumeables_GluePotion',
   path = 'GluePotion.png',
   px = 71,
   py = 95,
}


SMODS.Consumable {
   atlas = 'atlas_btct_consumeables_GluePotion',
   key = 'GluePotion',
   set = 'btct_Potion',
   pos = { x = 0, y = 0 },
   config = { cardDraw = 3 },
   loc_txt = {
       name = "Glue",
       text={
       'Draw {C:attention}#1#{} cards',
       'to hand upon use'
       },
   },
   loc_vars = function(self, info_queue, card)
       info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
       return { vars = { card.ability.cardDraw } }
   end,
   use = function(self, card, area, copier)
       return {
           SMODS.draw_cards(card.ability.cardDraw)
       }
   end,
   can_use = function(self, card)
       return G.GAME.blind.in_blind
   end
}]]--

-- Functions 
get_random_hand = function()

    handNames = {
        "High Card",
        "Pair",
        "Two Pair",
        "Three of a Kind",
        "Straight",
        "Flush",
        "Full House",
        "Four of a Kind",
        "Straight Flush",
    }

    if(SMODS.is_poker_hand_visible("Five of a Kind")) then
        handNames[#handNames + 1] = "Five of a Kind"
    end
    if(SMODS.is_poker_hand_visible("Flush House")) then
        handNames[#handNames + 1] = "Flush House"
    end
    if(SMODS.is_poker_hand_visible("Flush Five")) then
        handNames[#handNames + 1] = "Flush Five"
    end

    local handType = handNames[pseudorandom('randomHand', 1, #handNames)]

    return handType
end
