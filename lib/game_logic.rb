class GameLogic
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def run_game
    loop do
      input = STDIN.gets.chomp
      learn_then_strategize(input)
      puts "You chose '#{input}'"
      dictate_the_winner_of_the_match
      game.game_count += 1
    end
  end

  def run_match
    strategy
    game.instructions.how_to_play
    run_game
  end

  def learn_then_strategize(input)
    game.favorites.answer_store.store_answer(input)
    game.answer_logic.who_wins?(input, strategy)
  end

  def dictate_the_winner_of_the_match
    if game.answer_logic.computer_score == 3
      puts "Computer won the match!"
      exit
    elsif game.answer_logic.player_score == 3
      puts "You won the match!"
      exit
    end
  end

  def strategy
    if game.type_of_game == "complex"
      puts "Playing Complex"
      play_complex
    elsif game.type_of_game == "favorite"
      puts "You are playing game strategy 'favorite'"
      play_favorite
    elsif game.type_of_game == "last"
      puts "Playing Last"
      play_last
    else
      error_and_exit
    end
  end

# The Logic Behind The Complex Strategy "play_complex":

# Examples: A player tries to beat the random output five times
# Then the computer alternates between favorite and last answer strategies

# If a player runs 'r' 3 times and 'p' two times
# the computer will alternate between favorite (picking 'r', the most favorite)
# and last answer strategies.

# If the player cannot win against the computer during the first 5 random turns
# the complex logic does not kick in
  def play_complex
    return game.comp_store.shuffle.first if game.game_count < 5
    alternate = [game.answers.last_answer, game.favorites.latest_favorite]
    alternate[game.game_count % 2]
  end

# The Logic Behind The Favorite Strategy "play_favorite":

# If a player runs 'r' twice, and 'p' twice
# the computer will run 'p', the lastest favorite on a streak

# If a player runs 's' once, 'p' once, and 'r' twice
# the computer will run 'r', the current/only favorite

# Must play randomly 4 times to ensure that the player indeed has a favorite
  def play_favorite
    return game.comp_store.shuffle.first if game.game_count < 4
    game.favorites.latest_favorite
  end

# The Logic Behind The Last Strategy "play_last":

# Random one time, then it plays the prior (not current) answer each time.
  def play_last
    return game.comp_store.shuffle.first if game.game_count < 1
    game.answers.last_answer
  end

  def error_and_exit
    puts "Please input a game strategy"
    exit
  end
end
