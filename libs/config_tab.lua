Batrocities = {}
Batrocities.config = SMODS.current_mod.config

-- Config Tab
SMODS.current_mod.config_tab = function()
	return {
        n = G.UIT.ROOT, 
        config = {
            align = "cm",
            minh = 6,
            minw = 10,
            padding = 0.2,
            r = 0.1,
            colour = G.C.BLACK
        },
        nodes = {
            {
                n = G.UIT.R,
                config = { align = "cm", },
                nodes = {
                    {
                        n=G.UIT.O, 
                        config={
                            object = DynaText({
                                string = localize("btct_string_A"), 
                                colours = {G.C.WHITE}, 
                                shadow = true, 
                                scale = 0.4
                            })
                        }
                    },
                }
            },
	        create_option_cycle({
                label = localize("btct_string_B"), 
                scale = 0.8,
                w = 6,
                ref_table = Batrocities.config, 
                ref_value = "tarotM_rateChange",
                options = { 1, 2, 3, 4, 5, 6 },
                current_option = Batrocities.config.tarotM_rateChange,
                opt_callback = "btct_tarotM_rateChange",
            }),
            create_option_cycle({
                label = localize("btct_string_C"), 
                scale = 0.8,
                w = 6,
                ref_table = Batrocities.config, 
                ref_value = "planetM_rateChange",
                options = { 1, 2, 3, 4, 5, 6 },
                current_option = Batrocities.config.planetM_rateChange,
                opt_callback = "btct_planetM_rateChange",
            }),
            create_toggle({
                label = localize("btct_string_D"), 
                ref_table = Batrocities.config, 
                ref_value = "disable_malfunctionFlash",
            }),
            create_toggle({
                label = localize("btct_string_E"), 
                ref_table = Batrocities.config, 
                ref_value = "disable_3Spectre",
            })
	    }
    }
end

-- Function for Tarot/Planet Rates config
function G.FUNCS.btct_tarotM_rateChange(args) -- Tarot
    Batrocities.config.tarotM_rateChange = args.cycle_config.current_option
    Batrocities.config.selected = args.to_val
    G.E_MANAGER:add_event(Event({
        func = function()
            if Batrocities.config.tarotM_rateChange == 1 then
                G.GAME.tarot_rate = 4 * 1
                return true
            elseif Batrocities.config.tarotM_rateChange == 2 then
                G.GAME.tarot_rate = 4 * 2.4
                return true
            elseif Batrocities.config.tarotM_rateChange == 3 then
                G.GAME.tarot_rate = 4 * 4.7335
                return true
            elseif Batrocities.config.tarotM_rateChange == 4 then
                G.GAME.tarot_rate = 4 * 8
                return true
            elseif Batrocities.config.tarotM_rateChange == 5 then
                G.GAME.tarot_rate = 4 * 12.2
                return true
            elseif Batrocities.config.tarotM_rateChange == 6 then
                G.GAME.tarot_rate = 4 * 17.333
                return true
            else
                G.GAME.tarot_rate = G.GAME.tarot_rate
                return true
            end
        end
    }))
end
function G.FUNCS.btct_planetM_rateChange(args) -- Planet
    Batrocities.config.planetM_rateChange = args.cycle_config.current_option
    Batrocities.config.selected = args.to_val
    G.E_MANAGER:add_event(Event({
        func = function()
            if Batrocities.config.planetM_rateChange == 1 then
                G.GAME.planet_rate = 4 * 1
                return true
            elseif Batrocities.config.planetM_rateChange == 2 then
                G.GAME.planet_rate = 4 * 2.4
                return true
            elseif Batrocities.config.planetM_rateChange == 3 then
                G.GAME.planet_rate = 4 * 4.7335
                return true
            elseif Batrocities.config.planetM_rateChange == 4 then
                G.GAME.planet_rate = 4 * 8
                return true
            elseif Batrocities.config.planetM_rateChange == 5 then
                G.GAME.planet_rate = 4 * 12.2
                return true
            elseif Batrocities.config.planetM_rateChange == 6 then
                G.GAME.planet_rate = 4 * 17.333
                return true
            else
                G.GAME.planet_rate = G.GAME.planet_rate
                return true
            end
        end
    }))
end

-- NerfHim Tab
SMODS.current_mod.extra_tabs = function()
	return {
        label = 'Nerf Him',
        tab_definition_function = function()
			return {
                n = G.UIT.ROOT, 
                config = {
                    align = "cm",
                    minh = 6,
                    minw = 10,
                    padding = 0.2,
                    r = 0.1,
                    colour = HEX("cc3b49"),
                    outline = 5,
                    outline_colour = G.C.BLACK
                },
                nodes = {
        	        create_toggle({
                    label = localize("btct_string_Skwob"), 
                    ref_table = Batrocities.config, 
                    ref_value = "nerfHim",
                    })
                }
            }
		end,
    }
end
