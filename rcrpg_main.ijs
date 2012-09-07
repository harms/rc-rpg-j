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
 SUBSTITUTIONS=: (ALIASES draw RECEIVED) { a:,ALIAS_ASSOC NB.TEQUILA
 <S:0 (ALIASES pick_in RECEIVED) {"0 1 RECEIVED,.SUBSTITUTIONS
)

singularize=: 3 : 0
 singulars=. STUFF_options_plurals i. y
 (singulars<#STUFF_options) {"_1 y,.(STUFF_options,a:) {~ singulars
)

noOp=: 0:   NB. Avoids "actions" but allows reporting and logging to procede normally.

play_z_=: rcrpg_rcrpglocale_