require_relative 'room'
require_relative 'grue'
require_relative 'jewel'
require_relative 'map'
require_relative 'player'
require_relative 'shortest_path'

class Game
  attr_reader :map, :player, :grue, :dead, :winner, :resting, :moves, :current_room

  def initialize(map)
    @map     = map
    @player  = Player.new(@map.rooms.sample.name)
    @grue    = Grue.new(get_furthest_room(@player.position))
    @dead    = false
    @winner  = false
    @resting = false
    @moves   = 5
    @current_room = find_room(@player.position)
  end

  def play
    until @dead || @winner
      if !@resting
        travel_options = gather_travel_options
        display_position_message(travel_options)
        input = gets.chomp.downcase
        check_input(input, travel_options)
        move_player(input)
        check_for_grue
        check_for_gems
        check_for_dias
        need_rest?
      else
        move_grue
        @resting = false
        @moves = 5
      # binding.pry
      end
    end
  end

  def check_for_gems
    if !@current_room.gems.empty?
      @current_room.gems.each do |jewel|
        @player.gems << jewel
        puts jewel.define_gem
      end
      @current_room.gems = []
    end
  end

  def need_rest?
    if @moves == 0 
      @resting = true
      puts "You need to rest - you lay down and fall asleep. The Grue haunts your dreams."
    else
      puts "You have #{@moves} move(s) left before you need to rest"
    end
  end

  def check_for_dias
    if @current_room.dias
      if @player.gems.count == 5
        puts "You approach the dias and place your gems in the slots. You are transported back home"
        puts "Your total score is #{@player.gem_worth}"
      else
        puts "You see a glowing dias in the middle of the room which requires 5 gems to activate"
      end
    end
  end

  def check_for_grue
    binding.pry
    grues_adj_rooms = find_room(@grue.position).outbound_doors
    if @grue.position == @current_room.name
      @current_room.gems << @grue.gems.pop
      puts "You come upon the Grue! Terrified, the Grue drops a gem and takes off"
      @grue.position = grues_adj_rooms[rand(0..(grues_adj_rooms.count-1))] 
    elsif grues_adj_rooms.include?(@current_room.name)
      puts "The Grue is nearby. You can smell him" 
    end
  end

  def move_player(direction)
    room = @player.position
    @player.position = find_room(room).doors[direction.to_sym]
    @current_room = find_room(@player.position)
    @moves -= 1
  end

  def move_grue
    @grue.position = get_shortest_path.first

    if @grue.position == @current_room.name
      puts "The Grue catches you while you sleep. You are dead"
      dead = true
    end
  end

  def respawn
    Game.new(@map)
  end

  def display_position_message(options)
    puts "You are in the #{@player.position} room. Where do you want to go next? (#{options})"
  end

  def check_input(input, travel_options)
    until valid_input(input)
      puts "That isn't a valid direction. Please enter one of the options #{travel_options}"
      input = gets.chomp.downcase
    end
  end

  def valid_input(input)
    find_room(@player.position).doors[input.to_sym] != nil    
  end

  def gather_travel_options
    travel_options = @current_room.doors
    options = travel_options.map do |direction, next_room|
      direction if next_room
    end.compact.map(&:to_s)
    options.to_s.gsub(/[(\[)(\])]/, '')
  end

  private

  def get_furthest_room(room)
    room = find_room(room)
    path = ShortestPath.new(@map, room)
    path.get_longest_route
  end

  def get_shortest_path
    player_room = find_room(@player.position)
    grue_room   = find_room(@grue.position)
    path = ShortestPath.new(@map, grue_room, player_room)
    path.find_path
  end

  def find_room(room_name)
    @map.find_room_by_name(room_name)
  end

end