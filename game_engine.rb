require './hero_factory.rb'

class Game
  def initialize(hero_factory)
    @hero_factory = hero_factory
    @good_guys = []
    @bad_guys = []
  end

  def run
    number_of_good_guys = ask_user('Enter number of Good Guys [1 - 4]:', 4)
    generate_good_guys(number_of_good_guys)
    puts 'Here are the good guys'
    puts @good_guys

    number_of_bad_guys = ask_user('Enter number of Bad Guys [1 - 4]:', 4)
    generate_bad_guys(number_of_bad_guys)
    puts 'Bad guys will be generated automatically'

    puts 'Here are the bad ones'
    puts @bad_guys
  end

  private

  def generate_good_guys(number)
    1.upto(number) do
      identity = create_identity
      hero = @hero_factory.create_good_guy(identity)
      @good_guys.push(hero)
    end
  end

  private

  def generate_bad_guys(number)
    1.upto(number) do
      villain = @hero_factory.create_bad_guy
      @bad_guys.push(villain)
    end
  end

  private

  def ask_user(message, max_guys)
    puts message
    begin
      user_input = gets.chomp
      user_input = Integer(user_input)
      raise 'Out of boundary exception' if user_input < 1 || user_input > max_guys
    rescue
      puts 'Wrong choice, try again ...'
      retry
    end
    user_input
  end

  private

  def create_identity
    puts 'Enter name for the hero'
    name = gets.chomp
    puts 'Enter nickname for the hero'
    nickname = gets.chomp
    Identity.new(name, nickname)
  end
end