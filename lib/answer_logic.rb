class AnswerLogic
  attr_reader   :answer_key
  attr_accessor :player_score, :computer_score

  def initialize
    @player_score   = 0
    @computer_score = 0
  end

  def answer_key
    {'r' => 'p', 'p' => 's', 's' => 'r'}
  end

  def who_wins?(player, computer)
    return puts "It is a tie!" if player == computer
    declare_winner(player, computer)
  end

  def declare_winner(player, computer)
    if answer_key[player] == computer
      self.computer_score += 1
      puts "Computer wins!"
    elsif answer_key[player] != computer && answer_key.keys.include?(player)
      self.player_score += 1
      puts "You win!"
    elsif player == 'q'
      puts "You Quit!"
      exit
    end
  end
end
