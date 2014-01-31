require 'pry'
require 'rspec'

require_relative '../models/map'

describe Map do
  let(:verm) { Room.new("Vermillion", {north: nil, east: "Ochre", south: "Aquamarine", west: nil}) }
  let(:ochre) { Room.new("Ochre", {north: nil, east: nil, south: "Red", west: nil}) }
  let(:red) { Room.new("Red", {north: nil, east: nil, south: nil, west: nil}) }
  let(:aqua) { Room.new("Aquamarine", {north: nil, east: nil, south: nil, west: nil}) }
  let(:test_map) { Map.new(*[verm, ochre, red, aqua]) }

  it 'is initialized with a group of rooms from an array and a final_dist hash (for shortest distance)' do
    expect(test_map.rooms.first.name).to eq("Vermillion")
  end

  describe '#establish_queue' do
    it 'returns a hash with the room names as keys to distance data' do
      expect(test_map.send(:establish_queue)).to be_an(Hash)
    end
  end

  describe '#set_initial_values' do
    it 'resets @final_dist variables' do
      test_map.final_dist[:yaba_daba] = "do"
      test_map.send(:set_initial_values, verm, red)
      expect(test_map.final_dist.empty?).to be_true
    end

    it 'sets the source of the shortest_path method to distance to 0 and prev_node to nil' do
      test_map.send(:set_initial_values, verm, red)
      q = test_map.priority_queue
      source = verm.name
      expect(q[source][:distance] == 0).to be_true
      expect(q[source][:prev_node] == nil).to be_true
    end

    it 'sets creates keys and distance hashes for each node of the map' do
      test_map.send(:set_initial_values, verm, red)
      delta = test_map.rooms.map(&:name) - test_map.priority_queue.keys 
      expect(delta.empty?).to be_true
    end
  end

  describe '#set_values' do
    it 'breaks out of the loop if the priority_queue has one element' do
      # test_map.stub()
      expect(test_map.final_dist.empty?).to be_true
    end


  end

  describe '#shortest_path' do
    it 'returns an array' do
      verm = test_map.rooms.first
      expect(test_map.shortest_path(verm, verm)).to be_an(Array)
    end

    it 'returns an array of room names' do
      expect(test_map.shortest_path(verm, red).include?("Ochre")).to be_true
    end

    it 'returns an array of room names' do
      path = test_map.shortest_path(verm, red)
      expect(path.include?("Ochre")).to be_true
      expect(path.include?("Red")).to be_true
    end

    it 'the array should contain the number of elements (moves) to get to the destination' do
      expect(test_map.shortest_path(verm, red).count).should eq(2)
    end

    it 'the first element in the array should be the room the source should move to next' do
      expect(test_map.shortest_path(verm, red)[0]).should eq("Ochre")
    end
  end

end