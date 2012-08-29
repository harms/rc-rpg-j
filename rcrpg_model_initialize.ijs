NB. rcrpg_model_initialize.ijs

'maybe delete this code' 1 : 0
spot=: 3 :' 1 (STUFF_names i. y) } STUFF_none '
Sledge=: 1 :' (spot <''sledge'') * +/,m '
Ladder=: 1 :' (spot <''ladder'') * +/,m '
Gold=:   1 :' (spot <''gold''  ) * +/,m '
)

ways=: WAYS {~ DIRECTION_ZYX i. (- ,: -~)/ @: (,: +)~
passage=: { WAYS"_

SEALED=: 6$0
PLACE=: (0 3$0);(0 6$0);(0 3$0);(0 1$s:'`')
PLACE=: PLACE ,&.>  0  0  0; SEALED; 1 Sledge; s:'`Starting room'
PLACE=: PLACE ,&.> _5 _1  1; SEALED; 9 Gold;   s:'`Prize room'
update PLACE

PC_stuff=: STUFF_none
PC_equipped=: STUFF_none
PC_location=: 0 	NB. location is an index into items of PLACE
enter_room PC_location
