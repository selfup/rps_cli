require_relative 'test_helper'
require_relative './../lib/favorites.rb'
require_relative './../lib/answers.rb'
require_relative './../lib/answer_logic'

class NonReplGameTest < Minitest::Test
  def test_it_can_simulate_a_non_repl_game
    comps_answers = ['r', 's', 'p']
    a = Answers.new
    a_l = AnswerLogic.new
    f = Favorites.new(a)

    players_move_one = 'p'
    current_play = a.store_answer(players_move_one)
    f.answer_store = a
    players_move_two = 'p'
    current_play = a.store_answer(players_move_two)
    f.answer_store = a

    expected = "Computer wins!\n"
    assert_output(expected){a_l.who_wins?(a.last_answer, comps_answers[1])}

    players_move = 'r'
    current_play = a.store_answer(players_move)
    f.answer_store = a

    expected = "It is a tie!\n"
    assert_output(expected){a_l.who_wins?(a.last_answer, f.latest_favorite)}
  end
end
