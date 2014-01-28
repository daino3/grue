require 'rspec'

require_relative '../models/map'

describe Map do
  let(:room) { Room.new("Vermillion", {north: nil, east: "Ochre", south: "Aquamarine", west: nil}) }
  let(:test_map) { Map.new(*[room]) }

  it 'is initialized with a group of rooms from an array' do
    expect(test_map.rooms.first.name).to eq("Vermillion")
  end

end