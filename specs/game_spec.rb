require "../lib/game.rb"
describe Game do

  describe "move" do
    it "sets a move on the board" do
      game = Game.new
      game.move(0)
      game.board.cells[0].should == 'X'
    end
  end

  describe "game_over" do
    it "should return true if a player wins" do
    game = Game.new
    game.move(0)
    game.move(1)
    game.move(2)
    game.board.is_game_over?.should be_true
    end
  end

  describe "end_turn" do
    it "should call computer_turn" do
      game = Game.new
      game.should_receive(:computer_turn)
      game.end_turn
    end
  end
end
