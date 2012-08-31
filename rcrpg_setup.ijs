NB. rcrpg_setup.ijs

boxIfOpen=: <^:(L. = 0:)
around=: [ , ] , [
QUOTE_PAIR=:''''''
quotepair=:QUOTE_PAIR"_
roll=: ?

PLACE_qualities=: ;:'coordinates passageways stuff names'
UNNAMED=: s:'`'

WAYS=: = i. 6
ways=: WAYS {~ DIRECTION_ZYX i. (- ,: -~)/ @: (,: +)~
passage=: { WAYS"_

DIRECTIONS=: ' up down north south west east'
DIRECTION_labels=: ;: DIRECTIONS   NB. perhaps eliminate DIRECTION_labels
DIRECTION_text=: ;: DIRECTIONS
DIRECTION_ZYX=: ( *  _1 1 $~ #) 2# = i. 3
(toupper DIRECTIONS)=: DIRECTION_ZYX

STUFF_names=: ;: 'sledge ladder gold'
STUFF_names_plural=:  's';   's'; ''
STUFF_none=: (#STUFF_names)#0
STUFF_options=: STUFF_names, <'all'
STUFF_options_plurals=: STUFF_options ,&.> STUFF_names_plural,a:
PLURAL_OPTION=:((,.&|:@:,:) (##<@(''"_))) STUFF_names_plural