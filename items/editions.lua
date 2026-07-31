--Gemstone
SMODS.Sound({key = "gemstoneSound", path = "GemstoneSound.ogg",})
SMODS.Shader({ key = 'gemstone', path = 'gemstone.fs' })

SMODS.Edition {
    key = 'gemstone',
    shader = 'gemstone',
    loc_txt = {
        name = "Gemstone",
        text={
        '{X:blue,C:white}X#1#{} Chips',
        },
    },
    config = { x_chips = 1.35 },
    in_shop = true,
    weight = 7,
    extra_cost = 4,
    sound = { sound = "btct_gemstoneSound", per = 1.2, vol = 0.7 },
    loc_vars = function(self, info_queue)
        return { vars = { self.config.x_chips } }
    end,
    get_weight = function(self)
        return (G.GAME.edition_rate - 1) * G.P_CENTERS["e_negative"].weight + G.GAME.edition_rate * self.weight
    end,
    calculate = function(self, card, context)
        if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                x_chips = card.edition.x_chips
            }
        end
    end
}

-- Overcharged
SMODS.Sound({key = "OverchargeZap", path = "OverchargeZap.ogg",})
SMODS.Shader({ key = 'overcharged', path = 'overcharged.fs' })

SMODS.Edition {
    key = 'overcharged',
    shader = 'overcharged',
    loc_txt = {
        name = "Overcharged",
        text={
        '{C:attention}Retrigger{} this',
        'card after scoring'
        },
    },
    in_shop = true,
    weight = 1.5,
    extra_cost = 2,
    sound = { sound = "btct_OverchargeZap", per = 1.2, vol = 0.7 },

    config = { extra = { repetitions = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { (card.edition and card.edition.extra.repetitions or self.config.extra.repetitions) } }
    end,

    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,

    calculate = function(self, card, context)
        if (context.repetition or context.retrigger_joker_check) and context.other_card == card then
            return {repetitions = card.edition.extra.repetitions}
        end
    end
}

SMODS.current_mod.optional_features = function()
    return {
        retrigger_joker = true
    }
end

--[[ Antique
SMODS.Sound({key = "antiqueSound", path = "Im old.ogg",})
SMODS.Shader({ key = 'antique', path = 'antique.fs' })

SMODS.Edition {
    key = 'antique',
    shader = 'antique',
    loc_txt = {
        name = "Antique",
        text={
        '{X:gold,C:white}X#1#{} sell value (not working)',
        },
    },
    config = { value = 3 },
    in_shop = true,
    weight = 10,
    extra_cost = 4,
    sound = { sound = "btct_antiqueSound", per = 1.5, vol = 1 },
    loc_vars = function(self, info_queue)
        return { vars = { self.config.value } }
    end,
    get_weight = function(self)
        return (G.GAME.edition_rate - 1) * G.P_CENTERS["e_negative"].weight + G.GAME.edition_rate * self.weight
    end,
    calculate = function(self, card, context)
        card.ability.extra_value = card.ability.extra_value * card.ability.extra.value
        card:set_cost()
    end
}]]--

--[[ Hyperchrome
SMODS.Sound({key = "antiqueSound", path = "Im old.ogg",})
SMODS.Shader({ key = 'hyperchrome', path = 'hyperchrome.fs' })

SMODS.Edition {
    key = 'hyperchrome',
    shader = 'hyperchrome',
    loc_txt = {
        name = "hyperchrome",
        text={
        '{X:gold,C:white}X#1#{} sell value (not working)',
        },
    },
    config = { value = 3 },
    in_shop = true,
    weight = 10,
    extra_cost = 4,
    sound = { sound = "btct_antiqueSound", per = 1.5, vol = 1 },
    loc_vars = function(self, info_queue)
        return { vars = { self.config.value } }
    end,
    get_weight = function(self)
        return (G.GAME.edition_rate - 1) * G.P_CENTERS["e_negative"].weight + G.GAME.edition_rate * self.weight
    end,
    calculate = function(self, card, context)
        card.ability.extra_value = card.ability.extra_value * card.ability.extra.value
        card:set_cost()
    end
}]]--