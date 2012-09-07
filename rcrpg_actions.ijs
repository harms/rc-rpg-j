NB. rcrpg_actions.ijs

NB. actions focused on the model:

move=: 3 : 0
 PASSAGE_EXISTS=. (PC_location { WAY) (] -: *) WAYS {~ DIRECTION_ZYX i. direct y
 LADDER_OR_NOT_CLIMBING=. (1 Ladder +/@:* PC_location { STUFF) +. -. y -: DIRECTION_up
 CRITERIA=. PASSAGE_EXISTS, LADDER_OR_NOT_CLIMBING
 fail_NoWay   =. 3 : ' report NO_PASSAGE_THAT_WAY '
 fail_NoLadder=. 3 : ' report NO_LADDER_SET_TO_CLIMB '
 s0=. ' report MOVED_THAT_WAY '
 s1=. ' label_1. PC_location=: locate (direct y) + zyx PC_location '
 s2=. ' label_2. enter_room PC_location '
 succeed=. 3 : (s0, s1, s2)
 Possibilities=. (fail_NoWay,fail_NoLadder) ` fail_NoWay ` fail_NoLadder ` succeed
 (Possibilities resolve CRITERIA)`:6 y
 0
)

equip=: 3 : 0
 'CHOSEN Quantity'=. choose y
 if. CHOSEN=#STUFF_options do.
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
 succeed  =. 4 : ' report DUG_THE_PASSAGEWAY label_1. x make_passageway y '
 Possibilities=. (fail_tool,fail_hole) ` fail_tool ` fail_hole ` succeed
 PC_location (Possibilities resolve CRITERIA)`:6 DIRECTION_said
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

alias=: 4 : 0
 REPORTS=. ALIAS_MUST_PARSE_AS_SINGLE_TOKEN; ALIAS_ESTABLISHED
 REPORTS make_alias x;<y
)

help=: 3 : 0
 report 'No helpful information is available at this time.'
 0
)

quit=: 3 : 0
 RCRPG_PLAY=: 0
 report 'Thank you for playing this J implementation of Rosetta Code RPG.'
)

NB. See rcrpg_z_gpl.txt for licensing details.