require_relative 'room'
require_relative 'grue'
require_relative 'jewel'
require_relative 'map'
require_relative 'player'
require_relative 'shortest_path'

class Game
  attr_accessor :player_room, :grue_room, :moves, :resting
  attr_reader :map, :player, :grue, :dead, :winner 

  def initialize(map, difficulty = nil)
    @map     = map
    @player  = Player.new
    @grue    = Grue.new
    @dead    = false
    @winner  = false
    @resting = false
    @moves   = 5
    @player_room = @map.rooms.sample
    @grue_room = get_furthest_room(@player_room)
  end

  def play
    determine_difficulty
    until @dead || @winner
      if !@resting
        display_game_status
        travel_options = gather_travel_options
        display_position_message(travel_options)
        puts '--------------------'
        prompt; input = gets.chomp.downcase
        clean_input = check_input(input, travel_options)
        move_player(clean_input)
        check_for_grue
        check_for_gems
        check_for_dias
        need_rest? if !@winner
      else
        move_grue
        @resting = false
        @moves = 5
      end
    end
    play_again?
  end

  def check_for_gems
    if !@player_room.gems.empty?
      @player_room.gems.each do |jewel|
        @player.gems << jewel
        puts jewel.define_gem
      end
      @player_room.gems = []
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
    if @player_room.dias
      if @player.gems.count >= 5
        @winner = true
        puts "You approach the dias and place your gems in the slots. You are transported back home! You've WON!!"
        puts "Your total score is #{@player.gem_worth}"
      else
        puts "You see a glowing dias in the middle of the room which requires 5 gems to activate"
      end
    end
  end

  def check_for_grue
    grues_adj_rooms = @grue_room.outbound_doors
    if @grue_room.name == @player_room.name
      @player_room.gems << @grue.gems.pop
      puts "You come upon the Grue! Terrified, the Grue drops a gem and takes off"
      @grue_room = find_room(grues_adj_rooms[rand(0..(grues_adj_rooms.count-1))]) 
    elsif grues_adj_rooms.include?(@player_room.name)
      puts "The Grue is nearby. You can smell him" 
    end
  end

  def move_player(direction)
    next_room_name = @player_room.doors[direction.to_sym]
    @player_room = find_room(next_room_name)
    @moves -= 1
  end

  def move_grue
    @grue_room = find_room(get_shortest_path.first)

    if @grue_room.name == @player_room.name
      puts "The Grue catches you while you sleep. You are dead"
      @dead = true
    end
  end

  def gather_travel_options
    options = @player_room.doors.map do |direction, next_room|
      direction if next_room
    end.compact.map(&:to_s)
    
    options.to_s.gsub(/[(\[)(\])]/, '')
  end

  private

  def display_game_status
    num_gems = @player.gems.count
    score = @player.gem_worth || 0
    if num_gems < 5
      puts "You have #{num_gems} gems worth #{score} tokens. You need #{5-num_gems} more to win."
    elsif num_gems >= 5
      puts "You have #{num_gems} gems worth #{score} tokens. You should head to the room with glowing dias to win."
    end
  end

  def determine_difficulty
    puts 'what is your difficult? (easy, medium, hard)'
    prompt; input = gets.chomp.downcase
    
    until ['easy', 'medium', 'hard'].include?(input)
      puts "Sorry, what? (easy, medium, hard)"
      prompt; input = gets.chomp.downcase
    end

    if input == 'easy'
      seed_map_with_gems(5)
    elsif input == 'medium'
      seed_map_with_gems(3)
    elsif input == 'hard'
      seed_map_with_gems(1)      
    end
  end

  def play_again?
    puts 'Would you like to play Again? (YES / NO)'
    prompt; input = gets.chomp.downcase
    
    until input == "yes" || input == "no"
      puts "Sorry, is that a 'YES' or a 'NO'?"
      input = gets.chomp.downcase
    end

    if input == 'yes'
      new_game = Game.new(@map)
      new_game.play
    elsif input == 'no'
      puts 'Goodbye!'
      return
    end
  end

  def seed_map_with_gems(num_gems)
    num_gems.times do
      @map.rooms.sample.gems << Jewel.new 
    end
  end

  def display_position_message(options)
    puts "You are in the #{@player_room.name} room. Where do you want to go next? (#{options})"
  end

  def check_input(input, travel_options)
    until valid_input(input)
      puts "That isn't a valid direction. Please enter one of the options #{travel_options}"
      prompt; input = gets.chomp.downcase
    end
    return input
  end
  
  def valid_input(input)
    @player_room.doors[input.to_sym] != nil    
  end

  def get_furthest_room(room)
    path = ShortestPath.new(@map, room)
    room_name = path.get_longest_route
    find_room(room_name)
  end

  def get_shortest_path
    path = ShortestPath.new(@map, @grue_room, @player_room)
    path.find_path
  end

  def find_room(room_name)
    @map.find_room_by_name(room_name)
  end

  def prompt
    print '>> '
  end

end