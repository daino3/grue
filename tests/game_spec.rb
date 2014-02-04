require 'rspec'
require_relative '../models/game'
require_relative '../config/game_map'
require_relative 'spec_helper'

describe Game do
  let(:map) { Map.new(*MAP_ROOMS) }
  let(:game) { Game.new(map)}

  it 'is initialized with a map, a player, a grue, and variables: dead, winner, resting, moves and current_room ' do
    expect(game.map).to be_an(Map)    
    expect(game.player).to be_an(Player)
    expect(game.grue).to be_an(Grue)
    expect(game.dead).to be_false
    expect(game.winner).to be_false
    expect(game.resting).to be_false
    expect(game.moves).to eq(5)
    expect(game.player_room).to be_an(Room)
    expect(game.grue_room).to be_an(Room)
  end

  describe '#play' do
    it 'does something' do
    end
  end

  describe '#check_for_gems' do
    it 'gives the user the gems that are in the player\'s room' do
      game.player_room.gems << Jewel.new
      expect{game.send(:check_for_gems)}.to change{game.player.gems.count}.from(0).to(1)
    end

    it 'removes the gem from the contents of the room' do
      game.player_room.gems << Jewel.new
      expect{game.send(:check_for_gems)}.to change{game.player_room.gems.count}.from(1).to(0)
    end
  end

  describe '#check_for_grue' do
    context 'when the user enters the room' do
      it 'changes the position of the grue' do
        game.player_room = game.grue_room
        game.send(:check_for_grue)
        expect(game.grue_room != game.player_room)
      end

      it 'takes a gem from the grue' do
        game.player_room = game.grue_room
        expect{game.send(:check_for_grue)}.to change{game.grue.gems.count}.from(5).to(4)
      end
    end

    context 'when the grue is one turn away' do
      it 'notifies the player that the grue is close' do
        adj_room_name = game.grue_room.doors.values.find {|room| room != nil }
        adj_room = game.send(:find_room, adj_room_name)
        game.player_room = adj_room

        out = capture_stdout do 
          game.send(:check_for_grue)
        end

        out.string.should include("The Grue is nearby")
      end
    end
  end

  describe '#need_rest?' do
    context 'when the player has moves remaining' do
      it 'lets the user know how many moves he has left' do
        out = capture_stdout do 
          game.send(:need_rest?)
        end
        out.string.should include("left before you need to rest")
      end
    end

    context 'when the player doesn\'t have moves remaining' do
      it 'changes the status of resting to true' do
        game.moves = 0
        expect{game.send(:need_rest?)}.to change{game.resting}.from(false).to(true)
      end
    end
  end

  describe '#check_for_dais' do
    context 'when the user has 5 gems'
      it 'the player wins' do
        game.player_room.dais = true
        5.times do 
          game.player.gems << Jewel.new
        end
        expect{game.send(:check_for_dais)}.to change{game.winner}.from(false).to(true)
      end

      it 'returns a player\'s final score' do
        game.player_room.dais = true
        5.times do 
          game.player.gems << Jewel.new
        end
        out = capture_stdout do 
          game.send(:check_for_dais)
        end
        out.string.should include(game.player.gem_worth.to_s)        
      end

    context 'when the player doesn\'t have 5 gems' do
      it 'notifies the player' do
        game.player_room.dais = true
        out = capture_stdout do 
          game.send(:check_for_dais)
        end
        out.string.should include("You see a glowing dais")               
      end
    end
  end

  describe '#move_player' do
    it 'changes the player_room when given valid input' do
      current_room_options = game.player_room.doors.values.compact
      valid_moves = game.player_room.doors.map { |direction, next_room| direction if next_room }.compact
      game.send(:move_player, valid_moves[0])
      new_room_name = game.player_room.name
      expect(current_room_options.include?(new_room_name)).to be_true
    end

    it 'reduces the player\'s number of moves' do
      valid_moves = game.player_room.doors.map { |direction, next_room| direction if next_room }.compact
      expect{game.send(:move_player, valid_moves[0])}.to change{game.moves}.by(-1)
    end
  end

  describe '#move_grue' do
    it 'moves to an adjacent room' do
      current_room_options = game.grue_room.doors.values.compact
      valid_moves = game.grue_room.doors.map { |direction, next_room| direction if next_room }.compact
      game.send(:move_grue)
      new_room_name = game.grue_room.name
      expect(current_room_options.include?(new_room_name)).to be_true
    end

    it "will 'kill' the user if the user is resting" do
      current_room_options = game.grue_room.doors.values.compact
      game.player_room = game.send(:find_room, current_room_options[0])
      game.resting = true
      expect{game.send(:move_grue)}.to change{game.dead}.from(false).to(true)
    end
  end

  describe '#valid_input' do
    it 'rejects invalid input' do
      invalid_route = game.player_room.doors.find { |direction, room| room == nil }
      expect(game.send(:valid_input, invalid_route[0])).to be_false
    end

    it 'accepts valid input' do
      valid_route = game.player_room.doors.find { |direction, room| room != nil }
      expect(game.send(:valid_input, valid_route[0])).to be_true
    end
  end
end