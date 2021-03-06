require 'rspec'
require_relative '../models/shortest_path'

describe ShortestPath do
  let(:verm) { Room.new("Vermillion", {north: nil, east: "Ochre", south: "Aquamarine", west: nil}) }
  let(:ochre) { Room.new("Ochre", {north: nil, east: nil, south: "Red", west: nil}) }
  let(:red) { Room.new("Red", {north: nil, east: nil, south: nil, west: nil}) }
  let(:aqua) { Room.new("Aquamarine", {north: nil, east: nil, south: nil, west: nil}) }
  let(:test_map) { Map.new(*[verm, ochre, red, aqua]) }
  let(:shortest) { ShortestPath.new(test_map, verm, red)}

  describe '#build_queue' do
    it 'returns a hash with the room names as keys to distance data' do
      expect(shortest.send(:build_queue)).to be_an(Hash)
    end
    
    it 'sets the source of the shortest_path method to distance to 0 and prev_node to nil' do
      q = shortest.queue
      source = verm.name
      expect(q[source][:distance] == 0).to be_true
      expect(q[source][:prev_node] == nil).to be_true
    end

    it 'creates keys and distance hashes for each node of the map' do
      delta = shortest.map.rooms.map(&:name) - shortest.queue.keys 
      expect(delta.empty?).to be_true
    end
  end

  describe '#set_adjacents' do
    it 'sets the distances of the adjacent rooms' do
      shortest.send(:set_adjacents, "Vermillion")
      adjacent_names = verm.doors.values.find_all { |value| value != nil } 
      adjacent_names.each do |room_name|
        expect(shortest.queue[room_name][:distance] == 1).to be_true
      end
    end

    it 'sets the previous node value for the adjacent rooms' do
      shortest.send(:set_adjacents, "Vermillion")
      adjacent_names = verm.doors.values.find_all { |value| value != nil } 
      adjacent_names.each do |room_name|
        expect(shortest.queue[room_name][:prev_node] == verm.name).to be_true
      end
    end
  end

  describe '#set_values' do
    it 'breaks out of the loop if the queue has one element' do
      alt_red   = Room.new("Red", {north: nil, east: nil, south: nil, west: nil})
      alt_map   = Map.new(*[alt_red])
      alt_short = ShortestPath.new(alt_map, alt_red, alt_red)
      prior_queue = alt_short.queue.dup
      alt_short.send(:set_values, 0)
      expect(alt_short.final_dist == prior_queue).to be_true
      expect(alt_short.queue.empty?).to be_true
    end

    it 'sets the values of queue elements with minimum distances' do
      q = shortest.queue
      test_dist = 5
      q.each do |name, dist_data|
        dist_data[:distance] = test_dist if dist_data[:distance] == nil 
      end
      shortest.send(:set_values, 0)
      adj_rooms = shortest.map.find_room_by_name(verm.name).outbound_doors
      adj_rooms.each do |r_name|
        expect(q[r_name][:distance]).to eq(1)
      end 
    end
  end

  describe '#find_path' do
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

  describe '#get_longest_route' do
    it 'returns the room with the longest path' do
      dist_data = shortest.find_all_distances
      max_dist = dist_data.map do |room, dist_data|
        dist_data[:distance]
      end.max
      shortest.queue = shortest.send(:build_queue)
      next_room = shortest.get_longest_route
      expect(dist_data[next_room][:distance]).to eq(max_dist)
    end
  end

  describe '#get_quickest_route' do
    it 'returns the room with the shortest path' do
      dist_data = shortest.find_all_distances
      min_dist = dist_data.map do |room, dist_data|
        dist_data[:distance] if dist_data[:distance] != 0
      end.compact.min
      shortest.queue = shortest.send(:build_queue)
      shortest.find_all_distances
      next_room = shortest.send(:get_quickest_route)
      expect(dist_data[next_room[0]][:distance]).to eq(min_dist)
    end
  end

end