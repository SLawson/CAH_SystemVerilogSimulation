## Cards Against Humanity Hand Generator
### A System Verilog simulation for horrible people

This is a System Verilog random sequence exercise using cards from [Cards Against
Humanity](https://cardsagainsthumanity.com/)&copy;. Only a small subset of the cards have been
included, and the most offensive cards haven't been included, but this project is still NSFW. All
code is implemented in System Verilog.

The included Makefile can be used to compile and run the simulation that will generate random card
sequences from the included text files. The Makefile commands assume Mentor Graphics QuestaSim&reg;
is installed on the host system, and is being run on a Linux system. 

#### The Game 
In case you're unfamiliar, the game is played in rounds, with three or more people.  There are black
cards and white cards. Each player has ten white cards and starts with 0 black cards.  For each
round, one player is chosen to be the "judge", and that player draws one black card from the stack,
and reads it aloud. It will be some kind of prompt, such as a question, a description, or phrase
with a blank space. The white cards are nouns or verbs that are possible responses to the black
card. After the black card is read, all other players choose one of their own white cards that they
think is the best/funniest/silliest/most offensive response to the black card. The white cards are
passed face-down to the judge. The judge shouldn't know who passed which card. He/she reads the
white cards aloud and decides which one he/she likes best. Whoever submitted the white card to the
judge is the winner of that round, and receives the black card. The first player to collect ten black
cards wins.

There are more details, but that's the idea. Everyone passes in white cards that make hilarious,
sometimes offensive, but usually funny combinations with the black cards.

#### The Simulator
This simulation generates random rounds of the CAH game. The prompt cards (black) are displayed and
several white cards are printed below it, indented. Four white cards are printed by default, and
there are five rounds per simulation run. A random sequence is used to choose between pulling cards
from one of two decks stored in text files. The "sv_seed random" flag is used with vsim to generate
new hands on every run.

### Makefile Recipes

| Recipe        | Action
|---------------| ------
| compile       | Compiles the source file(s)
| sim           | Runs the simulation
| clean         | Removes compilation and simulation artifacts
| all           | Cleans the working directory, compiles the project, and runs the simulation
