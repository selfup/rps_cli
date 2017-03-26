require_relative 'test_helper'
require_relative './../lib/game'

class GameTest < Minitest::Test
  def test_it_can_run_the_game_and_tell_the_user_to_give_it_a_strategy
    architecture = RbConfig::CONFIG["arch"]
    linux = architecture.include?("linux")
    darwin = architecture.include?("darwin")

    if linux || darwin
      small_play = `ruby lib/game.rb`
      assert_equal "Please input a game strategy\n", small_play
    end
  end
end
