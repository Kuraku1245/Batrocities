if CardSleeves then

    --[[Geometric Sleeve
    SMODS.Atlas{
        key = 'GeometricSleeve',
        path = 'GeometricSleeve.png',
        px = 71,
        py = 95,
    }

    CardSleeves.Sleeve {
        key = "SGeometric",
        atlas = "GeometricSleeve",
        pos = { x = 0, y = 0 },
        config = { vouchers = {} },

        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_btct_DGeometric" then
                key = self.key .. "_alt"
                self.config = { vouchers = {"v_blank"} }
                vars = { self.config.voucher } 
            else
                key = self.key
                self.config = { vouchers = {} }
                vars = { self.config.vouchers }
            end
            return { key = key, vars = vars }
        end,
    }]]--

    --BlankSleeve
    SMODS.Atlas{
        key = 'BlankSleeve',
        path = 'BlankSleeve.png',
        px = 71,
        py = 95,
    }

	CardSleeves.Sleeve {
        key = "SBlank",
        atlas = "BlankSleeve",
        pos = { x = 0, y = 0 },
        config = { vouchers = {} },

        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_btct_DBlank" then
                key = self.key .. "_alt"
                self.config = { vouchers = {"v_blank"} }
                vars = { self.config.voucher } 
            else
                key = self.key
                self.config = { vouchers = {} }
                vars = { self.config.vouchers }
            end
            return { key = key, vars = vars }
        end,
    }

    --[[Tiny Sleeve
    SMODS.Atlas{
        key = 'TinySleeve',
        path = 'TinySleeve.png',
        px = 71,
        py = 95,
    }

    CardSleeves.Sleeve {
        key = "STiny",
        atlas = "TinySleeve",
        pos = { x = 0, y = 0 },
        config = { vouchers = {} },

        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_btct_DTiny" then
                key = self.key .. "_alt"
                self.config = { vouchers = {"v_blank"} }
                vars = { self.config.voucher } 
            else
                key = self.key
                self.config = { vouchers = {} }
                vars = { self.config.vouchers }
            end
            return { key = key, vars = vars }
        end,
    }]]--

    --Stained Sleeve
    SMODS.Atlas{
        key = 'StainedSleeve',
        path = 'StainedSleeve.png',
        px = 71,
        py = 95,
    }

    CardSleeves.Sleeve {
        key = "SStained",
        atlas = "StainedSleeve",
        pos = { x = 0, y = 0 },
        config = { vouchers = {} },

        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_btct_DStained" then
                key = self.key .. "_alt"
            else
                key = self.key
            end
            return { key = key }
        end,
        apply = function(self)
            if self.get_current_deck_key() == "b_btct_DStained" then
                local stain = 2--SMODS.pseudorandom_probability(nil, 'StainedSleeve', 2, 2)
                if stain == 1 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            if G.jokers then
                                G.jokers.cards[1]:remove_sticker("eternal")
                                return true
                            end
                        end,
                    }))
                elseif stain == 2 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            if G.jokers then
                                G.jokers.cards[1]:remove("j_btct_Mosaic")
                                SMODS.add_card{ key = "j_btct_MessyCanvas" }
                                return true
                            end
                        end,
                    }))
                end
            else
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if G.jokers then
                            SMODS.add_card{ key = "j_btct_Mosaic" }
                            return true
                        end
                    end,
                }))
            end
        end,
    }

       --EvilSleeve
    SMODS.Atlas{
        key = 'EvilSleeve',
        path = 'EvilSleeve.png',
        px = 71,
        py = 95,
    }

    CardSleeves.Sleeve {
        key = "SEvil",
        atlas = "EvilSleeve",
        pos = { x = 0, y = 0 },
        config = { joker = { "j_btct_EvilAndTwisted2006ChevySilverado" } },

        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_btct_DEvil" then
                key = self.key .. "_alt"
            else
                key = self.key
            end
            return { key = key }
        end,
        apply = function(self)
            if self.get_current_deck_key() == "b_btct_DEvil" then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if G.jokers then
                            G.jokers.cards[1]:set_edition("e_negative")
                            return true
                        end
                    end,
                }))
            else
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if G.jokers then
                            SMODS.add_card{ key = "j_btct_EvilAndTwisted2006ChevySilverado" }
                            return true
                        end
                    end,
                }))
            end
        end,
    }

