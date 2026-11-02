-- Copandon Dot QoL. Fortune (skill 448) can crit and stun like other attacks.
--   Stun: the game skips 衝撃計算 for this skill number, so that check is patched out.
--         Bad Luck deals no damage and still does not stun.
--   Crit: the game zeroes the rate for multipliers above 150, and Fortune's is 500,
--         so the mod rolls with the same rules the game uses for an all-enemies attack.

local FORTUNE = 448
local STEALTH_CRIT = 30 -- the game's bonus while hidden
local BAD_LUCK = 3      -- FA[102], the result of the next Fortune

rq.log("Copandon Dot QoL: Fortune can crit and stun")

if not rq.combat.install() then error("copandon-dot-qol: rq.combat.install failed") end
if not rq.skill.install() then error("copandon-dot-qol: rq.skill.install failed") end

if rq.ain.patch_int("衝撃計算", FORTUNE, -1) ~= 1 then
  error("copandon-dot-qol: the stun check of Fortune was not found")
end

-- As the game's own skip: the battle forecast reads ◆ＡＡ as the stun rate.
rq.ain.hook("衝撃計算", {
  before = function(h)
    if h.args[3] == FORTUNE and rq.ain.global("FA", 102) == BAD_LUCK then
      rq.ain.set_global("◆ＡＡ", 0)
      h.skip = true
    end
  end,
})

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
