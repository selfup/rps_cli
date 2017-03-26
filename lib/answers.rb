class Answers
  attr_reader :answers

  def initialize
    @answers = []
  end

  def store_answer(players_answer)
    answers.push players_answer
  end

  def last_answer
    answers[-2]
  end
end
