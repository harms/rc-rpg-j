
rcrpg=: 3 : 0
 RCRPG_PLAY=: 1
 while. RCRPG_PLAY do.
   smoutput LF,'RCRPG'
   RCRPG_PLAY=: 0
 end.
 'The Rosetta Code RPG has ended play.'
)

PASSAGEWAY_DUG=: 'You dug a new passage.'
CANNOT_DIG_ALREADY_EXISTS=: 'A passage already has been dug through that wall.'
report=: 3 :' smoutput ''Reporting: '', y '

dig=: 3 : 0
 FROM=. zyx PC_location
 TO=. y + FROM
 assure_room TO
 DELTA=. ways/ FROM,:TO
 NO_PRIOR_PASSAGE=. 0 -: */ , DELTA *. (locate FROM,:TO) { WAY
 if. NO_PRIOR_PASSAGE do.
   'passageways' alter WAY +. DELTA (locate FROM,:TO)} WAY
   report PASSAGEWAY_DUG
 else.
   report CANNOT_DIG_ALREADY_EXISTS
 end.
 0
)

assure_room=: 3 : 0
 MISSING=. (# ZYX) = ZYX i. y
 if. MISSING do.
   CONTENTS=. ([: +/ 0=?)&> (2#9);(3#8);(8#5)
   PLACE=: PLACE ,&.> y; SEALED; CONTENTS; UNNAMED
   update PLACE
 end.
 0
)

alter=: 4 : 0
 select. x 
   case. 'coordinates' do. 0[ PLACE=: (boxIfOpen y) 0} PLACE
   case. 'passageways' do. 0[ PLACE=: (boxIfOpen y) 1} PLACE
   case. do. 1
 end.
 update PLACE
)

update=: 3 : 0
 WAY=: > 1 { PLACE
 ZYX=: > 0 { PLACE
 zyx     =: { ZYX"_
 locate  =: ZYX i. ]
 missing =: (# ZYX) = locate
 0
)



'maybe delete this code' 1 : 0
STUFF=: ;: 'sledge ladder gold'
STUFF_none=: (#STUFF)#0
spot=: 3 :'(1) (STUFF i. y) } STUFF_none '
Sledge=: 1 :' (spot <''sledge'') * +/,m '
Ladder=: 1 :' (spot <''ladder'') * +/,m '
Gold=:   1 :' (spot <''gold''  ) * +/,m '
)

none  =:   0
player=: 101

UNNAMED=: s:'`'

WAYS=: = i. 6
DIRECTIONS=: ' down up north south west east'
DIRECTION_LABELS =: s: DIRECTIONS
DIRECTION_ZYX=: ( *  _1 1 $~ #) 2# = i. 3
(toupper DIRECTIONS)=: DIRECTION_ZYX
NB. DIRECTION_LABELS ,&<"_1 DIRECTION_ZYX


SEALED=: 6$0
PLACE=: PLACE_empty=: (0 3$0);(0 6$0);(0 3$0);(0 1$s:'`')
NB. nix PLACE_empty if it doesn't need to be used elsewhere
PLACE=: PLACE ,&.> 0 0 0; SEALED; 1 Sledge; s:'`Starting room'
PLACE=: PLACE ,&.> 5 1 1; SEALED; 9 Gold;   s:'`Prize room'
update PLACE

Note 'initialization'
   PLACE
┌─────┬───────────┬─────┬──────────────┐
│0 0 0│0 0 0 0 0 0│1 0 0│`Starting room│
│5 1 1│0 0 0 0 0 0│0 0 9│`Prize room   │
└─────┴───────────┴─────┴──────────────┘
   NB. extension
   identify PC_location adjacent_ZYX NORTH
3
)

direct=: DIRECTION_ZYX i. ]

passage=: { WAYS"_
   
PC_location=: 0 	NB. player-character initial location is the starting room
                    NB. (denoted by index into items of inverted table PLACE)
PC_stuff=: STUFF_none

identify=: locate [ generate_room^:missing

generate_room=: 3 : 0
 CONTENTS=. ([: +/ 0=?)&> (2#9);(3#8);(8#5)
 PLACE=: PLACE ,&.> y; SEALED; CONTENTS; UNNAMED
 update PLACE
 {:&.> PLACE
)

boxIfOpen=: <^:(L. = 0:)

ways=: WAYS {~ DIRECTION_ZYX i. (- ,: -~)/ @: (,: +)~
   
Note 'example (differentials in passageways to, and back)'
   PC_location wayandback WEST
0 0 0 0 1 0
0 0 0 0 0 1
)