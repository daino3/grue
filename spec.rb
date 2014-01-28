require 'rspec'
require 'pry'
require_relative 'jewel'
require_relative 'room'
require_relative 'map'
require_relative 'grue'
require_relative 'player'

describe Jewel do
  let(:jewel) { Jewel.new }
  COLORS = { green: 0.7, red: 1.3, yellow: 0.5, orange: 1.0, purple: 0.2, blue: 1.5}
  GEM_TYPES = {"Gem of Azeroth" => 5, "Gem of Totality" => 8, "Gem of the Peasants" => 2, "Gem of the Warlord" => 7, "Gem of the Gods" => 10}

  it 'initializes with accessible attributes' do
    expect(COLORS.keys.include?(jewel.color)).to be(true)
    expect(GEM_TYPES.keys.include?(jewel.type)).to be(true)
    expect(jewel.name.class == String).to be(true)
  end

  describe '#worth' do
    it 'multiplies gem types and colors and returns an integer' do
      value = jewel.worth
      value.should be_between(0, 20)
    end
  end

end

describe Room do
  let(:test_room) { Room.new("Vermillion", {north: nil, east: "Ochre", south: "Aquamarine", west: nil}) }

  it 'initializes with a name, rooms as a hash and empty contents' do
    expect(test_room.name).to eq("Vermillion")
    expect(test_room.rooms).to be_an(Hash)
    expect(test_room.contents.empty?).to be_true
  end

end

describe Map do
  let(:room) { Room.new("Vermillion", {north: nil, east: "Ochre", south: "Aquamarine", west: nil}) }
  let(:test_map) { Map.new(*[room]) }

  it 'is initialized with a group of rooms from an array' do
    expect(test_map.rooms.first.name).to eq("Vermillion")
  end

end

describe Grue do
  let(:grue) { Grue.new("some room", 8)}

  it 'is initialized with a position (key for map) and number of gems' do
    expect(grue.position).to eq("some room")
    expect(grue.gems.count).to eq(8)
  end

  describe '#total_grue_worth' do
    it 'calculates how much the grue\'s gems are worth' do
      expect(grue.total_grue_worth).to eq(grue.gems.map(&:worth).inject(:+))
    end
  end

end

describe Player do
  let(:player) { Player.new("some room") }

  it 'is initialized with a position (key for map) and a gem bag' do
    expect(player.position).to eq("some room")
    expect(player.gem_bag.empty?).to be_true
  end

end