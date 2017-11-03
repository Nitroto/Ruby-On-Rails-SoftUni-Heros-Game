require_relative './hero_factory.rb'

class Game
  def initialize(hero_factory)
    @hero_factory = hero_factory
    @good_guys = []
    @bad_guys = []
  end

  def run
    number_of_good_guys = ask_user('Enter number of Good Guys [1 - 4]:', 4)
    generate_good_guys(number_of_good_guys)
    puts 'Here are the good guys:'
    puts @good_guys

    number_of_bad_guys = ask_user('Enter number of Bad Guys [1 - 4]:', 4)
    generate_bad_guys(number_of_bad_guys)
    puts 'Bad guys will be generated automatically.'

    puts 'Here are the bad ones:'
    puts @bad_guys

    puts "\n"

    while !@good_guys.empty? && !@bad_guys.empty?
      (0..@good_guys.count).each do |i|
        puts "#{@good_guys[i]}\nPick your enemy"
        puts "\nPick your enemy"

        (0...@bad_guys.count).each do |j|
          puts "#{j + 1}) #{@bad_guys[j]}"
        end
        enemy = gets.chomp.to_i - 1 # check input

        run_fight @good_guys[i], @bad_guys[enemy]

        break if @good_guys.empty? || @bad_guys.empty?
      end
    end

    puts 'The End'
  end

  private

  def run_fight(good_guy, bad_guy)
    round = 1
    puts "FIGHT NOW!"
    while good_guy.is_alive && bad_guy.is_alive
      puts "Round #{round}\n"
      round += 1

      # Good guy turn
      strength = good_guy.strength * throw_dice
      make_an_attack good_guy, bad_guy, strength

      break unless bad_guy.is_alive

      # Double hit special skill
      if good_guy.special_skill == 'double_hit'
        puts 'Double hit!'
        good_guy.hit(bad_guy, strength)
      end

      puts "\n"
      break unless bad_guy.is_alive

      # Bad guy turn
      strength = bad_guy.strength * throw_dice
      make_an_attack bad_guy, good_guy, strength

      # Retreat special skill
      if good_guy.special_skill == 'retreat'
        if hero_escape
          puts "#{good_guy.nickname} runs away from fight!"
          break
        end
      end
    end

    if good_guy.special_skill == 'extra_life'
      if hero_revival
        puts "#{good_guy.nickname} has risen from the dead"
        good_guy.use_revive
        run_fight(good_guy, bad_guy)
      end
    else
      end_fight(good_guy, bad_guy)
    end
  end

  def end_fight(good_guy, bad_guy)
    if good_guy.is_alive && !bad_guy.is_alive
      puts "#{bad_guy.nickname} is dead.\nVictory"
      @bad_guys.delete(bad_guy)
    elsif bad_guy.is_alive && !good_guy.is_alive
      puts "#{good_guy.nickname} is dead.\nDefeat"
      @good_guys.delete(good_guy)
    end
  end

  def hero_revival
    puts "You have an extra live and you can revive yourself.\nDo you want to revive yourself now?\nyes : no"
    user_answer = gets.chomp.downcase
    user_answer == 'yes'
  end

  def hero_escape
    puts "You have special skill \"retreat\" and can run away from this fight.\nDo you want to escape from the fight now?\nyes : no"
    user_answer = gets.chomp.downcase
    user_answer == 'yes'
  end

  def make_an_attack(attacking, attacked, strength)
    puts "#{attacking.nickname}(#{attacking.vitality}) vs #{attacked.nickname}(#{attacked.vitality})"
    puts "#{attacking.nickname} hits #{attacked.nickname} with #{strength}"
    attacking.hit(attacked, strength)
  end

  def throw_dice
    rand(1..6)
  end

  def generate_good_guys(number)
    1.upto(number) do
      identity = create_identity
      hero = @hero_factory.create_good_guy(identity)
      @good_guys.push(hero)
    end
  end

  def generate_bad_guys(number)
    1.upto(number) do
      villain = @hero_factory.create_bad_guy
      @bad_guys.push(villain)
    end
  end

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

  def create_identity
    puts 'Enter name for the hero'
    name = gets.chomp
    puts 'Enter nickname for the hero'
    nickname = gets.chomp
    Identity.new(name, nickname)
  end

end
