require 'rspec'
require_relative '../models/room'

describe Room do
  let(:test_room) { Room.new("Vermillion", {north: nil, east: "Ochre", south: "Aquamarine", west: nil}) }

  it 'initializes with a name, doors as a hash and an empty gems array' do
    expect(test_room.name).to eq("Vermillion")
    expect(test_room.doors).to be_an(Hash)
    expect(test_room.gems.empty?).to be_true
  end

end