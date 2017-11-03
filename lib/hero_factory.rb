require_relative './hero/bad_guy.rb'
require_relative './hero/good_guy.rb'
require_relative './identity'

class HeroFactory
  def initialize; end

  def create_good_guy(identity)
    GoodGuy.new(identity, give_strength, give_special_skill)
  end

  def create_bad_guy
    identity = give_villain_identity
    BadGuy.new(identity, give_strength)
  end

  private

  def give_special_skill
    %w[double_hit extra_life retreat].sample
  end

  def give_strength
    rand(1..10)
  end

  def give_villain_identity
    identity = [
        {name: 'John Henry Irons', nickname: 'Steel'},
        {name: 'Jonathan Osterman', nickname: 'Dr. Manhattan'},
        {name: 'Natalia Allanovna Romanova', nickname: 'Black Widow'},
        {name: 'Walter Kovacs', nickname: 'Rorschach'},
        {name: 'Galan', nickname: 'Galactus'},
        {name: 'Loki Laufeyson', nickname: 'Loki'},
        {name: 'Remy LeBeau', nickname: 'Gambit'},
        {name: 'Alec Holland', nickname: 'Swamp Thing'},
        {name: 'Dru-Zod', nickname: 'General Zod'},
        {name: 'Raven Darkholme', nickname: 'Mystique'},
        {name: 'Adrian Veidt', nickname: 'Ozymandias'},
        {name: 'Maz ‘Magnus’ Eisenhardt', nickname: 'Magneto'},
        {name: 'Garth', nickname: 'Aqualad'},
        {name: 'Obadiah Stane', nickname: ' Iron Monger'},
        {name: 'Oswald Cobblepot', nickname: 'The Penguin'},
        {name: 'Lex Luthor', nickname: 'Lex'},
        {name: 'J’onn Jonzz', nickname: 'Martian Man Hunter'},
        {name: 'Kurr', nickname: 'Savage Dragon'}
    ].sample
    Identity.new(identity[:name], identity[:nickname])
  end
end
