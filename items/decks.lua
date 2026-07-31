--Geometric Deck
SMODS.Atlas{
    key = 'DGeometric',
    path = 'GeometricDeck.png',
    px = 71,
    py = 95,
}

SMODS.Back({
    key = "DGeometric",
    loc_txt = {
        name = "Geometric Deck",
        text={
            "Start with a random",
            "Common {C:attention}Shape{} Joker."
        },
    },
	
	config = { hands = 0, discards = 0},
	pos = { x = 0, y = 0 },
	order = 1,
	atlas = "DGeometric",
    unlocked = true,

	apply = function(self)
        G.E_MANAGER:add_event(Event({
			func = function()
                local shape = math.random(1,4)
				if G.consumeables then
                    if shape == 1 then
                        local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_btct_Skwob", "btct_DGeometric")
                        card:add_to_deck()
                        G.jokers:emplace(card)
                    elseif shape == 2 then
                        local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_btct_Tim", "btct_DGeometric")
                        card:add_to_deck()
                        G.jokers:emplace(card)
                    elseif shape == 3 then
                        local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_btct_Bob", "btct_DGeometric")
                        card:add_to_deck()
                        G.jokers:emplace(card)
                    elseif shape == 4 then
                        local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_btct_Craig", "btct_DGeometric")
                        card:add_to_deck()
                        G.jokers:emplace(card)
                    end
                    return true
                end
			end,
		}))
	end,
})

--Blank Deck
SMODS.Atlas{
    key = 'DBlank',
    path = 'BlankDeck.png',
    px = 71,
    py = 95,
}

SMODS.Back({
    key = "DBlank",
    loc_txt = {
        name = "Blank Deck",
        text={
            "Does nothing."
        },
    },
	
	config = {},
	pos = { x = 0, y = 0 },
	order = 1,
	atlas = "DBlank",
    unlocked = true,
})

--Tiny Deck
SMODS.Atlas{
    key = 'DTiny',
    path = 'TinyDeck.png',
    px = 71,
    py = 95,
}

SMODS.Back({
    key = "DTiny",
    loc_txt = {
        name = "Tiny Deck",
        text={
            "Start with {C:attention,T:j_btct_LilLad}LilLad{} or {C:attention,T:j_wee}Wee Joker{}",
            "{C:attention}#1#{} hand size"
        },
    },
	
	config = { hand_size = -1 },
	pos = { x = 0, y = 0 },
	order = 1,
	atlas = "DTiny",
    unlocked = true,

    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.hand_size } }
    end,

    apply = function(self)
        G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + self.config.hand_size + 1
        G.E_MANAGER:add_event(Event({
			func = function()
                local small = math.random(1,2)
				if G.consumeables then
                    if small == 1 then
                        local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_btct_LilLad", "btct_DGeometric")
                        card:add_to_deck()
                        G.jokers:emplace(card)
                    elseif small == 2 then
                        local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_wee", "btct_DGeometric")
                        card:add_to_deck()
                        G.jokers:emplace(card)
                    end
                    return true
                  end
			end,
		}))
	end,
})

--Stained Deck
SMODS.Atlas{
    key = 'DStained',
    path = 'StainedDeck.png',
    px = 71,
    py = 95,
}

SMODS.Back({
    key = "DStained",
    loc_txt = {
        name = "Stained Deck",
        text={
            "Start with a",
            "{C:attention,T:j_btct_Mosaic}Mosaic{}"
        },
    },
	
	config = { hands = 0, discards = 0},
	pos = { x = 0, y = 0 },
	order = 1,
	atlas = "DStained",
    unlocked = true,

	apply = function(self)
        G.E_MANAGER:add_event(Event({
			func = function()
				if G.consumeables then
                    SMODS.add_card { key = "j_btct_Mosaic" }
			    end
            return true
        end
		}))
	end,
})

--Evil Deck
SMODS.Atlas{
    key = 'DEvilAtlas',
    path = 'EvilDeck.png',
    px = 71,
    py = 95,
}

SMODS.Back({
    key = "DEvil",
    loc_txt = {
        name = "Evil Deck",
        text={
            "Start with {C:attention,T:j_btct_EvilAndTwisted2006ChevySilverado}Evil And{}",
            "{C:attention,T:j_btct_EvilAndTwisted2006ChevySilverado}Twisted 2006 Chevy Silverado{}"
        },
    },
    
    pos = { x = 0, y = 0 },
    order = 1,
    atlas = "DEvilAtlas",
    unlocked = true,

    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                if G.consumeables then
                        local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_btct_EvilAndTwisted2006ChevySilverado", "btct_DEvil")
                        card:add_to_deck()
                        G.jokers:emplace(card)
                    return true
                end
            end,
        }))
    end,
})

