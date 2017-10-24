require './game_engine.rb'
require './hero_factory.rb'

hero_factory = HeroFactory.new
game = Game.new(hero_factory)
game.run

