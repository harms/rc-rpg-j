NB. rcrpg_main.ijs

NB. general-utility verbs
boxIfOpen=: <^:(L. = 0:)
around=: [ , ] , [

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

'initialize player commands' 1 : 0
 CMDS_direction=. , { (;:' dig move ') ; <DIRECTION_text
 CMDS_stuff=. }: , { (;:' drop take equip ') ; <STUFF_options
 QUOTE_PAIR=.''''''
 CMDS_other=. (;:'name',QUOTE_PAIR); (;:QUOTE_PAIR,'alias',QUOTE_PAIR); <<'inventory'
 COMMANDS=: CMDS_direction, CMDS_stuff, CMDS_other
 COMMAND_tally=: # COMMANDS
 NB. ALIASES=: (,.~ {.&.>) DIRECTION_text
 NB. Actually, should set aliases through the alias command
)





resolve_roll=: 3 : 0 NB.BAD XXXXXXXXXXXXXXXXXXXXXXXX
 if. +./ (<y) e. ;: 'repeatable ?.' do.
     roll=: ?.
   else.
     roll=: ?
 end.
 0
)

NB. EOF