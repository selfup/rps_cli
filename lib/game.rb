require_relative 'answers'
require_relative 'answer_logic'
require_relative 'favorites'
require_relative 'game_logic'
require_relative 'instructions'

class Game
  attr_accessor :game_count
  attr_reader   :game_status, :answers, :comp_store, :type_of_game,
                :player_score, :answer_logic, :favorites, :game_logic,
                :computer_score, :instructions

  def initialize
    @type_of_game = ARGV[0]
    @game_count   = 0
    @comp_store   = COMP_STORE
    @answers      = Answers.new
    @answer_logic = AnswerLogic.new
    @favorites    = Favorites.new(answers)
    @instructions = Instructions.new
    @game_logic   = GameLogic.new(self)
  end

  COMP_STORE = ['r', 's', 'p']

  def play
    game_logic.run_match
  end
end

if __FILE__ == $0
  Game.new.play
end
