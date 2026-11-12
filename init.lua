-- Copandon Dot QoL. Fortune (skill 448) can crit and stun like other attacks.
--   The rules go through the loader's rq.combat.set_rules (loader 2.44.0), which changes the fight
--   and what rq.combat.rules says together, so Better Explained's hover says it without this mod
--   touching its text.
--   Stun: the game never stuns with this skill number; the rule lets it stun at the game's formula.
--   Crit: the game zeroes the chance for multipliers above 150, and Fortune's is 500; the rule lets
--         it roll the game's chance (halved for an all-enemies attack, +30 while hidden).
--   Bad Luck deals no damage and still does not stun.

local FORTUNE = rq.ids.skill.FORTUNE_448
local BAD_LUCK = 3 -- FA[102], the result of the next Fortune

rq.combat.set_rules(FORTUNE, { crit = true, stun = true })

rq.combat.on_stun(function(ctx)
  if ctx.skill == FORTUNE and rq.ain.global("FA", 102) == BAD_LUCK then
    return 0
  end
  return nil
end)

rq.log("Copandon Dot QoL: Fortune can crit and stun")
