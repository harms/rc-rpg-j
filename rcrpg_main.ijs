NB. rcrpg_main.ijs

boxIfOpen=: <^:(L. = 0:)

require rcrpg_model_initialize.ijs
require rcrpg_model_action.ijs


rcrpg=: 3 : 0
 RCRPG_PLAY=: 1
 while. RCRPG_PLAY do.
   smoutput LF,'RCRPG'
   RCRPG_PLAY=: 0
 end.
 'Thank you for playing this J implementation of Rosetta Code RPG.'
)

TOOK_STUFF               =: 'You are now carrying that stuff.'
TOOK_NOTHING             =: 'There was nothing to take.'
NAMED_THE_ROOM           =: 'This room now has that name.'
DUG_THE_PASSAGEWAY       =: 'You dug a new passage.'
CANNOT_DIG_ALREADY_EXISTS=: 'A passage already has been dug through that wall.'
report=: 3 :' smoutput ''Reporting: '', y '
ERROR                    =: 'An error condition occurred.'
log=: 3 :' smoutput ''Log entry: '', y '

NB. EOF