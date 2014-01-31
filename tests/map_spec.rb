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

  describe '#shortest_path' do
    it 'returns an array' do
      expect(test_map.shortest_path(verm, red)).to be_an(Array)
    end

    it 'returns the room to reach the destination the quickest' do
      expect(test_map.shortest_path(verm, red)[0]).to eq("Ochre")
    end
  end

  describe '#find_room_by_name' do
    it 'returns the room object from the map' do
      expect(test_map.find_room_by_name("Red").name).to eq("Red")
    end
  end

end