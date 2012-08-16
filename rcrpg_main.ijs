
rcrpg=: 3 : 0
 RCRPG_PLAY=: 1
 while. RCRPG_PLAY do.
   smoutput LF,'RCRPG'
   RCRPG_PLAY=: 0
 end.
 'Thank you for playing this J implementation of Rosetta Code RPG.'
)

ERROR                    =: 'An error condition occurred.'
TOOK_STUFF               =: 'You are carrying that stuff.'
TOOK_NOTHING             =: 'There was nothing to take.'
ROOM_NAMED               =: 'This room now has that name.'
PASSAGEWAY_DUG           =: 'You dug a new passage.'
CANNOT_DIG_ALREADY_EXISTS=: 'A passage already has been dug through that wall.'
report=: 3 :' smoutput ''Reporting: '', y '
log=: 3 :' smoutput ''Log entry: '', y '

take=: 3 : 0
 'ALL NOTFOUND'=. _1 0+# OPTIONS=. STUFF_names, <'all'
 OPTED=. OPTIONS i. <y
 AVAILABLE=. PC_location { STUFF
 select. OPTED
   case. NOTFOUND do. 1[log ERROR return.
   case. ALL do. GATHERED=. AVAILABLE
   case. do.     GATHERED=. AVAILABLE * 1 OPTED} STUFF_none
 end.
 if. 0=+/GATHERED do.
   -0[report TOOK_NOTHING return.
 end.
 REMAINDER=. AVAILABLE - GATHERED
 'stuff' alter REMAINDER PC_location} STUFF
 PC_stuff=: PC_stuff + GATHERED
 0[report TOOK_STUFF
)

name_room=: 3 : 0
 'names' alter (s: '*',y) PC_location} NAMES
 0[report ROOM_NAMED
)

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

PLACE_qualities=: ;:'coordinates passageways stuff names'

alter=: 4 : 0
 COLUMN=. PLACE_qualities i. <x
 FOUND=. COLUMN < # PLACE_qualities
 if. FOUND do.
   PLACE=: (boxIfOpen y) COLUMN} PLACE
   update PLACE
   0 return.
 else. 1[log ERROR
 end.
)

update=: 3 : 0
 'ZYX WAY STUFF NAMES'=: PLACE
 zyx     =: { ZYX"_
 locate  =: ZYX i. ]
 0
)



'maybe delete this code' 1 : 0
STUFF_names=: ;: 'sledge ladder gold'
STUFF_none=: (#STUFF_names)#0
spot=: 3 :'(1) (STUFF_names i. y) } STUFF_none '
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

ways=: WAYS {~ DIRECTION_ZYX i. (- ,: -~)/ @: (,: +)~


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



boxIfOpen=: <^:(L. = 0:)

   
Note 'example (differentials in passageways to, and back)'
   PC_location wayandback WEST
0 0 0 0 1 0
0 0 0 0 0 1
)