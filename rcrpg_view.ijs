NB. rcrpg_view.ijs

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
say_carrying=: 'You are carrying '&, @ ,&'.'
NOT_CARRYING=: 'You are not carrying anything.'
say_equipped=: 'You are equipped with a '&, @ ,&'.'
NOT_EQUIPPED=: 'You have no item equipped.'
GOLD_ITEM=: ' piece'

inventory=: 3 : 0
 if. 0=+/PC_stuff do.
   report NOT_CARRYING
 else.
   NUMERIC_PORTION=. ,&' '@":&.> |: ,: PC_stuff
   SUFFIXES=: PC_stuff {"0 1 PLURAL_OPTION
   WORD_PORTION=. STUFF_names ,.&(|:@:,:) SUFFIXES
   stream_text=. [:($~ #-2:)[:; <@:,&', '@:;"1
   report say_carrying stream_text NUMERIC_PORTION,.WORD_PORTION
 end.

 if. 0=+/PC_equipped do.
   report NOT_EQUIPPED
 else.
   report say_equipped , > PC_equipped # STUFF_names ,&.> '';'';GOLD_ITEM
 end.
 0
)

NB. STUFF_names_plural is defined in rcrpg_model_initialize.ijs
NB. because it is easier to make sense of in direct comparison
NB. with the words in STUFF_names .
PLURAL_OPTION=:((,.&|:@:,:) (##<@(''"_))) STUFF_names_plural

NB. EOF