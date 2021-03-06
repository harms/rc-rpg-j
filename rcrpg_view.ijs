NB. rcrpg_view.ijs

report=: 3 :' smoutput ''Reporting: '', y ' NB. temporary definition
log   =: 3 :' smoutput ''Log entry: '', y ' NB. temporary definition
ERROR                    =: 'An error condition occurred.'
ALIAS_MUST_PARSE_AS_SINGLE_TOKEN=: 'Aliases cannot contain whitespace or special characters.'
ALIAS_ESTABLISHED        =: 0 0$0

INTRODUCTION=: 0 : 0

RCRPG: The tiny Rosetta Code Role-Playing Game
)
DID_NOT_UNDERSTAND       =: 'That command was not understood.'
ROOM_ID_SUFFIX           =: ' is the position of this room.'
ROOM_HAS_NO_EXITS        =: 'This room has no exits. Perhaps you can make one?'
PREFIX_SINGLE_EXIT       =: 'The exit from this room is '
PREFIX_LIST_EXITS        =: 'The exits from this room are '
MOVED_THAT_WAY           =: 'You moved one room in that direction.'
NO_PASSAGE_THAT_WAY      =: 'You did not move. There is no passage that way.'
NO_LADDER_SET_TO_CLIMB   =: 'In order to climb a ladder must stand in the room.'
TOOK_STUFF               =: 'You are now carrying that.'
TOOK_NOTHING             =: 'There was nothing to take.'
DROPPED_STUFF            =: 'You dropped that.'
DROPPED_EQUIPPED         =: 'You no longer have an item equipped.'
DROPPED_NOTHING          =: 'You could not drop that for you did not carry it.'
EQUIPPED_IT              =: 'That item is now equipped.'
NOTHING_TO_EQUIP         =: 'You carry nothing to equip.'
NAMED_THE_ROOM           =: 'This room now has that name.'
DUG_THE_PASSAGEWAY       =: 'You dug a new passage.'
CANNOT_DIG_ALREADY_EXISTS=: 'A passage already has been dug in that direction.'
CANNOT_DIG_NO_TOOL       =: 'You cannot dig, for you have no digging tool equipped.'
SUFFIX_ROOMNAME          =: ' is the name of this room.'
PREFIX_CARRYING          =: 'You are carrying '
NOT_CARRYING             =: 'You are not carrying anything.'
ARE_EQUIPPED             =: 'You are equipped with a '
NOT_EQUIPPED             =: 'You have no item equipped.'
PREFIX_CONTAINS          =: 'In the room you see '
ROOM_IS_EMPTY            =: 'You find nothing of value in the room.'
GOLD_ITEM                =: ' piece'

tell_room_coordinates=: 3 : 0   NB. TODO improve technique used to format number with - instead of _
 NUMTXT=. ": zyx y
 INDICIES=. '_' ([: I. =) NUMTXT
 report ROOM_ID_SUFFIX,~ '-' INDICIES} NUMTXT
 0
)

tell_room_name=: 3 : 0
 if. -.UNNAMED-: y{NAMES
   do. report SUFFIX_ROOMNAME,~ '"' around ,> 5&s: y{NAMES
 end.
 0
)

tell_room_contents=: 3 : 0
 CONTENTS=. y{STUFF
 if. +/CONTENTS
   do.   report PREFIX_CONTAINS , list_stuff CONTENTS
   else. report ROOM_IS_EMPTY
 end.
 0
)

tell_room_passageways=: 3 : 0
 EXITS=: |: ,: (y{WAY) # DIRECTION_text
 if.     
   0=#EXITS do. report ROOM_HAS_NO_EXITS
 elseif.
   1=#EXITS do. report PREFIX_SINGLE_EXIT , say_list EXITS
 elseif.
   1<#EXITS do. report PREFIX_LIST_EXITS , say_list EXITS
 end.
)

list_stuff=: 3 : 0
 if. 1>+/y do. '' return. end.
 NUMERIC_PORTION=. ,&' '@":&.> |: ,: y
 SUFFIXES=. (y=1) {"0 1 PLURAL_OPTION
 WORD_PORTION=. STUFF_names ,.&(|:@:,:) SUFFIXES
 RAW_LIST=. <@;"1 NUMERIC_PORTION,.WORD_PORTION
 LIST=. (*y) # RAW_LIST
 ; LIST,. get_list_punctuation #LIST
)

get_list_punctuation=: 3 : 0
 if. y<2
   do.   ,:<'.'
   else. ((((y-2), 1) $ (<', ')) , (<' and ')) , <'.'
 end.
)

say_list=: [: ; ] ,. [:get_list_punctuation #

NB. This file extends rcrpg_main.ijs by Tracy Harms, 2012, https://github.com/harms/rc-rpg-j