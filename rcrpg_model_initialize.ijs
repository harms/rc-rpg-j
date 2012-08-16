NB. rcrpg_main_initialize.ijs

UNNAMED=: s:'`'

STUFF_names=: ;: 'sledge ladder gold'
STUFF_none=: (#STUFF_names)#0

'maybe delete this code' 1 : 0
spot=: 3 :'(1) (STUFF_names i. y) } STUFF_none '
Sledge=: 1 :' (spot <''sledge'') * +/,m '
Ladder=: 1 :' (spot <''ladder'') * +/,m '
Gold=:   1 :' (spot <''gold''  ) * +/,m '
)

WAYS=: = i. 6
DIRECTIONS=: ' down up north south west east'
DIRECTION_LABELS =: s: DIRECTIONS
DIRECTION_ZYX=: ( *  _1 1 $~ #) 2# = i. 3
(toupper DIRECTIONS)=: DIRECTION_ZYX
NB. DIRECTION_LABELS ,&<"_1 DIRECTION_ZYX

ways=: WAYS {~ DIRECTION_ZYX i. (- ,: -~)/ @: (,: +)~
passage=: { WAYS"_

SEALED=: 6$0
PLACE=: PLACE_empty=: (0 3$0);(0 6$0);(0 3$0);(0 1$s:'`')
NB. nix PLACE_empty if it doesn't need to be used elsewhere
PLACE=: PLACE ,&.> 0 0 0; SEALED; 1 Sledge; s:'`Starting room'
PLACE=: PLACE ,&.> 5 1 1; SEALED; 9 Gold;   s:'`Prize room'
update PLACE

PC_location=: 0 	NB. player-character initial location is the starting room
                    NB. (denoted by index into items of inverted table PLACE)
PC_stuff=: STUFF_none

NB. EOF