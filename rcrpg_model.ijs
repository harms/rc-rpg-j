NB. rcrpg_model.ijs

initializeGameWorld=: 3 : 0
 SEALED=: 6$0
 PLACE=: (0 3$0);(0 6$0);(0 3$0);(0 1$s:'`')
 PLACE=: PLACE ,&.>  0  0  0; SEALED; 1 Sledge; s:'`Starting room'
 PLACE=: PLACE ,&.> _5 _1  1; SEALED; 9 Gold;   s:'`Prize room'
 update PLACE

 PC_equipped=: PC_stuff=: STUFF_none
 PC_location=: 0 	NB. location is an index into items of PLACE
 enter_room PC_location
)

enter_room=: 3 : 0
 tell_room_name y
 tell_room_coordinates y
 tell_room_contents y
 tell_room_passageways y
 0
)

direct=: DIRECTION_ZYX {~ DIRECTION_labels i. ]

includes=: 4 : 0
 * +/ x * y
)

has_no_passage_to=: 4 : 0
 -. +./ (x { WAY) *. WAYS {~ DIRECTION_text i. y
)

make_passageway=: 4 : 0
 FROM=. zyx x
 TO=. FROM + direct y
 assure_room TO
 DELTA=. ways/ FROM,:TO
 'passageways' alter WAY +. DELTA (locate FROM,:TO)} WAY
)

load_stuff=: 3 : 0
 'CHOICE FLOW AVAILABLE SUCCESS FAILURE'=. y
 'ALL NOTFOUND'=. _1 0+# STUFF_options
 'CHOSEN Quantity'=. choose CHOICE
 select. CHOSEN
   case. NOTFOUND do.
     1[log ERROR return.
   case. ALL do.
     GATHERED=. FLOW * AVAILABLE
   case. do.
     WHICH_STUFF=. 1 CHOSEN} STUFF_none
     GATHERED=. FLOW * (Quantity `:6 AVAILABLE) * WHICH_STUFF
 end.
 if. 0=+/GATHERED do.
   0[report FAILURE return.
 end.
 ROOM_CONTENTS=. (PC_location { STUFF) - GATHERED
 'stuff' alter ROOM_CONTENTS PC_location} STUFF
 PC_stuff=: PC_stuff + GATHERED
 0[report SUCCESS
 if. (FLOW=_1) *. +./ PC_equipped *. | GATHERED do.
   PC_equipped=: STUFF_none
   0[report DROPPED_EQUIPPED
 end.
)

choose=: 3 : 0
 FOUND=. STUFF_options_plurals i. y
 if. FOUND < #STUFF_options_plurals do.
   CHOSEN=. FOUND
   Quantity=. ''`]
 else.
   CHOSEN=. STUFF_options i. y
   Quantity=. ''`*
 end.
 CHOSEN;<Quantity
)

assure_room=: 3 : 0
 MISSING=. (# ZYX) = ZYX i. y
 if. MISSING do.
   CONTENTS=. ([: +/ 0=roll)&> (2#11);(3#8);(8#5)
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
   0[update PLACE
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

dequote=: 3 : 0
 (#~ ''''~:]) > y
)

