require 'rspec'
require_relative '../models/player'

describe Player do
  let(:player) { Player.new }

  it 'is initialized with a gem bag' do
    expect(player.gems.empty?).to be_true
  end

end