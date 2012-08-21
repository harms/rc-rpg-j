NB. rcrpg_view.ijs

report=: 3 :' smoutput ''Reporting: '', y '
log   =: 3 :' smoutput ''Log entry: '', y '
ERROR                    =: 'An error condition occurred.'

ROOM_ID_SUFFIX           =: ' is the position of this room.'
ROOM_HAS_NO_EXITS        =: 'This room has no exits. Perhaps you can make one?'
PREFIX_SINGLE_EXIT       =: 'The exit from this room is '
PREFIX_LIST_EXITS        =: 'The exits from this room are '
MOVED_THAT_WAY           =: 'You moved one room in that direction.'
NO_PASSAGE_THAT_WAY      =: 'You did not move. There is no passage that way.'
TOOK_STUFF               =: 'You are now carrying that stuff.'
TOOK_NOTHING             =: 'There was nothing to take.'
DROPPED_STUFF            =: 'You dropped that stuff.'
DROPPED_EQUIPPED         =: 'You dropped the item you had equipped.'
DROPPED_NOTHING          =: 'You could not drop that for you did not carry it.'
EQUIPPED_IT              =: 'That item is now equipped.'
NOTHING_TO_EQUIP         =: 'You carry nothing to equip.'
NAMED_THE_ROOM           =: 'This room now has that name.'
DUG_THE_PASSAGEWAY       =: 'You dug a new passage.'
CANNOT_DIG_ALREADY_EXISTS=: 'A passage already has been dug through that wall.'
SUFFIX_ROOMNAME          =: ' is the name of this room.'
PREFIX_CARRYING          =: 'You are carrying '
NOT_CARRYING             =: 'You are not carrying anything.'
ARE_EQUIPPED             =: 'You are equipped with a '
NOT_EQUIPPED             =: 'You have no item equipped.'
PREFIX_CONTAINS          =: 'In the room you see '
ROOM_IS_EMPTY            =: 'You find nothing of value in the room.'
GOLD_ITEM                =: ' piece'

inventory=: 3 : 0
 if. 0=+/PC_stuff
   do.   report NOT_CARRYING
   else. report PREFIX_CARRYING, list_stuff PC_stuff
 end.
 if. 0=+/PC_equipped
   do.   report NOT_EQUIPPED
   else. report ,&'.' say_equipped , > PC_equipped # STUFF_names ,&.> '';'';GOLD_ITEM
 end.
 0
)

tell_room_coordinates=: 3 : 0   NB. TODO improve technique used to format number with - instead of _
 NUMTXT=. ": zyx y
 INDICIES=. '_' ([: I. =) NUMTXT
 report ROOM_ID_SUFFIX,~ '-' INDICIES} NUMTXT
 0
)

tell_room_name=: 3 : 0
 if. -.UNNAMED-: y{NAMES
   do. report SUFFIX_ROOMNAME,~ in_doublequotes ,> 5&s: y{NAMES
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
 EXITS=: |: ,: (y{WAY) # DIRECTION_TEXT
 if.     
   0=#EXITS do. report ROOM_HAS_NO_EXITS
 elseif.
   1=#EXITS do. report PREFIX_SINGLE_EXIT , say_list EXITS
 elseif.
   1<#EXITS do. report PREFIX_LIST_EXITS , say_list EXITS
 end.
)

NB. STUFF_names_plural is defined in rcrpg_model_initialize.ijs
NB. because it is easier to understand it through direct comparison
NB. with the words in STUFF_names (which belong there.)
PLURAL_OPTION=:((,.&|:@:,:) (##<@(''"_))) STUFF_names_plural

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

in_doublequotes=: '"'&, @ ,&'"'

NB. EOF