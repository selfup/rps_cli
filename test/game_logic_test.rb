require_relative 'test_helper'
require_relative './../lib/game'
require_relative './../lib/game_logic'

module Kernel
  def exit(status = false)
    # had to monkeypatch the Kernel to keep the test(s) running
  end
end

class GameLogic
  # another patch to make sure the run game method does not
  # go into a recursive loop so the test does not hang
  def run_game
    input = 'q'
    learn_then_strategize(input)
    puts "You chose '#{input}'"
    dictate_the_winner_of_the_match
    game.game_count += 1
  end
end

class GameLogicTest < Minitest::Test
  def test_it_has_access_to_game_and_its_attributes
    g = Game.new
    g_l = g.game_logic

    assert_equal Game, g_l.game.class
    assert_equal 0, g_l.game.game_count
    assert_equal ['r', 's', 'p'], g_l.game.comp_store
    assert_equal Answers, g_l.game.answers.class
    assert_equal Favorites, g_l.game.favorites.class
    assert_equal Instructions, g_l.game.instructions.class
    assert_equal GameLogic, g_l.game.game_logic.class
  end

  def test_it_understands_the_game_type
    ARGV[0] = "complex"
    g_l = Game.new.game_logic

    assert_output("Playing Complex\n") { g_l.strategy }

    ARGV[0] = "last"
    g_l = Game.new.game_logic

    assert_output("Playing Last\n") { g_l.strategy }

    ARGV[0] = "favorite"
    g_l = Game.new.game_logic

    assert_output("You are playing game strategy 'favorite'\n") { g_l.strategy }
  end

  def test_it_can_error_and_exit
    ARGV[0] = ""
    g_l = Game.new.game_logic

    assert_output("Please input a game strategy\n") { g_l.strategy }
  end

  def test_it_can_figure_out_if_the_match_winner_won
    g_l = Game.new.game_logic
    comp_score = g_l.game.answer_logic.computer_score = 3
    winning_output = "Computer won the match!\n"

    assert_output(winning_output) { g_l.dictate_the_winner_of_the_match }

    g_l = Game.new.game_logic
    comp_score = g_l.game.answer_logic.player_score = 3
    winning_output = "You won the match!\n"

    assert_output(winning_output) { g_l.dictate_the_winner_of_the_match }
  end

  def test_it_randomizes_the_play_on_first_move_for_last_strategy
    g_l = Game.new.game_logic
    g_l.game.game_count = 0

    assert_equal String, g_l.play_last.class
  end

  def test_it_plays_the_last_move_after_the_first_play_on_last_strategy
    g_l = Game.new.game_logic

    g_l.game.answers.store_answer('p')
    g_l.game.game_count += 1
    g_l.game.answers.store_answer('s') # current move
    g_l.game.game_count += 1

    assert_equal 'p', g_l.play_last
  end

  def test_it_waits_until_a_favorite_can_be_determined_to_not_randomize_answer_on_favorite_strategy
    g_l = Game.new.game_logic

    g_l.learn_then_strategize('s')
    g_l.game.game_count += 1
    g_l.learn_then_strategize('r')
    g_l.game.game_count += 1
    g_l.learn_then_strategize('p')
    g_l.game.game_count += 1
    g_l.learn_then_strategize('p')
    g_l.game.game_count += 2
    g_l.learn_then_strategize('r') # current move

    assert_equal String, g_l.game.comp_store.sample.class
    assert_equal 'p', g_l.play_favorite
  end

  def test_it_can_play_complex_and_lose_on_predicted_move
    g_l = Game.new.game_logic

    g_l.learn_then_strategize('r')
    g_l.game.game_count += 1
    g_l.learn_then_strategize('r')
    g_l.game.game_count += 1
    g_l.learn_then_strategize('r')
    g_l.game.game_count += 1
    g_l.learn_then_strategize('p')
    g_l.game.game_count += 1
    g_l.learn_then_strategize('p')
    g_l.game.game_count += 1
    g_l.learn_then_strategize('p') # current move

    assert_equal 'r', g_l.play_complex
  end

  def test_it_can_take_an_input_and_run_a_first_iteration
    g_l = Game.new.game_logic

    assert_equal 1, g_l.game.play
    assert_equal ["q"], g_l.game.answers.answers
  end
end
