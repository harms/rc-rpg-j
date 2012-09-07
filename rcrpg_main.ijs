NB. rcrpg_main.ijs
Note 'overview'
    A MUD-like RPG written to fit the Rosetta Code project detailed at
    http://rosettacode.org/wiki/RCRPG
    Copyright (C) 2012 Tracy Bruce Harms

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. The name of that license file is
    rcrpg_z_gpl.txt.  If not, see <http://www.gnu.org/licenses/>.
)

require 'misc'   NB. provides the verb 'prompt'
cocurrent 'rcrpglocale'

NB. The next two lines facilitate having the whole group of rcrpg scripts
NB. in the same directory. This file, rcrpg_main.ijs, serves as the key
NB. for the relative positioning calculated here.
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
  NB. present REPORT NB. 'present' will be used when 'report' has been redefined.
 end.
 0$0
)

command=: 3 : 0
 COMMAND_RAW =: y
 COMMAND_DO  =: recognize tolower Quoted~: ;: , COMMAND_RAW
 ACTION      =: ((2<#) { ]) COMMAND_DO
 0
)

recognize=: 3 : 0
 CMD_TO_USE_IF_GOOD=. pair_if_solo dereference_aliases y
 CMD_INDEX=. COMMANDS i. < singularize QUOTE_PAIR"_ Quoted= CMD_TO_USE_IF_GOOD
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
 <S:0 (ALIASES pick_in RECEIVED) {"0 1 RECEIVED,.SUBSTITUTIONS
)

singularize=: 3 : 0
 singulars=. STUFF_options_plurals i. y
 (singulars<#STUFF_options) {"_1 y,.(STUFF_options,a:) {~ singulars
)

make_alias=: 4 : 0
 asWords=. [: ;: [:( #~ ''''~:]) >
 'FAILURE_REPORT SUCCESS_REPORT'=. x
 TO_BE_ALIASED=. asWords > {. y
 TO_ALIAS=. asWords > {: y
 if. 1~:#TO_ALIAS do.
   0[report FAILURE_REPORT return.  
 end.
 if. TO_ALIAS e. COMMANDS_components do.
   0[report FAILURE_REPORT return.  
 end.
 if. (#TO_BE_ALIASED) = +/ (e. COMMANDS_components"_) TO_BE_ALIASED do.
   if. (#ALIASES) = WHERE_EXISTS=. ALIASES i. TO_ALIAS do.
     ALIASES=: ALIASES, TO_ALIAS
     ALIAS_ASSOC=: ALIAS_ASSOC, <TO_BE_ALIASED
   else.
     ALIASES=: TO_ALIAS WHERE_EXISTS} ALIASES
     ALIAS_ASSOC=: (<TO_BE_ALIASED) WHERE_EXISTS} ALIAS_ASSOC     
   end.
 end.
 0[report SUCCESS_REPORT
)

'define player commands and some initial aliases' 1 : 0
CMDS_direction=. , { (dig`move) ; <DIRECTION_text
CMDS_stuff=. }: , { (drop`take`equip) ; <STUFF_options
CMD_alias=. QUOTE_PAIR ; ''`alias , <QUOTE_PAIR
CMDS_other=. ('name';QUOTE_PAIR); CMD_alias; ''`inventory ; <''`help
COMMAND_noop=: < ''`noOp , a: NB. embedded capital letter in the name noOp intentionally
                              NB. prevents direct reference by player. See 'command'
CMDS_meta=. ''`quit ; COMMAND_noop
COMMANDS=: pair_if_solo&.> CMDS_direction, CMDS_stuff, CMDS_other, CMDS_meta
COMMANDS_components=: (QUOTE_PAIR;;COMMAND_noop) -.~ ~. ;COMMANDS
silent_alias=. 4 :' (;~0#''A'') make_alias x;<y '
silent_alias/"1 ,/([:,&> ({. {@,&< }.))"_1 ;:&><;._2 PRESET_ALIASES
)

play_z_=: rcrpg_rcrpglocale_