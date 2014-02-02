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
    expect(game.current_room.name == game.player.position).to be_true
  end

  describe '#play' do
    it 'does something' do
    end
  end

  describe '#check_for_gems' do
    it 'does something' do
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

  describe '#check_for_grue' do
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