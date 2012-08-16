NB. rcrpg_model_action.ijs

take_load=: 3 : 0
 SOURCE=. PC_location { STUFF
 0[load_stuff y; 1; SOURCE; TOOK_STUFF; TOOK_NOTHING
)

drop_load=: 3 : 0
 SOURCE=. PC_stuff
 0[load_stuff y; _1; SOURCE; DROPPED_STUFF; DROPPED_NOTHING
)

load_stuff=: 3 : 0
 'CHOICE FLOW AVAILABLE SUCCESS FAILURE'=. y
 'ALL NOTFOUND'=. _1 0+# OPTIONS=. STUFF_names, <'all'
 CHOSEN=. OPTIONS i. <CHOICE
 select. CHOSEN
   case. NOTFOUND do. 1[log ERROR return.
   case. ALL do. GATHERED=. FLOW * AVAILABLE
   case. do.     GATHERED=. FLOW * AVAILABLE * 1 CHOSEN} STUFF_none
 end.
 if. 0=+/GATHERED do.
   0[report FAILURE return.
 end.
 REMAINDER=. AVAILABLE - GATHERED
 'stuff' alter REMAINDER PC_location} STUFF
 PC_stuff=: PC_stuff + GATHERED
 0[report SUCCESS
)

name_room=: 3 : 0
 'names' alter (s: '*',y) PC_location} NAMES
 0[report NAMED_THE_ROOM
)

dig=: 3 : 0
 FROM=. zyx PC_location
 TO=. y + FROM
 assure_room TO
 DELTA=. ways/ FROM,:TO
 NO_PRIOR_PASSAGE=. 0 -: */ , DELTA *. (locate FROM,:TO) { WAY
 if. NO_PRIOR_PASSAGE do.
   'passageways' alter WAY +. DELTA (locate FROM,:TO)} WAY
   report DUG_THE_PASSAGEWAY
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
 COLUMN=. PLACE_qualities i. <x
 FOUND=. COLUMN < # PLACE_qualities
 if. FOUND do.
   PLACE=: (boxIfOpen y) COLUMN} PLACE
   update PLACE
   0 return.
 else. 
   1[log ERROR
 end.
)

update=: 3 : 0
 'ZYX WAY STUFF NAMES'=: PLACE
 zyx     =: { ZYX"_
 locate  =: ZYX i. ]
 0
)

NB. EOF