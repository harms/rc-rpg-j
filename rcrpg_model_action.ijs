NB. rcrpg_model_action.ijs
direct=: DIRECTION_ZYX {~ DIRECTION_labels i. ]

move=: 3 : 0
 DIRECTION=. direct y
 PASSAGE_EXISTS=. (PC_location { WAY) (] -: *) WAYS {~ DIRECTION_ZYX i. DIRECTION
 if. PASSAGE_EXISTS do.
   PC_location=: locate DIRECTION + zyx PC_location
   report MOVED_THAT_WAY
   enter_room PC_location
 else.
   report NO_PASSAGE_THAT_WAY
 end.
 0
)

enter_room=: 3 : 0
 tell_room_name y
 tell_room_coordinates y
 tell_room_contents y
 tell_room_passageways y
 0
)

equip=: 3 : 0
 CHOSEN=. STUFF_names i. y
 if. CHOSEN=#STUFF_names do.
   1[log ERROR return.  
 elseif. 0= CHOSEN { PC_stuff do.
   0[report NOTHING_TO_EQUIP
 elseif. do.
   PC_equipped=: 1 CHOSEN} STUFF_none
   0[report EQUIPPED_IT
 end.
)

take=: 3 : 0
 FROM_ROOM=. 1
 MESSAGES=. TOOK_STUFF; TOOK_NOTHING
 0[load_stuff y; FROM_ROOM; (PC_location { STUFF); MESSAGES
)

drop=: 3 : 0
 FROM_PC=. _1
 MESSAGES=. DROPPED_STUFF; DROPPED_NOTHING
 0[load_stuff y; FROM_PC; PC_stuff; MESSAGES
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

name=: 3 : 0
 'names' alter (s: '*',dequote y) PC_location} NAMES
 0[report NAMED_THE_ROOM
)

dig=: 3 : 0
 if. PC_equipped includes 1 Sledge do.
   FROM=. zyx PC_location
   TO=. FROM + direct y
   assure_room TO
   DELTA=. ways/ FROM,:TO
   NO_PRIOR_PASSAGE=. 0 -: */ , DELTA *. (locate FROM,:TO) { WAY
   if. NO_PRIOR_PASSAGE do.
     'passageways' alter WAY +. DELTA (locate FROM,:TO)} WAY
     report DUG_THE_PASSAGEWAY
   else.
     report CANNOT_DIG_ALREADY_EXISTS
   end.
 else.
   report CANNOT_DIG_NO_TOOL
 end.
 0
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

includes=: 4 : 0
 * +/ x * y
)

dequote=: 3 : 0
 (#~ ''''~:]) > y
)