require 'rspec'
require_relative '../models/game'
require_relative '../config/game_map'

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
      expect{game.check_for_gems}.to change{game.player.gems.count}.from(0).to(1)
    end

    it 'removes the gem from the contents of the room' do
      game.player_room.gems << Jewel.new
      expect{game.check_for_gems}.to change{game.player_room.gems.count}.from(1).to(0)
    end
  end

  describe '#check_for_grue' do
    context 'when the user enters the room' do
      it 'changes the position of the grue' do
        game.player_room = game.grue_room
        game.check_for_grue
        expect(game.grue_room != game.player_room)
      end

      it 'takes a gem from the grue' do


      end
    end
  end

  describe '#need_rest' do
    it 'does something' do
    end
  end

  describe '#check_for_dias' do
    it 'does something' do
    end
  end

  describe '#move_player' do
    it 'does something' do
    end
  end

  describe '#move_grue' do
    it 'does something' do
    end
  end

  describe '#check_input' do
    it 'does something' do
    end
  end

  describe '#get_furthest_room' do
    it 'does something' do
    end
  end

  describe '#get_shortest_path' do
    it 'does something' do
    end
  end
end