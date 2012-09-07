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

'player commands' 1 : 0
CMDS_direction=. , { (dig`move) ; <DIRECTION_text
CMDS_stuff=. }: , { (drop`take`equip) ; <STUFF_options
CMD_alias=. QUOTE_PAIR ; ''`alias , <QUOTE_PAIR
CMDS_other=. ('name';QUOTE_PAIR); CMD_alias; ''`inventory ; <''`help
COMMAND_noop=: < ''`noOp , a: NB. embedded capital letter intentionally prevents direct reference by player.
CMDS_meta=. ''`quit ; COMMAND_noop
COMMANDS=: pair_if_solo&.> CMDS_direction, CMDS_stuff, CMDS_other, CMDS_meta
NB.unnecessary? COMMANDSET_tally=: # COMMANDS
COMMANDS_components=: (QUOTE_PAIR;;COMMAND_noop) -.~ ~. ;COMMANDS
NB. NONALIASING=: I. COMMANDS = CMD_alias NB. unsure whether I need to prevent this, or others
ALIASES=: ;:'t d e'                     NB.TEMPORARY
ALIAS_ASSOC=: <"0 ;:'take drop equip'   NB.TEMPORARY
NB. Actually, should set aliases through the alias command
)
