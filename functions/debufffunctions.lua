SMODS.current_mod.set_debuff = function(card)
    if SMODS.has_enhancement(card, "m_wild") and next(SMODS.find_card('j_btct_NaturesTouch')) then
        return "prevent_debuff"
    end
end