require 'rspec'
require_relative '../models/map'

describe Map do
  let(:verm) { Room.new("Vermillion", {north: nil, east: "Ochre", south: "Aquamarine", west: nil}) }
  let(:ochre) { Room.new("Ochre", {north: nil, east: nil, south: "Red", west: nil}) }
  let(:red) { Room.new("Red", {north: nil, east: nil, south: nil, west: nil}) }
  let(:aqua) { Room.new("Aquamarine", {north: nil, east: nil, south: nil, west: nil}) }
  let(:test_map) { Map.new(*[verm, ochre, red, aqua]) }

  it 'is initialized with a group of rooms from an array' do
    expect(test_map.rooms.first.name).to eq("Vermillion")
  end

end