require_relative 'test_helper'
require_relative './../lib/answer_logic.rb'

class AnswerLogicTest < Minitest::Test
  def answer_logic
    AnswerLogic.new
  end

  def test_it_can_win_everytime
    player = 'r'

    assert_equal 'p', answer_logic.answer_key[player]
  end

  def test_it_should_know_who_wins
    player = 'r'
    computer = 'p'

    assert_equal computer, answer_logic.answer_key[player]
  end

  def test_it_can_declare_if_the_computer_won_or_the_player
    a_l = answer_logic

    player = 'r'
    computer = 'p'

    assert_output("Computer wins!\n") { a_l.declare_winner(player, computer) }
  end

  def test_it_can_declare_a_tie_or_a_winner
    a_l = answer_logic

    player = 'p'
    computer = 'r'

    assert_output("You win!\n") { a_l.who_wins?(player, computer) }

    player = 's'
    computer = 's'

    assert_output("It is a tie!\n") { a_l.who_wins?(player, computer) }
  end

  def test_it_can_quit_when_q_is_the_input
    a_l = answer_logic

    player = 'q'
    computer = 'r'

    assert_output("You Quit!\n") { a_l.who_wins?(player, computer) }
  end
end
