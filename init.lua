-- Copandon Dot QoL. Fortune (skill 448) can crit and stun like other attacks.
--   Stun: the game skips 衝撃計算 for this skill number, so that check is patched out.
--   Crit: the game zeroes the rate for multipliers above 150, and Fortune's is 500,
--         so the mod rolls with the same rules the game uses for an all-enemies attack.

local FORTUNE = 448
local STEALTH_CRIT = 30 -- the game's bonus while hidden

rq.log("Copandon Dot QoL: Fortune can crit and stun")

if not rq.combat.install() then error("copandon-dot-qol: rq.combat.install failed") end

if rq.ain.patch_int("衝撃計算", FORTUNE, -1) ~= 1 then
  error("copandon-dot-qol: the stun check of Fortune was not found")
end

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
