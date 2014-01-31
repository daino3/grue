require 'rspec'
require_relative '../models/shortest_path'

describe ShortestPath do
  let(:verm) { Room.new("Vermillion", {north: nil, east: "Ochre", south: "Aquamarine", west: nil}) }
  let(:ochre) { Room.new("Ochre", {north: nil, east: nil, south: "Red", west: nil}) }
  let(:red) { Room.new("Red", {north: nil, east: nil, south: nil, west: nil}) }
  let(:aqua) { Room.new("Aquamarine", {north: nil, east: nil, south: nil, west: nil}) }
  let(:test_map) { Map.new(*[verm, ochre, red, aqua]) }
  let(:shortest) { ShortestPath.new(test_map, verm, red)}

  describe '#establish_queue' do
    it 'returns a hash with the room names as keys to distance data' do
      expect(shortest.send(:build_queue)).to be_an(Hash)
    end
  end

  describe '#set_initial_values' do

    it 'sets the source of the shortest_path method to distance to 0 and prev_node to nil' do
      shortest.send(:set_initial_values)
      q = shortest.priority_queue
      source = verm.name
      expect(q[source][:distance] == 0).to be_true
      expect(q[source][:prev_node] == nil).to be_true
    end

    it 'creates keys and distance hashes for each node of the map' do
      shortest.send(:set_initial_values)
      delta = shortest.map.rooms.map(&:name) - shortest.priority_queue.keys 
      expect(delta.empty?).to be_true
    end
  end

  describe '#set_adjacents' do
    it 'sets the distances of the adjacent rooms' do
      shortest.send(:set_initial_values) # code smell - must call this prior to set_adjacents
      shortest.send(:set_adjacents, "Vermillion")
      adjacent_names = verm.doors.values.find_all { |value| value != nil } 
      adjacent_names.each do |room_name|
        expect(shortest.priority_queue[room_name][:distance] == 1).to be_true
      end
    end

    it 'sets the previous node value for the adjacent rooms' do
      shortest.send(:set_initial_values) # code smell - must call this prior to set_adjacents
      shortest.send(:set_adjacents, "Vermillion")
      adjacent_names = verm.doors.values.find_all { |value| value != nil } 
      adjacent_names.each do |room_name|
        expect(shortest.priority_queue[room_name][:prev_node] == verm.name).to be_true
      end
    end
  end

  describe '#set_values' do
    it 'breaks out of the loop if the priority_queue has one element' do
      # alt_test = Map.new(*[verm])
      # expect(alt_test.send(:set_values, 1)).to be_true
    end
  end

  describe '#shortest_path' do
    it 'returns an array' do
      verm = shortest.map.rooms.first
      expect(shortest.find_path).to be_an(Array)
    end

    it 'returns an array of room names' do
      path = shortest.find_path
      expect(path.include?("Ochre")).to be_true
      expect(path.include?("Red")).to be_true
    end

    it 'the array should contain the number of elements (moves) to get to the destination' do
      expect(shortest.find_path.count).should eq(2)
    end

    it 'the first element in the array should be the room the source should move to next' do
      expect(shortest.find_path[0]).should eq("Ochre")
    end
  end

end