require_relative 'test_helper'
require_relative './../lib/answers.rb'

class AnswersTest < Minitest::Test
  def test_it_can_store_one_answer
    a = Answers.new
    store_one = a.store_answer('r')

    assert_equal 'r', store_one.first
    assert_equal 1, store_one.length
  end

  def test_it_can_store_two_answers
    a = Answers.new
    store_one = a.store_answer('r')
    store_two = a.store_answer('p')

    assert_equal ['r', 'p'], store_two
    assert_equal 2, store_two.length
  end

  def test_it_can_store_three_answers
    a = Answers.new
    store_one = a.store_answer('r')
    store_two = a.store_answer('p')
    store_three = a.store_answer('s')

    assert_equal ['r', 'p', 's'], store_three
    assert_equal 3, store_three.length
  end

  def test_it_knows_the_last_answer
    a = Answers.new

    store_one = a.store_answer('r')
    store_two = a.store_answer('p')
    assert_equal 'r', a.last_answer
  end
end
