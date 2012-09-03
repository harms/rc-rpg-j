NB. rcrpg_main.ijs
require 'misc'   NB. provides the verb 'prompt'
cocurrent 'rcrpg'

NB. The next two lines facilitate having the whole group of rcrpg scripts
NB. in the same directory as rcrpg_main.ijs, wherever it may be.
lcd =: 3 : ' (4!:4<''lcd'') { 4!:3 $0 '
SCRIPT_PATH=: ;}:}:;:>lcd''
load SCRIPT_PATH, 'rcrpg_setup.ijs'
load SCRIPT_PATH, 'rcrpg_model.ijs'
load SCRIPT_PATH, 'rcrpg_view.ijs'
load SCRIPT_PATH, 'rcrpg_actions.ijs'

rcrpg=: 3 : 0
 smoutput INTRODUCTION
 initializeGameWorld ''
 RCRPG_PLAY=: 1
 while. RCRPG_PLAY do.
   command prompt '> '
   if.     2=#COMMAND_DO do. ACTION `:6 (  1 { COMMAND_DO)
   elseif. 3=#COMMAND_DO do. ACTION `:3 (0 2 { COMMAND_DO)
   end.
  NB. present REPORT
 end.
 0$0
)

command=: 3 : 0
 COMMAND_RAW =: y
 COMMAND_DO  =: recognize pair_if_solo tolower Quoted~: ;: , COMMAND_RAW
 ACTION      =: ((2<#) { ]) COMMAND_DO
 0
)

recognize=: 3 : 0
 CMD_TO_USE_IF_GOOD=. dereference_aliases y
 CMD_INDEX=. COMMANDS i. < QUOTE_PAIR"_ Quoted= CMD_TO_USE_IF_GOOD
 if. CMD_INDEX=#COMMANDS do.
   report DID_NOT_UNDERSTAND
   > COMMAND_noop
 else.
   CMD_TO_USE_IF_GOOD
 end.
)

dereference_aliases=: 3 : 0
 RECEIVED=. y
 found=. ] < #@[
 draw =. [ (>:@] * found) i.
 pick_in =. [ found i.
 SUBSTITUTIONS=. (ALIASES draw RECEIVED) { a:,ALIAS_ASSOC
 ]L:1 (ALIASES pick_in RECEIVED) {"0 1 RECEIVED,.SUBSTITUTIONS
)

alias=: 4 : 0
 if. -. (,:x) -: ;: > x do.
   smoutput $;:>x NB.TODO TEMPORARY
   1[report ALIAS_MUST_PARSE_AS_SINGLE_TOKEN return.  
 end.
 99 NB.TODO TEMPORARY
)

noOp=: 0:   NB. Avoids "actions" but allows reporting and logging to procede normally.

quit=: 3 : 0
 RCRPG_PLAY=: 0
 report 'Thank you for playing this J implementation of Rosetta Code RPG.'
)

play_z_=: rcrpg_rcrpg_