--Stone Sleeve
    SMODS.Atlas{
        key = 'StoneSleeve',
        path = 'StoneSleeve.png',
        px = 71,
        py = 95,
    }

    CardSleeves.Sleeve {
        key = "SStone",
        atlas = "StoneSleeve",
        pos = { x = 0, y = 0 },
        config = { vouchers = {} },

        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_btct_DStone" then
                key = self.key .. "_alt"
            else
                key = self.key
            end
            return { key = key }
        end,
        apply = function(self)
            if self.get_current_deck_key() == "b_btct_DStone" then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        for k, v in pairs(G.playing_cards) do
                            if v:get_id() == 2 then
                                v:set_ability("m_stone")
                            end
                        end
                        return true
                    end
                }))
            else
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                if G.jokers then
                                    SMODS.add_card{ key = "j_btct_PetRock"}
                                    return true
                                end
                            end,
                        }))
                        if G.consumeables then
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
            end
        end,
    }

    --Booster Sleeve
    SMODS.Atlas{
        key = 'BoosterSleeve',
        path = 'BoosterSleeve.png',
        px = 71,
        py = 95,
    }

    CardSleeves.Sleeve {
        key = "SBooster",
        atlas = "BoosterSleeve",
        pos = { x = 0, y = 0 },
        config = { vouchers = {} },

        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_btct_DBooster" then
                key = self.key .. "_alt"
                --[[self.config = { vouchers = {"v_btct_Reveal"} }
                vars = { self.config.voucher } ]]--
            else
                key = self.key
                self.config = { vouchers = {"v_btct_Unboxing"} }
                vars = { self.config.vouchers }
            end
            return { key = key, vars = vars }
        end,
    }

    --Voucher Sleeve
    SMODS.Atlas{
        key = 'VoucherSleeve',
        path = 'VoucherSleeve.png',
        px = 71,
        py = 95,
    }

    CardSleeves.Sleeve {
        key = "SVoucher",
        atlas = "VoucherSleeve",
        pos = { x = 0, y = 0 },
        config = { vouchers = {} },

        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_btct_DVoucher" then
                key = self.key .. "_alt"
                local _pool, _pool_key = get_current_pool('Voucher', nil, nil, nil)
                _voucher = pseudorandom_element(_pool, pseudoseed(_pool_key))
                local iv = 1
                while _voucher == 'UNAVAILABLE' or G.P_CENTERS[_voucher].requires do
                iv = iv + 1
                _voucher = pseudorandom_element(_pool, pseudoseed(_pool_key..'_resample'..iv))
                end
                self.config = { vouchers = {_voucher} }
                vars = { self.config.voucher } 
            else
                key = self.key
                self.config = { vouchers = {'v_btct_Replication'} }
                vars = { self.config.vouchers }
            end
            return { key = key, vars = vars }
        end,
    }

    --Enchained Sleeve
    SMODS.Atlas{
        key = 'EnchainedSleeve',
        path = 'EnchainedSleeve.png',
        px = 71,
        py = 95,
    }

	CardSleeves.Sleeve {
        key = "SEnchained",
        atlas = "EnchainedSleeve",
        pos = { x = 0, y = 0 },
        config = { discards = 1, hands = 1, joker_slot = 1 },

        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_btct_DEnchained" then
                key = self.key .. "_alt"
                --[[self.config = { joker_slot = 1 }
                vars = { self.config.joker_slot } ]]--
            else
                key = self.key
                self.config = { discards = 1, hands = 1 }
                G.GAME.modifiers.enable_eternals_in_shop = true
                vars = { self.config.discards, self.config.hands }
            end
            return { key = key, vars = vars }
        end,
    }

--EvilSleeveAnimation
local btct = {ticks = (5)}
local upd = Game.update
local btct_SEvil_dt = 0
function Game:update(dt)
    upd(self, dt)
    local SEvilobj = G.P_CENTERS.sleeve_btct_SEvil
    btct_SEvil_dt = btct_SEvil_dt + dt
    if SEvilobj and btct_SEvil_dt > 0.1 then
            btct_SEvil_dt = btct_SEvil_dt - 0.1
            if SEvilobj.pos.x > 28 then 
                SEvilobj.pos.x = 0 
            else
                SEvilobj.pos.x = SEvilobj.pos.x + 1
            end
    end
    for k, v in pairs(G.I.CARD) do
	    if v.children.back and v.children.back.atlas == G.ASSET_ATLAS["btct_SEvilAtlas"] then
	    	v.children.back:set_sprite_pos(G.P_CENTERS.b_btct_DEvil.pos or G.P_CENTERS["b_red"].pos)
	    end
    end
end
end