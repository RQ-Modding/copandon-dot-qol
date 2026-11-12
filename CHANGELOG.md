# Changelog

Each section is a version of the mod, the `version` in `mod.json`. The release workflow copies the
section of a tagged version into the release notes.

## 1.0.4

- Fortune's stun goes through the loader's `rq.combat.on_stun` (the formula's rate in `ctx.base`)
  instead of a patch and a hook on the game's code, and the two `install` lines are gone. Needs
  loader 2.37.0. No change in the game.

## 1.0.3

- The code names the game's characters, skills, items and states with `rq.ids` instead of
  numbers. Needs loader 1.15.0. No change in the game.

## 1.0.2

- With Better Explained, the Fortune hover says Can Crit / Can Stun. The mod loads after it
  (priority 1) to correct that line.

## 1.0.1

- Bad Luck no longer stuns. Needs loader 0.22.0.

## 1.0.0

First version.

- Fortune (skill 448) can crit and stun.
