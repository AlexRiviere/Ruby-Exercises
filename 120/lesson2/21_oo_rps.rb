class Move
  VALUES = ['rock', 'paper', 'scissors', 'spock', 'lizard']
  
  def initialize(value, player)
    @value = value
  end
  
  def scissors?
    @value == 'scissors'
  end

  def paper?
    @value == 'paper'
  end

  def rock?
    @value == 'rock'
  end
  
  def lizard?
    @value == 'lizard'
  end
  
  def spock?
    @value == 'spock'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (rock? && other_move.lizard?) ||
      (paper? && other_move.rock?) ||
      (paper? && other_move.spock?) ||
      (scissors? && other_move.paper?) ||
      (scissors? && other_move.lizard?) ||
      (spock? && other_move.rock?) ||
      (spock? && other_move.scissors?) ||
      (lizard? && other_move.spock?) ||
      (lizard? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (rock? && other_move.spock?) ||
      (paper? && other_move.scissors?) ||
      (paper? && other_move.lizard?) ||
      (scissors? && other_move.rock?) || 
      (scissors? && other_move.spock?) ||
      (spock? && other_move.lizard?) ||
      (spock? && other_move.paper?) ||
      (lizard? && other_move.rock?) ||
      (lizard? && other_move.scissors?) 
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end
end

class Human < Player
  def set_name
    n = nil

    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, you must enter a value."
    end

    self.name = n
  end

  def choose
    choice = nil

    loop do
      puts "Please choose rock, paper, scissors, spock or lizard:"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end

    self.move = Move.new(choice, self)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', "Hal", "Chappie"].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample, self)
  end
end

class RPSGame
  attr_accessor :human, :computer
  
  @@history_of_moves = []

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Spock, Lizard!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Spock, Lizard. Good bye!"
  end

  def display_moves
    player_move = "#{human.name} chose #{human.move}"
    @@history_of_moves << player_move
    puts player_move
    computer_move = "#{computer.name} chose #{computer.move}"
    @@history_of_moves << computer_move
    puts computer_move
  end
  
  def display_history_of_moves
    puts "History of Moves:"
    round = 1
    @@history_of_moves.each_slice(2) do |slice|
      puts "In round #{round}, #{slice[0]} and #{slice[1]}"
      round += 1
    end
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won this round!"
      human.score += 1
    elsif human.move < computer.move
      puts "#{computer.name} won this round"
      computer.score += 1
    else
      puts "It's a tie this round"
    end
  end
  
  def display_score
    puts "The current score is #{human.name}: #{human.score} to #{computer.name}: #{computer.score} "
  end
  
  def display_final_score
    if human.score > computer.score
      puts "#{human.name} won the whole game!"
    elsif human.score < computer.score
      puts "#{computer.name} won the whole game!"
    else
      puts "It ended in a tie!"
    end
    puts "The final score is #{human.name}: #{human.score} to #{computer.name}: #{computer.score}"
  end

  def play_again?
    answer = nil
    return false if human.score == 3 || computer.score == 3
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n."
    end
    return false if answer.downcase == 'n'
    return true if answer.downcase == 'y'  
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      display_score
      break unless play_again?
    end
    display_final_score
    display_history_of_moves
    display_goodbye_message
  end
end

RPSGame.new.play


#keeping score and lizard/spock additions