require_relative 'test_helper'
require_relative './../lib/instructions.rb'

class IntructionsTest < Minitest::Test
  def expected_intructions
    "Type 'r', 'p' or 's'. Type 'q' to quit\n"
  end

  def test_it_can_display_proper_instructions
    i = Instructions.new

    assert_output(expected_intructions) { i.how_to_play }
  end
end
