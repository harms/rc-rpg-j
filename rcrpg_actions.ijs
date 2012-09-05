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
 HAS_TOOL=. PC_equipped includes 1 Sledge
 NO_HOLE=. PC_location has_no_passage_to DIRECTION_said=. y
 CRITERIA=. HAS_TOOL, NO_HOLE
 fail_tool=. 4 : ' report CANNOT_DIG_NO_TOOL '
 fail_hole=. 4 : ' report CANNOT_DIG_ALREADY_EXISTS '
 succeed  =. 4 : ' report DUG_THE_PASSAGEWAY label_here. x make_passageway y '
 Possibilities=. (fail_tool,fail_hole)`fail_tool`fail_hole`succeed
 PC_location (Possibilities resolve CRITERIA)`:6 DIRECTION_said
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