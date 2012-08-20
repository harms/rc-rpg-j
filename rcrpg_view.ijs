NB. rcrpg_view.ijs

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
report=: 3 :' smoutput ''Reporting: '', y '
ERROR                    =: 'An error condition occurred.'
log=: 3 :' smoutput ''Log entry: '', y '
say_roomname=: '"'&, @ ,&'" is the name of this room."'
say_carrying=: 'You are carrying '&, @ ,&'.'
NOT_CARRYING=: 'You are not carrying anything.'
say_equipped=: 'You are equipped with a '&, @ ,&'.'
NOT_EQUIPPED=: 'You have no item equipped.'
say_contains=: 'In the room you see '&, @ ,&'.'
ROOM_IS_EMPTY=: 'You find nothing of value in the room.'
GOLD_ITEM=: ' piece'
list_stuff=: 3 : 0
 NUMERIC_PORTION=. ,&' '@":&.> |: ,: THIS_STUFF=. y
 SUFFIXES=. (*y) {"0 1 PLURAL_OPTION
 WORD_PORTION=. STUFF_names ,.&(|:@:,:) SUFFIXES
 stream_text=. [:($~ #-2:)[:; <@:,&', '@:;"1
 stream_text NUMERIC_PORTION,.WORD_PORTION
)

inventory=: 3 : 0
 if. 0=+/PC_stuff do.
   report NOT_CARRYING
 else.
   report say_carrying list_stuff PC_stuff
 end.
 if. 0=+/PC_equipped do.
   report NOT_EQUIPPED
 else.
   report say_equipped , > PC_equipped # STUFF_names ,&.> '';'';GOLD_ITEM
 end.
 0
)

tell_room_coordinates=: 3 : 0
 report ": zyx y
)

tell_room_name=: 3 : 0
 if. -.UNNAMED-: y{NAMES do.
   report say_roomname ,> 5&s: y{NAMES
 end.
 0
)

tell_room_contents=: 3 : 0
 CONTENTS=. y { STUFF
 if. +/CONTENTS do.
   report say_contains list_stuff CONTENTS
 else.
   report ROOM_IS_EMPTY
 end.
 0
)

tell_room_passageways=: 3 : 0
 report ": y{WAY
)

NB. STUFF_names_plural is defined in rcrpg_model_initialize.ijs
NB. because it is easier to make sense of in direct comparison
NB. with the words in STUFF_names .
PLURAL_OPTION=:((,.&|:@:,:) (##<@(''"_))) STUFF_names_plural

NB. EOF