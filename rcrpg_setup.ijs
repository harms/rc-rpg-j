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

'maybe delete this code' 1 : 0
spot=: 3 :' 1 (STUFF_names i. y) } STUFF_none '
Sledge=: 1 :' (spot <''sledge'') * +/,m '
Ladder=: 1 :' (spot <''ladder'') * +/,m '
Gold=:   1 :' (spot <''gold''  ) * +/,m '
)

'player commands' 1 : 0
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