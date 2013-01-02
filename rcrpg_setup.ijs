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

DIRECTION_text=: ;: ' up down north south west east'
DIRECTION_up=: {. DIRECTION_text
DIRECTION_ZYX=: ( *  _1 1 $~ #) 2# = i. 3

WAYS=: = i. 6
ways=: WAYS {~ DIRECTION_ZYX i. (- ,: -~)/ @: (,: +)~
passage=: { WAYS"_

STUFF_names=: ;: 'sledge ladder gold'
STUFF_names_plural=:  's';   's'; ''
STUFF_none=: (#STUFF_names)#0
STUFF_options=: STUFF_names, <'all'
STUFF_options_plurals=: STUFF_options ,&.> STUFF_names_plural,a:
PLURAL_OPTION=:((,.&|:@:,:) (##<@(''"_))) STUFF_names_plural

(toupper&.> STUFF_names)=: =i.3   NB. definition of DSL nouns (e.g. SLEDGE=: ) occurs here

ALIAS_ASSOC=: ALIASES=: a:
PRESET_ALIASES=: 0 : 0
'move north' '_north'  'n'
'move south' '_south'  's'
'move east'  '_east'   'e'
'move west'  '_west'   'w'
'move up'    'up'      'u'
'move down'  'down'    'd'
'inventory'  'inv'     'i'
'dig'        'attack'  'a'
)

noOp=: 0:   NB. Avoids "actions" but allows reporting and logging to procede normally.

NB. This file extends rcrpg_main.ijs by Tracy Harms, 2012, https://github.com/harms/rc-rpg-j