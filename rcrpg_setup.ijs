NB. rcrpg_setup.ijs

roll=: ?
boxIfOpen=: <^:(L. = 0:)
pair_if_solo=: ]`(,&a:) @. (1=#)
around=: [ , ] , [
QUOTE_PAIR=:''''''

Quoted=: 2 : 0
 ( ,. u&.>) {~"_1 [:(<'''')&v {.&.>
)

PLACE_qualities=: ;:'coordinates passageways stuff names'
UNNAMED=: s:'`'

DIRECTION_text  =: ;: ' up down north south west east'
DIRECTION_up    =: {. DIRECTION_text
DIRECTION_ZYX   =: ( *  _1 1 $~ #) 2# = i. 3

WAYS=: = i. 6
ways=: WAYS {~ DIRECTION_ZYX i. (- ,: -~)/ @: (,: +)~
passage=: { WAYS"_

STUFF_names=: ;: 'sledge ladder gold'
STUFF_names_plural=:  's';   's'; ''
STUFF_none=: (#STUFF_names)#0
STUFF_options=: STUFF_names, <'all'
STUFF_options_plurals=: STUFF_options ,&.> STUFF_names_plural,a:
PLURAL_OPTION=:((,.&|:@:,:) (##<@(''"_))) STUFF_names_plural

Sledge=: 1 :' (+/,m) 0} STUFF_none '
Ladder=: 1 :' (+/,m) 1} STUFF_none '
Gold  =: 1 :' (+/,m) 2} STUFF_none '

ALIAS_ASSOC=: ALIASES=: a:
PRESET_ALIASES=: 0 : 0
'move north' '_north'  'n'
'move south' '_south'  's'
'move east'  '_east'   'e'
'move west'  '_west'   'w'
'move up'    'up'     'u'
'move down'  'down'   'd'
'inventory'  'inv'    'i'
'dig'        'attack' 'a'
)

noOp=: 0:   NB. Avoids "actions" but allows reporting and logging to procede normally.

NB. See rcrpg_z_gpl.txt for licensing details.