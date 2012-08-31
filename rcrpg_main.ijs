NB. rcrpg_main.ijs
require 'misc'   NB. provides the verb 'prompt'
cocurrent 'rpg'

NB.===========================================================
NB. At this stage, an obvious problem with list_stuff is also
NB. part of a larger problem. Taking and dropping was built to
NB. support both singular and plural, but command-handling
NB. was built to take single commands (such as "take ladder"
NB. but not also "take ladders"). Must reconcile.
NB.===========================================================

NB. The next two lines facilitate having the whole group of rcrpg scripts
NB. in the same directory as rcrpg_main.ijs, wherever it may be.
lcd =: 3 : ' (4!:4<''lcd'') { 4!:3 $0 '
SCRIPT_PATH=: ;}:}:;:>lcd''
load SCRIPT_PATH, 'rcrpg_setup.ijs'
load SCRIPT_PATH, 'rcrpg_view.ijs'
load SCRIPT_PATH, 'rcrpg_model_action.ijs'
load SCRIPT_PATH, 'rcrpg_model_initialize.ijs'

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
 COMMAND_DO  =: recognize pair_if_solo ;: , tolower COMMAND_RAW
 ACTION      =: ((2<#) { ]) COMMAND_DO
 0
)

recognize=: 3 : 0
 CMD_INDEX=. COMMANDS i. < pattern dereference_aliases y
 if. CMD_INDEX=#COMMANDS do.
   report DID_NOT_UNDERSTAND
   > COMMAND_noop
 else.
   > CMD_INDEX { COMMANDS
 end.
)

pattern=: 3 : 0
 WHICH=. I. (<'''')= {.&.> y
 (<QUOTE_PAIR) WHICH} y
)

dereference_aliases=: 3 : 0
 RECEIVED=. y
 found=. ] < #@[
 draw =. [ (>:@] * found) i.
 pick_in =. [ found i.
 SUBSTITUTIONS=. (ALIASES draw RECEIVED) { a:,ALIAS_ASSOC
 ]L:1 (ALIASES pick_in RECEIVED) {"0 1 RECEIVED,.SUBSTITUTIONS
)

pair_if_solo=: ]`(,&a:) @. (1=#)

'initialize player commands' 1 : 0
 CMDS_direction=. , { (dig`move) ; <DIRECTION_text
 CMDS_stuff=. }: , { (drop`take`equip) ; <STUFF_options
 CMD_alias=. QUOTE_PAIR ; ''`alias , <QUOTE_PAIR
 CMDS_other=. ('name';QUOTE_PAIR); CMD_alias; ''`inventory ; <''`help
 COMMAND_noop=: < ''`noOp , a: NB. embedded capital letter intentionally prevents direct reference by player.
 CMDS_meta=. ''`quit ; COMMAND_noop
 COMMANDS=: pair_if_solo&.> CMDS_direction, CMDS_stuff, CMDS_other, CMDS_meta
 COMMAND_tally=: # COMMANDS
 NB. NONALIASING=: I. COMMANDS = CMD_alias NB. unsure whether I need to prevent this, or others
 ALIASES=: ;:'t d e'                     NB.TEMPORARY
 ALIAS_ASSOC=: <"0 ;:'take drop equip'   NB.TEMPORARY
 NB. Actually, should set aliases through the alias command
)

alias=: 4 : 0
 if. -. (,:x) -: ;: > x do.
   smoutput $;:>x
   1[report ALIAS_MUST_PARSE_AS_SINGLE_TOKEN return.  
 end.
 99
)

noOp=: 0:   NB. Avoids "actions" but allows reporting and logging to procede normally.

quit=: 3 : 0
 RCRPG_PLAY=: 0
 report 'Thank you for playing this J implementation of Rosetta Code RPG.'
)

play_z_=: rcrpg_rpg_