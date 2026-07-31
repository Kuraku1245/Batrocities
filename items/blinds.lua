--  Glitch blind
 SMODS.Atlas {
    key = "GlitchBlind",
    path = "GlitchBlind.png",
    px = 34,
    py = 34,
    frames = 21,
    atlas_table = 'ANIMATION_ATLAS'
}

SMODS.Blind {
    key = "GlitchBlind",
    atlas = "GlitchBlind",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = 'The Glitch',
        text = {
            'Random blind size',
            'between X0.5 and X5',
        }
    },
    
    boss = { min = 3 },
    boss_colour = HEX("f57ff5"),

}

local GlitchBlind = Game.start_run
function Game:start_run(args)
    GlitchBlind(self, args)
    G.P_BLINDS.bl_btct_GlitchBlind.mult = pseudorandom("Glitch") * 4.5 + 0.5
end