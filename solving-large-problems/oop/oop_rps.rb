require 'pry'

class Player
  attr_accessor :player_type, :move, :name

  def initialize(player_type = 'human')
    @player_type = player_type
    @move = nil
    set_name
  end

  def set_name
    if human?
      n = ''
      loop do
        puts "Please enter your name"
        n = gets.chomp
        break unless n.empty?
      end
      self.name = n
    else
      self.name = ['RD32', 'Nemo', 'I-10'].sample
    end
  end

  def human?
    @player_type == 'human'
  end

  def choose
    if human?
      choice = ''
      loop do
        puts "Please choose Rock, Paper or Scissors"
        choice = gets.chomp
        break if ['rock', 'paper', 'scissors'].include? choice
        puts "invalid choice"
      end

      self.move = choice
    else
      self.move = ['rock', 'paper', 'scissors'].sample
    end
  end
end

class Move
end

class Rule
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new()
    @computer = Player.new('computer')
  end

  def display_welcome_message
    puts "Hello #{@human.name.capitalize} Welcome to the game"
  end

  def display_goodbye_message
    puts "Good bye and Good luck"
  end

  def display_winner
    puts "#{@human.name} chose #{@human.move}"
    puts "#{@computer.name} chose #{@computer.move}"

    case @human.move
    when 'rock'
      puts "You won!" if @computer.move == 'scissors'
      puts "It's a tie!" if @computer.move == 'rock'
      puts "Computer won!" if @computer.move ==  'paper'
    when 'paper'
      puts "You won!" if @computer.move == 'rock'
      puts "It's a tie!" if @computer.move == 'paper'
      puts "Computer won!" if @computer.move == 'scissors'
    when 'scissors'
      puts "You won!" if @computer.move == 'paper'
      puts "It's a tie!" if @computer.move == 'scissors'
      puts "Computer won!" if @computer.move == 'rock'
    end
  end

  def play_again?
    puts "Would you like to play again? ('y' for yes)"
    answer = gets.chomp.downcase
    return true if answer.start_with? 'y'

    return false
  end

  def play
    display_welcome_message
    loop do
      @human.choose
      @computer.choose
      display_winner

      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
