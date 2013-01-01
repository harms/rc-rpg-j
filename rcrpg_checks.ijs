NB. rcrpg_checks.ijs

cocurrent 'rcrpglocale'

InitialPlace=: (2 3$0 0 0 _5 _1 1);(2 6$0);(2 3$1 0 0 0 0 9);s: ,.<;._1 '|Starting room|Prize room'

initializeGameWorld ''
assert PLACE -: InitialPlace


NB. This file extends rcrpg_main.ijs by Tracy Harms, 2012, https://github.com/harms/rc-rpg-j