-- Stone Deck
SMODS.Atlas{
    key = 'DStone',
    path = 'StoneDeck.png',
    px = 71,
    py = 95,
}
SMODS.Back {
    key = "DStone",
    loc_txt = {
        name = "Stone Deck",
        text={
            "Start with a {C:attention,T:j_btct_PetRock}Pet Rock{}",
            "and two {C:attention,T:c_tower}The Towers{}",
            "{C:inactive,S:0.6}(Not supposed to be a twin towers reference){}"

        },
    },

    pos = { x = 0, y = 0 },
    order = 1,
    atlas = "DStone",
    unlocked = true,
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                if G.consumeables then
                        local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_btct_PetRock", "btct_DStone")
                        card:add_to_deck()
                        G.jokers:emplace(card)
                        local card = create_card("Consumeable", G.consumeables, nil, nil, nil, nil, "c_tower", "btct_DStone")
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                        local card = create_card("Consumeable", G.consumeables, nil, nil, nil, nil, "c_tower", "btct_DStone")
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                    return true
                  end
            end,
        }))
    end,
}

-- Booster Deck
SMODS.Atlas{
    key = 'DBooster',
    path = 'BoosterDeck.png',
    px = 71,
    py = 95,
}
SMODS.Back {
    key = "DBooster",
    loc_txt = {
        name = "Booster Deck",
        text={
            "Start with the ",
            "{C:attention,T:v_btct_Unboxing}Unboxing{} voucher",

        },
    },
    pos = { x = 0, y = 0 },
    order = 1,
    atlas = "DBooster",
    unlocked = true,

    config = { voucher = 'v_btct_Unboxing'},
    loc_vars = function(self, info_queue, back)
        return { vars = { localize { type = 'name_text', key = self.config.voucher, set = 'Voucher' }} }
    end,
}

-- Voucher Deck
SMODS.Atlas{
    key = 'DVoucher',
    path = 'VoucherDeck.png',
    px = 71,
    py = 95,
}
SMODS.Back {
    key = "DVoucher",
    loc_txt = {
        name = "Voucher Deck",
        text={
            "Start with the ",
            "{C:attention,T:v_btct_Replication}Replication{} voucher",

        },
    },
    pos = { x = 0, y = 0 },
    order = 1,
    atlas = "DVoucher",
    unlocked = true,

    config = { voucher = 'v_btct_Replication'},
    loc_vars = function(self, info_queue, back)
        return { vars = { localize { type = 'name_text', key = self.config.voucher, set = 'Voucher' }} }
    end,
}

--Enchained Deck
SMODS.Atlas{
    key = 'DEnchained',
    path = 'EnchainedDeck.png',
    px = 71,
    py = 95,
}

SMODS.Back({
    key = "DEnchained",
    loc_txt = {
        name = "Enchained Deck",
        text={
            "{C:blue}+#1#{} Hand, {C:red}+#2#{} Discard, Jokers",
            "can be {C:attention}Eternal{}"
        },
    },
    
    pos = { x = 0, y = 0 },
    order = 1,
    atlas = "DEnchained",
    unlocked = true,
    config = { hands = 1, discards = 1 },
    
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.hands, self.config.discards } }
    end,

    apply = function(self)
        G.GAME.modifiers.enable_eternals_in_shop = true
    end,
})

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
           "Randomly enhance {C:attention}2{}",
           "random ranks"
       },
   },
  
   pos = { x = 0, y = 0 },
   order = 1,
   atlas = "DScattered",
   unlocked = true,
        
    apply = function(self)
        local cardID1 = pseudorandom("btct_DScattered", 2, 14)
        local cardID2 = pseudorandom("btct_DScattered", 2, 14)
            G.E_MANAGER:add_event(Event({
               func = function()
                   if cardID2 == cardID1 then
                      while cardID2 == cardID1 do
                           cardID2 = pseudorandom("btct_DScattered", 2, 14)
                     end
                  end
                   for k, v in pairs(G.playing_cards) do
                       if v:get_id() == cardID1 or v:get_id() == cardID2 then
                               local random_enhancement = SMODS.poll_enhancement {key = "btct_DScattered", guaranteed = true}
                               v:set_ability(random_enhancement)
                       end
                   end
                   return true
             end
         }))
    end
})

--EvilDeckAnimation
local btct = {ticks = (5)}
local upd = Game.update
local btct_DEvil_dt = 0
function Game:update(dt)
    upd(self, dt)
    local DEvilobj = G.P_CENTERS.b_btct_DEvil
    btct_DEvil_dt = btct_DEvil_dt + dt
    if DEvilobj and btct_DEvil_dt > 0.1 then
            btct_DEvil_dt = btct_DEvil_dt - 0.1
            if DEvilobj.pos.x > 28 then 
                DEvilobj.pos.x = 0 
            else
                DEvilobj.pos.x = DEvilobj.pos.x + 1
            end
    end
    for k, v in pairs(G.I.CARD) do
	    if v.children.back and v.children.back.atlas == G.ASSET_ATLAS["btct_DEvilAtlas"] then
	    	v.children.back:set_sprite_pos(G.P_CENTERS.b_btct_DEvil.pos or G.P_CENTERS["b_red"].pos)
	    end
    end
end
