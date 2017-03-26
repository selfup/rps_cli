require_relative 'test_helper'
require_relative './../lib/favorites.rb'
require_relative './../lib/answers.rb'

class FavoritesTest < Minitest::Test
  def setup
    a = Answers.new

    a.store_answer('r')
    a.store_answer('r')
    a.store_answer('s')
    a.store_answer('s')
    a.store_answer('p')
    a.store_answer('r')
    a.store_answer('p')
    a.store_answer('s') # current answer, not prior

    a
  end

  def favorites_tie_setup
    a = Answers.new

    a.store_answer('s')
    a.store_answer('p')
    a.store_answer('s')
    a.store_answer('p')
    a.store_answer('r')
    a.store_answer('s') # current answer, not prior

    a
  end

  def test_it_can_store_an_answers_object
    f = Favorites.new(setup)

    assert_equal f.answer_store.class, Answers
    assert_equal ["r", "r", "s", "s", "p", "r", "p", "s"], f.answer_store.answers
  end

  def test_it_can_sort_and_group_answers
    f = Favorites.new(setup)

    grouped_answers = {"r"=>["r", "r", "r"], "s"=>["s", "s"], "p"=>["p", "p"]}
    assert_equal (grouped_answers), f.grouped_answers
  end


  def test_it_can_figure_out_if_there_is_a_tie
    f = Favorites.new(favorites_tie_setup)

    assert_equal true, f.is_tie?
  end

  def test_it_can_figure_out_if_there_is_not_a_tie
    f = Favorites.new(setup)

    assert_equal false, f.is_tie?
  end

  def test_it_removes_an_answer_that_was_given_once_and_cannot_be_a_favorite
    f = Favorites.new(favorites_tie_setup)

    latest_favorites = [["s", "s"], ["p", "p"]]
    assert_equal latest_favorites, f.latest_favorites
  end

  def test_it_can_organize_all_the_favorites_in_a_tie
    f = Favorites.new(favorites_tie_setup)

    organized_hash = {2=>[["s", "s"], ["p", "p"]]}
    group_answers = {"s"=>["s", "s"], "p"=>["p", "p"], "r"=>["r"]}
    assert_equal (group_answers), f.grouped_answers
    assert_equal (organized_hash), f.organized_by_favorites
  end

  def test_it_can_organize_all_the_favorites_not_in_a_tie
    f = Favorites.new(setup)

    organized_hash = {3=>[["r", "r", "r"]], 2=>[["s", "s"], ["p", "p"]]}
    grouped_answers = {"r"=>["r", "r", "r"], "s"=>["s", "s"], "p"=>["p", "p"]}
    assert_equal (grouped_answers), f.grouped_answers
    assert_equal (organized_hash), f.organized_by_favorites
  end

  def test_it_can_find_the_most_favorite_if_there_is_not_a_tie
    f = Favorites.new(setup)

    grouped_answers = {"r"=>["r", "r", "r"], "s"=>["s", "s"], "p"=>["p", "p"]}
    assert_equal (grouped_answers), f.grouped_answers
    assert_equal 'r', f.latest_favorite
  end

  def test_it_can_find_the_last_set_of_most_favorites_if_there_is_a_tie
    f = Favorites.new(favorites_tie_setup)

    grouped_answers = {"s"=>["s", "s"], "p"=>["p", "p"], "r"=>["r"]}
    assert_equal (grouped_answers), f.grouped_answers
    assert_equal 'p', f.latest_favorite
  end
end
