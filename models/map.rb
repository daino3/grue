require 'pry'

class Map
  attr_reader :rooms, :final_dist, :priority_queue 

  def initialize(*rooms)
    @rooms = rooms
    @priority_queue = establish_queue
    @final_dist = {}
  end

  def shortest_path(source, destination)
    # find shortest path to all nodes - assume optimal substructure
    set_initial_values(source, destination)

    until @priority_queue.empty?
      # get minimum distance so you can extract consecutive rooms with min distance
      minimum_dist = current_min_dist
      # iterate through queue and set values for distances; 'pop' off queue and store in final_dist hash
      set_values(minimum_dist)
    end
    get_shortest_route(source, destination)
  end

  private 

  #---------------- Shortest Path Logic --------------#

  def set_values(minimum)
    @priority_queue.each do |room_name, dist_data|
      if @priority_queue.count == 1
        # break out of the loop if there's only one room left (return breaks us out of the loop)
        @final_dist[room_name] = @priority_queue.delete(room_name)
        return @final_dist
      elsif dist_data[:distance] == minimum
        # else take the elements with minimum distance and fill in data for their adjacents
        adj_rooms = find_room_by_name(room_name).outbound_doors
        adj_rooms.each do |adj_room_name|
          current_dist   = @priority_queue[adj_room_name][:distance]
          prev_room_dist = dist_data[:distance]

          if current_dist.nil? || current_dist > prev_room_dist + 1
            @priority_queue[adj_room_name][:distance]  = prev_room_dist + 1
            @priority_queue[adj_room_name][:prev_node] = room_name
          end
        end
        # delete the room from the queue and start again with the loop
        @final_dist[room_name] = @priority_queue.delete(room_name)
      end
    end
  end

  def get_shortest_route(source, destination)
    route = [destination.name]
    destination = destination.name
    prev_node_name = ""

    # trace back through @final_dist hash
    until route.first == source.name
      @final_dist.each do |room_name, dist_data|
        if room_name == destination
          prev_node_name = dist_data[:prev_node]
          route.unshift(prev_node_name)
        end
      end
      destination = prev_node_name
    end
    route.shift #refactor this, but would like the first element in the array to be the next move
    route
  end

  def establish_queue
    distance_data = {}
    # set up data structure to house all nodes of the map for shortest_path method 
    @rooms.each do |room|
      distance_data[room.name] = {distance: nil, prev_node: nil}
    end
    distance_data
  end

  def set_initial_values(source, destination)
    raise ArgumentError, "Destination does not exist in current map" if !@priority_queue.has_key?(destination.name)
    # reset values of @priority_queue & @final_dist if #shortest_path has been used before 
    @priority_queue = establish_queue
    @final_dist = {}
    @priority_queue.each do |room_name, dist_data|
        dist_data[:distance]  = nil
        dist_data[:prev_node] = nil
    end
    @priority_queue[source.name][:distance] = 0
  end

  def current_min_dist
    @priority_queue.map do |room_name, dist_data| 
      dist_data[:distance]
    end.compact.min
  end

  #---------------- Other --------------#  

  def find_room_by_name(name)
    @rooms.find do |room_obj| 
      room_obj.name == name
    end
  end

end