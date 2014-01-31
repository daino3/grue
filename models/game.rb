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

end

