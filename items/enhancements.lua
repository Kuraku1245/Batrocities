-- Test
--[[SMODS.Enhancement {
    key = 'Test',
    pos = { x = 9, y = 0 },
    config = { h_dollars = 99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.h_dollars } }
    end,
}]]

--[[ Astral
SMODS.Atlas{
    key = 'astral',
    path = 'AstralEnhance.png',
    px = 71,
    py = 95
}
SMODS.Enhancement {
    key = 'astral',
    atlas = 'astral',
    pos = { x = 0, y = 0 },
    loc_txt = {
    label = 'Astral',
        name = 'Astral',
        text = {
            'Increase level of',
            'poker hand if {C:attention}3{} or more',
            '{C:attention}Astral Cards{} are played',
            '{C:inactive,s:0.7}(Do not have to score){}',
            '(Not Working)'
        }
    },

    --[[calculate = function(self, card, context)
        local handType
        local astralcount = 0
        if G.play.cards then 
            for _,v in ipairs(G.play.cards) do  
                if SMODS.has_enhancement(v, "m_btct_astral") then
                    astralcount = astralcount + 1
                end
            end
        end
        if context.after and context.cardarea == G.play and astralcount >= 3 then 
            return {
                level_up = true,
                message = localize('k_level_up_ex')
            }
        end
    end,
}]]--

-- Counterfeit
SMODS.Atlas{
    key = 'counterfeit',
    path = 'CounterfeitEnhance.png',
    px = 71,
    py = 95
}
SMODS.Enhancement {
    key = 'counterfeit',
    atlas = 'counterfeit',
    pos = { x = 0, y = 0 },
    loc_txt = {
    label = 'Counterfeit',
        name = 'Counterfeit',
        text = {
            '{C:money}$#1#{}',
            '{C:green}#2# in #3#{} chance to',
            'destroy card'
        }
    },
    config = { p_dollars = 2, extra = { odds = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.p_dollars, G.GAME.probabilities.normal, card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.destroy_card and context.cardarea == G.play and context.destroy_card == card and pseudorandom('btct_counterfeit') < G.GAME.probabilities.normal / card.ability.extra.odds then
            return { remove = true }
        end
    end,
}

--[[ Red Brick
SMODS.Atlas{
   key = 'BrickRed',
   path = 'RedBrickEnhance.png',
   px = 71,
   py = 95
}
SMODS.Enhancement {
   key = 'BrickRed',
   atlas = 'BrickRed',
   pos = { x = 0, y = 0 },
   loc_txt = {
   label = 'Red Brick',
       name = 'Red Brick',
       text = {
           '{C:mult}+#1#{} Mult',
           'Inherits abilities of',
           'other {C:attention}Brick{} cards'
       }
   },
   config = { mult = 4 },
   replace_base_card = true,
   no_rank = true,
   no_suit = true,
   always_scores = true,
   loc_vars = function(self, info_queue, card)
       return { vars = { card.ability.mult } }
   end,
}


-- Blue Brick
SMODS.Atlas{
   key = 'BrickBlue',
   path = 'BlueBrickEnhance.png',
   px = 71,
   py = 95
}
SMODS.Enhancement {
   key = 'BrickBlue',
   atlas = 'BrickBlue',
   pos = { x = 0, y = 0 },
   loc_txt = {
   label = 'Blue Brick',
       name = 'Blue Brick',
       text = {
           '{C:chips}+#1#{} Chips',
           'Inherits abilities of',
           'other {C:attention}Brick{} cards'
       }
   },
   config = { bonus = 30 },
   replace_base_card = true,
   no_rank = true,
   no_suit = true,
   always_scores = true,
   loc_vars = function(self, info_queue, card)
       return { vars = { card.ability.bonus } }
   end,
}


-- Yellow Brick
SMODS.Atlas{
   key = 'BrickYellow',
   path = 'YellowBrickEnhance.png',
   px = 71,
   py = 95
}
SMODS.Enhancement {
   key = 'BrickYellow',
   atlas = 'BrickYellow',
   pos = { x = 0, y = 0 },
   loc_txt = {
   label = 'Yellow Brick',
       name = 'Yellow Brick',
       text = {
           '{C:money}$#1#{}',
           'Inherits abilities of',
           'other {C:attention}Brick{} cards'
       }
   },
   config = { p_dollars = 1 },
   replace_base_card = true,
   no_rank = true,
   no_suit = true,
   always_scores = true,
   loc_vars = function(self, info_queue, card)
       return { vars = { card.ability.p_dollars } }
   end,
}]]--

-- Green Brick
--[[SMODS.Atlas{
   key = 'BrickGreen',
   path = 'GreenBrickEnhance.png',
   px = 71,
   py = 95
}
SMODS.Enhancement {
   key = 'BrickGreen',
   atlas = 'BrickGreen',
   pos = { x = 0, y = 0 },
   loc_txt = {
   label = 'Green Brick',
       name = 'Green Brick',
       text = {
           '{C:green}#1# in #2#{} chance to',
           'generate a random {C:planet}Planet{}',
           'or {C:tarot}Tarot{} card when scored',
           'Inherits abilities of',
           'other {C:attention}Brick{} cards'
       }
   },
   config = { extra = { odds = 6 } },
   replace_base_card = true,
   no_rank = true,
   no_suit = true,
   always_scores = true,
   loc_vars = function(self, info_queue, card)
       return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds } }
   end,
   calculate = function(self, card, context)
   if context.cardarea == G.play and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
           G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
           G.E_MANAGER:add_event(Event({
               func = (function()
                   G.E_MANAGER:add_event(Event({
                       func = function()
                        if SMODS.pseudorandom_probability(card, 'm_btct_BrickGreen', 1, 2) == 1 then
                           SMODS.add_card {
                            set = 'Planet',
                           }
                        else
                            SMODS.add_card {
                            set = 'Tarot',
                           }
                        end
                           G.GAME.consumeable_buffer = 0
                           return true
                       end
                   }))
               end)
           }))
       end
   end,
}]]


--[[ Ruby Brick
SMODS.Atlas{
   key = 'BrickRuby',
   path = 'RubyBrickEnhance.png',
   px = 71,
   py = 95
}
SMODS.Enhancement {
   key = 'BrickRuby',
   atlas = 'BrickRuby',
   pos = { x = 0, y = 0 },
   draw = function(self, card, layer)
       if card.config.center.discovered or card.bypass_discovery_center then
           card.children.center:draw_shader('voucher', nil, card.ARGS.send_to_shader)
       end
   end,
   loc_txt = {
   label = 'Ruby Brick',
       name = 'Ruby Brick',
       text = {
           '{X:red,C:white}X#1#{} Mult',
           'Inherits abilities of',
           'other {C:attention}Brick{} cards'
       }
   },
   config = { Xmult = 1.25 },
   replace_base_card = true,
   no_rank = true,
   no_suit = true,
   always_scores = true,
   loc_vars = function(self, info_queue, card)
       return { vars = { card.ability.Xmult } }
   end,
}


-- Sapphire Brick
SMODS.Atlas{
   key = 'BrickSapphire',
   path = 'SapphireBrickEnhance.png',
   px = 71,
   py = 95
}
SMODS.Enhancement {
   key = 'BrickSapphire',
   atlas = 'BrickSapphire',
   pos = { x = 0, y = 0 },
   draw = function(self, card, layer)
       if card.config.center.discovered or card.bypass_discovery_center then
           card.children.center:draw_shader('voucher', nil, card.ARGS.send_to_shader)
       end
   end,
   loc_txt = {
   label = 'Sapphire Brick',
       name = 'Sapphire Brick',
       text = {
           '{X:blue,C:white}X#1#{} Chips',
           'Inherits abilities of',
           'other {C:attention}Brick{} cards'
       }
   },
   config = { XChips = 1.25 },
   replace_base_card = true,
   no_rank = true,
   no_suit = true,
   always_scores = true,
   loc_vars = function(self, info_queue, card)
       return { vars = { card.ability.XChips } }
   end,
}


-- Amber Brick
SMODS.Atlas{
   key = 'BrickAmber',
   path = 'AmberBrickEnhance.png',
   px = 71,
   py = 95
}
SMODS.Enhancement {
   key = 'BrickAmber',
   atlas = 'BrickAmber',
   pos = { x = 0, y = 0 },
   draw = function(self, card, layer)
       if card.config.center.discovered or card.bypass_discovery_center then
           card.children.center:draw_shader('voucher', nil, card.ARGS.send_to_shader)
       end
   end,
   loc_txt = {
   label = 'Amber Brick',
       name = 'Amber Brick',
       text = {
           '{C:money}$#1#{}',
           'Inherits abilities of',
           'other {C:attention}Brick{} cards'
       }
   },
   config = { p_dollars = 2 },
   replace_base_card = true,
   no_rank = true,
   no_suit = true,
   always_scores = true,
   loc_vars = function(self, info_queue, card)
       return { vars = { card.ability.p_dollars } }
   end,
}


-- Malachite Brick
--[[SMODS.Atlas{
   key = 'BrickMalachite',
   path = 'MalachiteBrickEnhance.png',
   px = 71,
   py = 95
}
SMODS.Enhancement {
   key = 'BrickMalachite',
   atlas = 'BrickMalachite',
   pos = { x = 0, y = 0 },
   draw = function(self, card, layer)
       if card.config.center.discovered or card.bypass_discovery_center then
           card.children.center:draw_shader('voucher', nil, card.ARGS.send_to_shader)
       end
   end,
   loc_txt = {
   label = 'Malachite Brick',
       name = 'Malachite Brick',
       text = {
           '{C:green}#1# in #2#{} chance to',
           'generate a random {C:planet}Planet{}',
           'or {C:tarot}Tarot{} card when scored',
           'Inherits abilities of',
           'other {C:attention}Brick{} cards'
       }
   },
   config = { extra = { odds = 2 } },
   replace_base_card = true,
   no_rank = true,
   no_suit = true,
   always_scores = true,
   loc_vars = function(self, info_queue, card)
       return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds } }
   end,
   calculate = function(self, card, context)
   if context.cardarea == G.play and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
           G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
           G.E_MANAGER:add_event(Event({
               func = (function()
                   G.E_MANAGER:add_event(Event({
                       func = function()
                        if SMODS.pseudorandom_probability(card, 'm_btct_BrickMalachite', 1, 2) == 1 then
                           SMODS.add_card {
                            set = 'Planet',
                           }
                        else
                            SMODS.add_card {
                            set = 'Tarot',
                           }
                        end
                           G.GAME.consumeable_buffer = 0
                           return true
                       end
                   }))
               end)
           }))
       end
   end,
}]]--
