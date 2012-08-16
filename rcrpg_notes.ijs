Note 'examples of nouns and verbs'

   DIRECTION_LABELS ,&<"_1 DIRECTION_ZYX
┌──────┬──────┐
│`down │_1 0 0│
├──────┼──────┤
│`up   │1 0 0 │
├──────┼──────┤
│`north│0 _1 0│
├──────┼──────┤
│`south│0 1 0 │
├──────┼──────┤
│`west │0 0 _1│
├──────┼──────┤
│`east │0 0 1 │
└──────┴──────┘
   STUFF_names
┌──────┬──────┬────┐
│sledge│ladder│gold│
└──────┴──────┴────┘
   PLACE
┌─────┬───────────┬─────┬──────────────┐
│0 0 0│0 0 0 0 0 0│1 0 0│`Starting room│
│5 1 1│0 0 0 0 0 0│0 0 9│`Prize room   │
└─────┴───────────┴─────┴──────────────┘
   take_load 'ladder'
Reporting: There was nothing to take.
0
   take_load 'sledge'
Reporting: You are now carrying that stuff.
0
   PLACE
┌─────┬───────────┬─────┬──────────────┐
│0 0 0│0 0 0 0 0 0│0 0 0│`Starting room│
│5 1 1│0 0 0 0 0 0│0 0 9│`Prize room   │
└─────┴───────────┴─────┴──────────────┘
   PC_stuff
1 0 0
   
)