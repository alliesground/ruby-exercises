require 'pry'

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = Score.new
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "Please enter your name"
      n = gets.chomp
      break unless n.empty?
    end
    self.name = n
  end

  def choose
    choice = ''
    loop do
      puts "Please choose Rock, Paper or Scissors"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "invalid choice"
    end

    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['RD32', 'Nemo', 'I-10'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors']

  attr_reader :value

  def initialize(value)
    @value = value
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def scissors?
    @value == 'scissors'
  end

  def >(other_move)
    rock? && other_move.scissors? ||
      paper? && other_move.rock? ||
      scissors? && other_move.paper?
  end

  def <(other_move)
    rock? && other_move.paper? ||
      paper? && other_move.scissors? ||
      scissors? && other_move.rock?
  end
end

class Score
  BENCHMARK = 4

  attr_accessor :total

  def initialize
    @total = 0
  end

  def +(value)
    self.total += value
  end

  def reset
    self.total = 0
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Hello #{@human.name.capitalize} Welcome to the game"
  end

  def display_goodbye_message
    puts "Good bye and Good luck"
  end

  def display_moves
    puts "#{@human.name} chose #{@human.move.value}"
    puts "#{@computer.name} chose #{@computer.move.value}"
  end

  def round_winner
    if human.move > computer.move
      human.score + 1
      human
    elsif human.move < computer.move
      computer.score + 1
      computer
    end
  end

  def display_winner
    winner = round_winner
    if winner
      puts "#{winner.name} won!"
      puts "Your score : #{winner.score.total}"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    puts "Would you like to play again? ('y' for yes)"
    answer = gets.chomp.downcase
    return true if answer.start_with? 'y'
    false
  end

  def game_winner?
    return true if human.score.total == Score::BENCHMARK
    return true if computer.score.total == Score::BENCHMARK
    false
  end

  def display_game_winner
    if human.score.total == Score::BENCHMARK
      puts "#{human.name} wins the game!"
    else
      puts "#{computer.name} wins the game!"
    end
  end

  def play
    display_welcome_message
    loop do
      human.score.reset
      computer.score.reset
      loop do
        @human.choose
        @computer.choose
        display_moves
        display_winner
        break if game_winner?
      end
      display_game_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
