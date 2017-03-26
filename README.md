# Rock Paper Scissors

### Setup

`bundle`

### Tests

All (similar to a rake task): `mrspec`

### Gameplay

3 Modes!

#### Favorite: `ruby lib/game.rb favorite`

This strategy waits until you play 4 times to have some confidence that you actually have a favorite.

For example, if you pick: 'r', 's', and 'p', the computer could not know your favorite answer. If you pick 'r', 's', 'p', and 's', the computer will play your favorite move ('s').

The reason I chose to have the computer play the favorite move instead of beating it, is that the game can run a bit longer, and the tie would more than likely make the player think twice about their next move.

#### Last Move: `ruby lib/game.rb last`

The last move strategy plays a random move at first, and then plays the move that would beat the last move, not the current move.

#### Complex: `ruby lib/game.rb complex`

This strategy plays a random move for 5 turns, and then alternates between the favorite move and last move strategy.

This potentially enables the player to establish a 'most favorite' prior to the computer playing against the favorite or last move strategies.

For example, if the player plays: 'r' three times, and 'p' two times (while not losing to the random generator) the computer will play the 'r' move!

#### In the code

There are examples of how the computer will behave above the three strategy methods inside of the `GameLogic` class.

The three methods to look for are:

* `play_complex`
* `play_favorite`
* `play_last`

### Notes

* Developed with ruby 2.3.0.

* Tested on Ubuntu Linux (14.04 - 15.10) with ruby 2.2.3, 2.2.4, and 2.3.0.

* Tested on OSX El Capitain with ruby 2.0.0p648 and 2.3.0

### Extra Notes

* Test coverage is at 97.97% according to SimpleCov
* It is quite difficult to test a REPL so some monkeypatching was needed
* Patched the `exit` method from the `Kernel` to keep the tests running
* Patched `run_game` to ensure that the REPL would not go in a recursive loop
* The `game_test.rb` file accounts for Operating Systems, and will not run on BSD or Windows since backticks might not execute/can not execute
