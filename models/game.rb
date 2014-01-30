require 'pry'
require_relative 'room'
require_relative 'grue'
require_relative 'jewel'
require_relative 'map'
require_relative 'player'

class Game
  attr_reader :map, :player, :grue

  def initialize(map)
    @map    = map
    @player = create_new_player
    @grue   = create_new_grue
    @dead   = false
  end

  def create_new_player
    Player.new(@map.rooms.sample.name)
  end

  def create_new_grue
    Grue.new("somewhere")
  end

  def play
    grue   = find_position(@grue)
    player = find_position(@player)
  end

  def find_position(creature)
    @map.rooms.find do |room|
      room.name == creature.position
    end
  end

  def distance_between_rooms(start, goal)
    player_pos = find_position(@player)
    grue_pos = find_position(@grue)
  end

end

vermillion   = Room.new("Vermillion", {north: nil, east: "Ochre", south: "Aquamarine", west: nil})
ochre        = Room.new("Ochre", {north: nil, east: "Chartreuse", south: nil, west: "Vermillion"})
chartreuse   = Room.new("Chartreuse", {north: nil, east: "Ochre", south: "Emerald", west: nil})
lavender     = Room.new("Lavender",{north: "Chartreuse", east: nil, south: "Burnt Sienna", west: nil})
emerald      = Room.new("Emerald", {north: nil, east: "Lavender", south: "Aquamarin", west: "Cobalt"})
aquamarine   = Room.new("Aquamarine", {north: nil, east: nil, south: "Violet", west: "Cobalt"})
cobalt       = Room.new("Cobalt", {north: "Vermillion", east: nil, south: "Burnt Sienna", west: nil})
violet       = Room.new("Violet", {north: nil, east: "Burnt Sienna", south: "Chartreuse", west: nil})
burnt_sienna = Room.new("Burnt Sienna", {north: "Emerald", east: "Lavender", south: nil, west: nil})

rooms = [vermillion, ochre, chartreuse, lavender, emerald, aquamarine, cobalt, violet, burnt_sienna]
map = Map.new(*rooms)
new_game = Game.new(map)
binding.pry
puts new_game