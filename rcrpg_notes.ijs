Note 'examples'

      DIRECTION_ZYX ,.&< |:,:DIRECTION_LABELS
┌────────┬──────┐
│_1  0  0│`up   │
│ 1  0  0│`down │
│ 0 _1  0│`north│
│ 0  1  0│`south│
│ 0  0 _1│`west │
│ 0  0  1│`east │
└────────┴──────┘
   STUFF_names
┌──────┬──────┬────┐
│sledge│ladder│gold│
└──────┴──────┴────┘
   PLACE
┌───────┬───────────┬─────┬──────────────┐
│ 0  0 0│0 0 0 0 0 0│1 0 0│`Starting room│
│_5 _1 1│0 0 0 0 0 0│0 0 9│`Prize room   │
└───────┴───────────┴─────┴──────────────┘
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
XXXXXXXXXXXXXXXXXX
   PC_stuff
1 0 0
      drop_load 'sledge'
Reporting: You dropped that stuff.
Reporting: You dropped the item you had equipped.
0
   PLACE
XXXXXXXXXXXXXXXXXX
   PC_stuff
0 0 0
   PC_equipped
0 0 0

)

Note 'manually executed (and examined) test sequences'

NB. actions involving stuff
load 'C:\Users\user\j64-602-user\myactive\rcrpg\rcrpg_main.ijs'
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
PLACE
take_load 'sledge'
equip 'sledge'
move WEST
dig WEST
PC_location
move WEST
PC_location

load 'C:\Users\user\j64-602-user\myactive\rcrpg\rcrpg_main.ijs'
resolve_roll '?.'
)