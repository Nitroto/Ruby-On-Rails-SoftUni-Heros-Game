require_relative './lib/hero_factory'
require_relative './lib/game_engine'

hero_factory = HeroFactory.new
game = Game.new(hero_factory)
game.run
