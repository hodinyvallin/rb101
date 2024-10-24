def valid_positive_number?(num)
  if num.include?('.')
    begin
      Float(num) && num.to_f > 0
    rescue
      false
    end
  else
    begin
      Integer(num) && num.to_i > 0
    rescue
      false
    end
  end
end

def display_prompt(message)
  puts "=> #{message}"
end

display_prompt("Welcome to Loan Calculator! Name please:")

name = ''
loop do
  name = gets.chomp
  break unless name.empty?
  display_prompt("Make sure to use a valid name.")
end

display_prompt("Hi #{name}.")

loop do
  amount = ''
  loop do
    display_prompt("What is the loan amount?")
    display_prompt("(Example: 50000.00)")
    print "$ "
    amount = gets.chomp
    break if valid_positive_number?(amount)
    display_prompt("Must enter a positive number. Try again.")
  end

  annual_interest_rate = ''
  loop do
    display_prompt("What is the annual interest rate?")
    display_prompt("(Example: 5 for 5% or 2.5 for 2.5%)")
    print "% "
    annual_interest_rate = gets.chomp
    break if valid_positive_number?(annual_interest_rate)
    display_prompt("Must enter a positive number. Try again.")
  end

  months = ''
  loop do
    display_prompt("What is the loan duration?")
    display_prompt("Please write duration in months:")
    months = gets.chomp
    break if valid_positive_number?(months)
    display_prompt("Must enter a positive number. Try again.")
  end

  amount = amount.to_f
  months = months.to_i
  monthly_interest_rate = (annual_interest_rate.to_f / 100) / 12
  monthly_payment = amount *
                    (monthly_interest_rate / 
                    (1 - (1 + monthly_interest_rate)**(-months)))

  display_prompt("Calculating your monthly payment...")
  display_prompt("Your monthly payment is: $#{format('%.2f', monthly_payment)}")
  display_prompt("Would you like to perform another calculation? (Yes/No)")
  calculate_again = gets.chomp
  break unless calculate_again.downcase.start_with?('y')
end

display_prompt("Thank you for using the Loan Calculator. Goodbye!")
