Note 'examples'

   cocurrent 'rcrpglocale'

   DIRECTION_ZYX ,.&< >,:DIRECTION_text
┌────────┬─────┐
│_1  0  0│up   │
│ 1  0  0│down │
│ 0 _1  0│north│
│ 0  1  0│south│
│ 0  0 _1│west │
│ 0  0  1│east │
└────────┴─────┘
   
   STUFF_names
┌──────┬──────┬────┐
│sledge│ladder│gold│
└──────┴──────┴────┘

   rcrpg''

RCRPG: The tiny Rosetta Code Role-Playing Game

Reporting: "Starting room" is the name of this room.
Reporting: 0 0 0 is the position of this room.
Reporting: In the room you see 1 sledge.
Reporting: This room has no exits. Perhaps you can make one?
> quit
Reporting: Thank you for playing this J implementation of Rosetta Code RPG.

   PLACE
┌───────┬───────────┬─────┬──────────────┐
│ 0  0 0│0 0 0 0 0 0│1 0 0│`Starting room│
│_5 _1 1│0 0 0 0 0 0│0 0 9│`Prize room   │
└───────┴───────────┴─────┴──────────────┘
   
   NB. ============================================
   take_load 'ladder'
Reporting: There was nothing to take.
0
   take_load 'sledge'
Reporting: You are now carrying that stuff.
0
   equip 'sledge'
Reporting: That item is now equipped.
0
   PC_stuff
1 0 0
   PC_equipped
1 0 0
   PLACE
┌───────┬───────────┬─────┬──────────────┐
│ 0  0 0│0 0 0 0 0 0│0 0 0│`Starting room│
│_5 _1 1│0 0 0 0 0 0│0 0 9│`Prize room   │
└───────┴───────────┴─────┴──────────────┘
   PC_stuff
1 0 0
   drop_load 'sledge'
Reporting: You dropped that stuff.
Reporting: You dropped the item you had equipped.
0
   PLACE
┌───────┬───────────┬─────┬──────────────┐
│ 0  0 0│0 0 0 0 0 0│1 0 0│`Starting room│
│_5 _1 1│0 0 0 0 0 0│0 0 9│`Prize room   │
└───────┴───────────┴─────┴──────────────┘
   PC_stuff
0 0 0
   PC_equipped
0 0 0

)

Note 'manually executed (and examined) test sequences'

NB. actions involving stuff
load 'C:\Users\user\j64-602-user\myactive\rcrpg\rcrpg_main.ijs'
resolve_roll '?.'
PLACE
take_load 'ladder'
take_load 'sledge'
equip 'sledge'
PC_stuff
PC_equipped
PLACE
drop_load 'sledge'
PLACE
PC_stuff
PC_equipped

NB. actions involving digging and moving
load 'C:\Users\user\j64-602-user\myactive\rcrpg\rcrpg_main.ijs'
resolve_roll '?.'
PLACE
take_load 'sledge'
equip 'sledge'
move WEST
dig WEST
PC_location
move WEST
PC_location
dig SOUTH
move SOUTH
dig EAST
move EAST
dig NORTH
move NORTH
PC_location
PLACE
      
load 'C:\Users\user\j64-602-user\myactive\rcrpg\rcrpg_main.ijs'
resolve_roll '?.'
)

NB. This file extends rcrpg_main.ijs by Tracy Harms, 2012, https://github.com/harms/rc-rpg-j