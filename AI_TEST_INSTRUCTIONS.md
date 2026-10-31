# AI test instructions

Needs Copandon Dot (character 55) in the party with the Omikuji Box (item 69) as weapon. No controls.

Set her `crit` and `impact` to 100 at `rq.battle.on_start` and use Fortune. `rq.battle.snapshot().log` must show `(Stun rate = N)` and sometimes `(critical hit)`. Without the mod it shows neither.
