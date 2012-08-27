NB. rcrpg_main.ijs
require 'misc'
cocurrent 'rpg'

NB.===========================================================
NB. At this stage, the obvious problem with list_stuff is also
NB. part of a larger problem. Taking and dropping was built to
NB. support both singular and plural, but command-handling
NB. was built to take single commands (such as "take ladder"
NB. but not also "take ladders"). Must reconcile.
NB.===========================================================

NB. general-utility definitions
boxIfOpen=: <^:(L. = 0:)
around=: [ , ] , [
QUOTE_PAIR=:''''''

NB. Next two lines facilitate having the whole group of rcrpg scripts
NB. in the same directory as rcrpg_main.ijs, wherever it may be.
lcd =: 3 : ' (4!:4<''lcd'') { 4!:3 $0 '
SCRIPT_PATH=: ;}:}:;:>lcd''
load SCRIPT_PATH, 'rcrpg_view.ijs'
load SCRIPT_PATH, 'rcrpg_model_action.ijs'
load SCRIPT_PATH, 'rcrpg_model_initialize.ijs'

rcrpg=: 3 : 0
 resolve_roll y  NB.TODO FIX OR REMOVE
 smoutput LF,'RCRPG: The tiny Rosetta Code Role-Playing Game'
 RCRPG_PLAY=: 1
 while. RCRPG_PLAY do.
   command prompt '> '
   select. #>COMMAND_FULL
     case. 1 do. ACTION `:6 a:
     case. 2 do. ACTION `:6 (  1 { >COMMAND_FULL)
     case.   do. ACTION `:3 (0 2 { >COMMAND_FULL)
   end.
  NB. present REPORT
 end.
 0 0$0
)

command=: 3 : 0
 COMMAND_RAW =: y
 COMMAND_FULL=: < ;: , tolower COMMAND_RAW
 ACTION      =: recognize COMMAND_FULL
)

pattern=: 3 : 0
 WHICH=. I. ''''= {.&> y
 (<QUOTE_PAIR) WHICH} y
)

recognize=: 3 : 0
 ALIAS_INDEX=. ALIASES i. y
 if. ALIAS_INDEX<#ALIASES do.              
   CMD_INDEX=. ALIAS_INDEX { ALIAS_ASSOC   
 else.
   CMD_INDEX=. COMMANDS i. pattern&.> y
   if. CMD_INDEX=#COMMANDS do.
     report COMMAND_NOT_UNDERSTOOD
     CMD_INDEX=. COMMANDS i. COMMAND_noop
   end.
 end.
 ((2<#) { >) CMD_INDEX { COMMANDS
)

'initialize player commands' 1 : 0
 CMDS_direction=. , { (dig`move) ; <DIRECTION_text
 CMDS_stuff=. }: , { (drop`take`equip) ; <STUFF_options
 CMD_alias=. QUOTE_PAIR ; ''`alias ; QUOTE_PAIR
 CMDS_other=. ('name';QUOTE_PAIR); CMD_alias; ''`inventory ; <''`help
 CMDS_meta=. (<''`quit); COMMAND_noop=: <''`noOp
 COMMANDS=: CMDS_direction, CMDS_stuff, CMDS_other, CMDS_meta
 COMMAND_tally=: # COMMANDS
 NB. NONALIASING=: I. COMMANDS = CMD_alias NB. unsure whether I need to prevent this, or others
 ALIASES=: (<;:'west'),(<;:'packing') NB.TEMPORARY
 ALIAS_ASSOC=: 4 25                   NB.TEMPORARY
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

resolve_roll=: 3 : 0 NB.BAD XXXXXXXXXXXXXXXXXXXXXXXX
 if. +./ (<y) e. ;: 'repeatable ?.' do.
     roll=: ?.
   else.
     roll=: ?
 end.
 0
)

play_z_=: rcrpg