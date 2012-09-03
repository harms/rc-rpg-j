NB. rcrpg_actions.ijs

NB. actions focused on the model:

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

name=: 3 : 0
 'names' alter (s: '*',dequote y) PC_location} NAMES
 0[report NAMED_THE_ROOM
)

dig=: 3 : 0
 if. PC_equipped includes 1 Sledge
   do. CAN_DIG=. 1
   else. report CANNOT_DIG_NO_TOOL
 end.
 if. PC_location has_no_passage_to y
   do. CAN_DIG=. CAN_DIG *. 1
   else. report CANNOT_DIG_ALREADY_EXISTS
 end.
 if. CAN_DIG do.
   FROM=. zyx PC_location
   TO=. FROM + direct y
   assure_room TO
   DELTA=. ways/ FROM,:TO
   'passageways' alter WAY +. DELTA (locate FROM,:TO)} WAY
   report DUG_THE_PASSAGEWAY
 end.
 0
)

NB. actions focused on the view:

inventory=: 3 : 0
 if. 0=+/PC_stuff
   do.   report NOT_CARRYING
   else. report PREFIX_CARRYING, list_stuff PC_stuff
 end.
 if. 0=+/PC_equipped
   do.   report NOT_EQUIPPED
   else. report ,&'.' ARE_EQUIPPED , ,> PC_equipped # STUFF_names ,&.> '';'';GOLD_ITEM
 end.
 0
)

NB. actions focused on the controller:

help=: 3 : 0
 report 'No helpful information is available at this time.'
 0
)