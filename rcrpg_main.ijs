NB. rcrpg_main.ijs

boxIfOpen=: <^:(L. = 0:)

lcd =: 3 : ' (4!:4<''lcd'') { 4!:3 $0 '
SCRIPTPATH=: ;}:}:;:>lcd''
require SCRIPTPATH, 'rcrpg_view.ijs'
require SCRIPTPATH, 'rcrpg_model_initialize.ijs'
require SCRIPTPATH, 'rcrpg_model_action.ijs'

rcrpg=: 3 : 0
 RCRPG_PLAY=: 1
 while. RCRPG_PLAY do.
   smoutput LF,'RCRPG'
   RCRPG_PLAY=: 0
 end.
 'Thank you for playing this J implementation of Rosetta Code RPG.'
)



NB. EOF