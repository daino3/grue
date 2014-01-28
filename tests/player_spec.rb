require 'rspec'
require_relative '../models/player'

describe Player do
  let(:player) { Player.new("some room") }

  it 'is initialized with a position (key for map) and a gem bag' do
    expect(player.position).to eq("some room")
    expect(player.gem_bag.empty?).to be_true
  end

end