local oldsetcost = Card.set_cost
function Card:set_cost()
    local g = oldsetcost(self)
    if self.ability.set == "Joker" and next(SMODS.find_card("j_btct_CheeseMan")) then self.sell_cost = 0 end
    return g
end