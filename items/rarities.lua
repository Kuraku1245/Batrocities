SMODS.Rarity {
    key = "Elite",
    loc_txt = {
        name = "Elite"
    },
    default_weight = 0.002,
    badge_colour = HEX('f59827'),
    pools = {Joker = true},
    get_weight = function(self, weight, object_type)
        return weight
    end,
}