NB. rcrpg_model_action.ijs

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
   0[report TOOK_NOTHING return.
 end.
 REMAINDER=. AVAILABLE - GATHERED
 'stuff' alter REMAINDER PC_location} STUFF
 PC_stuff=: PC_stuff + GATHERED
 0[report TOOK_STUFF
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

NB. EOF