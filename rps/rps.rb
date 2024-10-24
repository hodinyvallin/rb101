VALID_CHOICES = {
  'r' => 'Rock',
  'p' => 'Paper',
  's' => 'Scissors',
  'l' => 'Lizard',
  'S' => 'Spock'
}

WINNING_MOVES = {
  'Rock' => {
    'Lizard' => 'Rock crushes Lizard.',
    'Scissors' => 'Rock crushes Scissors.'
  },
  'Paper' => {
    'Rock' => 'Paper covers Rock.',
    'Spock' => 'Paper disproves Spock.'
  },
  'Scissors' => {
    'Paper' => 'Scissors cuts Paper.',
    'Lizard' => 'Scissors decapitates Lizard.'
  },
  'Lizard' => {
    'Spock' => 'Lizard poisons Spock.',
    'Paper' => 'Lizard eats Paper.'
  },
  'Spock' => {
    'Scissors' => 'Spock smashes Scissors.',
    'Rock' => 'Spock vaporizes Rock.'
  }
}

def prompt(message)
  puts "=> #{message}"
end

def win?(first, second)
  WINNING_MOVES[first].include?(second)
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("#{WINNING_MOVES[player][computer]} You won.")
  elsif win?(computer, player)
    prompt("#{WINNING_MOVES[computer][player]} Computer won.")
  else
    prompt("It's a tie.")
  end
end

def display_grand_winner(player_score, computer_score)
  if player_score == 3
    prompt("You reached 3 wins. You are the grand winner.")
  elsif computer_score == 3
    prompt("Computer reached 3 wins. Computer is the grand winner.")
  end
end

loop do
  prompt("Let's play. Whoever gets 3 wins is the grand winner. Good luck.")
  player_score = 0
  computer_score = 0
  choice = ''
  until player_score == 3 || computer_score == 3
    loop do
      prompt("Choose one:")
      puts <<-MSG
        'r' for rock
        'p' for paper
        's' for scissors
        'l' for lizard
        'S' for Spock
      MSG

      choice = gets.chomp
      if VALID_CHOICES.include?(choice)
        choice = VALID_CHOICES[choice]
        break
      else
        prompt("That's not a valid choice.")
      end
    end

    computer_choice = VALID_CHOICES.values.sample

    prompt("You chose #{choice}. Computer chose #{computer_choice}.")
    display_results(choice, computer_choice)

    if win?(choice, computer_choice)
      player_score += 1
    elsif win?(computer_choice, choice)
      computer_score += 1
    end
    prompt("Your score: #{player_score}  Computer's score: #{computer_score}")
  end

  display_grand_winner(player_score, computer_score)

  prompt("Do you want to play again? (y/n)")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing. Goodbye.")
