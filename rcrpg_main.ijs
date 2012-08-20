NB. rcrpg_main.ijs

boxIfOpen=: <^:(L. = 0:)

NB. Next two lines facilitate having the whole group of rcrpg scripts
NB. in the same directory as rcrpg_main.ijs, wherever it may be.
lcd =: 3 : ' (4!:4<''lcd'') { 4!:3 $0 '
SCRIPT_PATH=: ;}:}:;:>lcd''
load SCRIPT_PATH, 'rcrpg_view.ijs'
load SCRIPT_PATH, 'rcrpg_model_action.ijs'
load SCRIPT_PATH, 'rcrpg_model_initialize.ijs'

rcrpg=: 3 : 0
 resolve_roll y
 RCRPG_PLAY=: 1
 while. RCRPG_PLAY do.
   smoutput LF,'RCRPG'
   RCRPG_PLAY=: 0
 end.
 'Thank you for playing this J implementation of Rosetta Code RPG.'
)

resolve_roll=: 3 : 0
 if. +./ (<y) e. ;: 'repeatable ?.' do.
     roll=: ?.
   else.
     roll=: ?
 end.
 0
)

NB. EOF