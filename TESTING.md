# Testing Copandon Dot QoL

For people and agents who test the mod in the game. Read it before you use anything the mod adds.

Needs Copandon Dot (character 55) in the party with the Omikuji Box (item 69) as weapon. No controls.

`rq.combat.rules(448)` gives `crit` and `stun` true, `set_by` naming `copandon-dot-qol` (loader
2.44.0). Set her `crit` and `impact` to 100 at `rq.battle.on_start` and use Fortune. `rq.battle.snapshot().log` must show `(Stun rate = N)` and sometimes `(critical hit)`. Without the mod it shows neither. With `FA[102]` at 3 (Bad Luck), it must not stun.

## Test Lab

`agent-lab.ps1 run qol` checks Fortune's stun and Bad Luck, `run rules` the rules it sets, Fortune's crit and stun forecast and Bad Luck, and `run spellblade` the Fortune hover with Better Explained.
