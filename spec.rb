require 'rspec'
require 'pry'
require_relative 'jewel'
require_relative 'room'

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