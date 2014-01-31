class ShortestPath
  attr_reader :map, :priority_queue, :final_dist 

  def initialize(map, source, destination)
    @map = map
    @source = source
    @destination = destination
    @priority_queue = build_queue
    @final_dist = {}
  end

  def find_path
    # set up data structure to find shortest path to all nodes (optimal substructure)
    set_initial_values
    
    until @priority_queue.empty?
      # extract rooms with min distances
      min_dist = find_current_minimums
      # iterate through queue and set values for distances
      set_values(min_dist)
    end
    get_route
  end

  private 

  def set_values(minimum)
    @priority_queue.each do |room_name, dist_data|
      if @priority_queue.count == 1
        # break out of the loop if there's only one room left (return breaks us out of the loop)
        @final_dist[room_name] = @priority_queue.delete(room_name)
        return @final_dist
      elsif dist_data[:distance] == minimum
        set_adjacents(room_name)
        # delete the room from the priority queue and add it to the final_distance hash
        @final_dist[room_name] = @priority_queue.delete(room_name)
      end
    end
  end

  def set_adjacents(room_name)
    adj_rooms = @map.find_room_by_name(room_name).outbound_doors
    adj_rooms.each do |adj_room_name|
      set_adj_room_values(room_name, adj_room_name)
    end
  end

  def set_adj_room_values(room_name, adj_room_name)
    room_dist = @priority_queue[room_name][:distance]
    adj_dist  = @priority_queue[adj_room_name][:distance]
    
    if adj_dist.nil? || adj_dist > room_dist + 1
      @priority_queue[adj_room_name][:distance]  = room_dist + 1
      @priority_queue[adj_room_name][:prev_node] = room_name
    end
  end

  def get_route
    final = @destination.name
    route = [final]
    prev_node_name = ""

    # trace back through @final_dist hash
    until route.first == @source.name
      @final_dist.each do |room_name, dist_data|
        if room_name == final
          prev_node_name = dist_data[:prev_node]
          route.unshift(prev_node_name)
        end
      end
      final = prev_node_name
    end
    route.shift #refactor this? Would like the first element in the array to be the next move
    route
  end

  def build_queue
    distance_data = {}
    # set up data structure to house all nodes of the map for shortest_path method 
    @map.rooms.each do |room|
      distance_data[room.name] = {distance: nil, prev_node: nil}
    end
    distance_data
  end

  def set_initial_values
    raise ArgumentError, "Destination does not exist in current map" if !@priority_queue.has_key?(@destination.name)
    @priority_queue.each do |room_name, dist_data|
      dist_data[:distance]  = nil
      dist_data[:prev_node] = nil
    end
    @priority_queue[@source.name][:distance] = 0
  end

  def find_current_minimums
    @priority_queue.map do |room_name, dist_data| 
      dist_data[:distance]
    end.compact.min
  end
end