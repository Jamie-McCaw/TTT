require 'spec_helper'
describe Game do

  let(:game) { Game.new }

  describe "move" do
    it "sets a move on the board" do
      game.move(0)
      game.board.cells[0].should == 'X'
    end
  end

  describe "game_over" do
    it "should return true if a player wins" do
    game.move(0)
    game.move(1)
    game.move(2)
    game.board.is_game_over?.should be_true
    end
  end

  describe "end_turn" do
    it "should call computer_turn" do
      my_io = InputOutput.new
      my_io.stub(:puts_to_screen)
      game.stub(:io).and_return(nil)
      game.should_receive(:computer_turn)
      game.end_turn
    end
  end
end
