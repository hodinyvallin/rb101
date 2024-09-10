LANGUAGE = 'es'

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def messages(message, language='en')
  MESSAGES[language][message]
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  if num.include?('.')
    Float(num) rescue false
  else
    Integer(num) rescue false
  end
end

def operation_to_message(op)
  message_en = case op
               when '1'
                 'Adding'
               when '2'
                 'Subtracting'
               when '3'
                 'Multiplying'
               when '4'
                 'Dividing'
               end
  message_es = case op
               when '1'
                 'Sumar'
               when '2'
                 'Restar'
               when '3'
                 'Multiplicar'
               when '4'
                 'Dividir'
               end
  if LANGUAGE == 'en'
    message_en
  elsif LANGUAGE == 'es'
    message_es
  end
end

prompt(messages('welcome', LANGUAGE))

name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt(messages('valid_name', LANGUAGE))
  else
    break
  end
end

prompt("#{messages('greeting', LANGUAGE)} #{name}.")

loop do
  number1 = ''
  loop do
    prompt(messages('first_number', LANGUAGE))
    number1 = Kernel.gets().chomp()

    if valid_number?(number1)
      break
    else
      prompt(messages('valid_number', LANGUAGE))
    end
  end

  number2 = ''
  loop do
    prompt(messages('second_number', LANGUAGE))
    number2 = Kernel.gets().chomp()

    if valid_number?(number2)
      break
    else
      prompt(messages('valid_number', LANGUAGE))
    end
  end
  
  prompt(messages('operator', LANGUAGE))
  
  operator = ''
  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(messages('valid_operator', LANGUAGE))
    end
  end

  prompt("#{operation_to_message(operator)} #{messages('calculating', LANGUAGE)}")

  result = case operator 
           when '1'
             number1.to_i() + number2.to_i()
           when '2'
             number1.to_i() - number2.to_i()
           when '3'
             number1.to_i() * number2.to_i()
           when '4'
             number1.to_f() / number2.to_f()
           end

  prompt("#{messages('result', LANGUAGE)} #{result}")

  prompt(messages('another_calculation', LANGUAGE))
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt(messages('goodbye', LANGUAGE))