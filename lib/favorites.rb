require_relative 'answers'

class Favorites
  attr_accessor :answer_store
  attr_reader :favorites, :latest_favorites

  def initialize(answers = nil)
    @answer_store = answers
    @favorites = []
  end

  def grouped_answers
    answer_store.answers[0..-2].group_by(&:to_s)
  end

  def latest_favorites
    grouped_answers.values.reject { |favs| favs.length == 1 }
  end

  def organized_by_favorites
    latest_favorites.group_by(&:length)
  end

  def is_tie?
    organized_by_favorites.keys.length == 1
  end

  def latest_favorite
    return latest_favorites.last[0] if is_tie?
    latest_favorites.first[0]
  end
end
