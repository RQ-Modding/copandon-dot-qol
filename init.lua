-- Copandon Dot QoL. Fortune (skill 448) can crit and stun like other attacks.
--   Stun: the game never stuns with this skill number; rq.combat.on_stun gives it the rate of the
--         game's formula (ctx.base), in the forecast too. Bad Luck deals no damage and still does
--         not stun.
--   Crit: the game zeroes the rate for multipliers above 150, and Fortune's is 500,
--         so the mod rolls with the same rules the game uses for an all-enemies attack.

local FORTUNE = rq.ids.skill.FORTUNE_448
local STEALTH_CRIT = 30 -- the game's bonus while hidden
local BAD_LUCK = 3      -- FA[102], the result of the next Fortune

rq.log("Copandon Dot QoL: Fortune can crit and stun")

-- The game blocks this skill ("skill"); a target stunned the turn before stays blocked ("repeat").
rq.combat.on_stun(function(ctx)
  if ctx.skill ~= FORTUNE or ctx.blocked ~= "skill" then
    return nil
  end
  if rq.ain.global("FA", 102) == BAD_LUCK then
    return 0
  end
  return ctx.base
end)

rq.combat.on_crit(function(ctx)
  if ctx.skill ~= FORTUNE then
    return nil
  end
  local c = rq.chara.get(ctx.attacker)
  local rate = c.crit
  if (c.stealth or 0) ~= 0 then
    rate = rate + STEALTH_CRIT
  end
  return math.random(100) <= rate // 2 -- all enemies: half, as the game does
end)

-- Better Explained writes the game's own rules on the hover, where Fortune can do
-- neither. This mod loads after it (priority 1), so its line is already there.
rq.skill.on_describe(function(skillNo, text)
  if skillNo ~= FORTUNE or not text then
    return text
  end
  return (text:gsub("Can't Crit", "Can Crit"):gsub("Can't Stun", "Can Stun"))
end)
