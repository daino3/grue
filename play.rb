require_relative 'models/map'
require_relative 'models/game'
require_relative 'config/game_map'

map = Map.new(*MAP_ROOMS)
new_game = Game.new(map)

new_game.play