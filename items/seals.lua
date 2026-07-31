-- Crimson Seal
SMODS.Atlas {
    key = "SealCrimson",
    path = "SealCrimson.png",
    px = 71,
    py = 96
}

SMODS.Seal {
    name = "SealCrimson",
    key = "SealCrimson",
    badge_colour = HEX("700000"),
	config = { mult = 4 },
    loc_txt = {
        label = 'Crimson Seal',
        name = 'Crimson Seal',
        text = {
            '{C:mult}+#1#{} Mult'
        }
    },

    loc_vars = function(self, info_queue)
        return { vars = {self.config.mult} }
    end,
    
    atlas = "SealCrimson",
    pos = {x=0, y=0},
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                G.E_MANAGER:add_event(Event({func = function()
                return true end })),
                
                mult = self.config.mult
            }
        end
    end,
}

-- Cerulean seal
SMODS.Atlas {
    key = "SealCerulean",
    path = "SealCerulean.png",
    px = 71,
    py = 96
}

SMODS.Seal {
    name = "SealCerulean",
    key = "SealCerulean",
    badge_colour = HEX("0770ad"),
	config = {chips = 40  },
    loc_txt = {
        label = 'Cerulean Seal',
        name = 'Cerulean Seal',
        text = {
            '{C:chips}+#1#{} Chips'
        }
    },

    loc_vars = function(self, info_queue)
        return { vars = {self.config.chips} }
    end,
    atlas = "SealCerulean",
    pos = {x=0, y=0},

    calculate = function(self, card, context)

        if context.main_scoring and context.cardarea == G.play then
            return {
                G.E_MANAGER:add_event(Event({func = function()
                return true end })),
                
                chips = self.config.chips
            }
        end
    end,
}

--[[ Black Seal
SMODS.Atlas {
    key = "SealBlack",
    path = "SealBlack.png",
    px = 71,
    py = 96
}

SMODS.Seal {
    atlas = "SealBlack",
    name = "SealBlack",
    key = "SealBlack",
    badge_colour = HEX("161616"),
    loc_txt = {
        label = 'Black Seal',
        name = 'Black Seal',
        text = {
            'When discarded, {C:attention}destroy',
            'first discarded card'
        }
    },
    calculate = function(self, card, context)
        if context.discard then
            return {
                remove = true
            }
        end
    end
}]]--

--[[ White Seal
SMODS.Atlas {
    key = "SealWhite",
    path = "SealWhite.png",
    px = 71,
    py = 96
}

SMODS.Seal {
    atlas = "SealWhite",
    name = "SealWhite",
    key = "SealWhite",
    badge_colour = HEX("bdbdbd"),
    loc_txt = {
        label = 'White Seal',
        name = 'White Seal',
        text = {
            'When played, create a {C:attention}copy{} of',
            'first played card and add to hand',
            '{C:inactive,s:0.8}(White seals will not be transferred{}',
            '{C:inactive,s:0.8}to copies from other white seals){}'
        }
    },
    config = { extra = { copy = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.copy } }
    end,
     calculate = function(self, card, context)
    if context.before and context.main_eval then
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            local copy_card = copy_card(context.full_hand[1], nil, nil, G.playing_card)
            copy_card:add_to_deck()
            G.deck.config.card_limit = G.deck.config.card_limit + 1
            table.insert(G.playing_cards, copy_card)
            G.hand:emplace(copy_card)
            copy_card.states.visible = nil

            G.E_MANAGER:add_event(Event({
                func = function()
                    copy_card:start_materialize()
                    return true
                end
            }))
            return {
                message = localize('k_copied_ex'),
                colour = G.C.CHIPS,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.calculate_context({ playing_card_added = true, cards = { copy_card } })
                            return true
                        end
                    }))
                end
            }
        end
    end
}]]--