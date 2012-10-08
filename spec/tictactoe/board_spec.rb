require 'spec_helper'

describe Board do

  describe "board print" do
    it "shows what the board should look like" do
      board = Board.new
      board_look  = <<-BOARD
         0 | 1 | 2
        ---+---+---
         3 | 4 | 5
        ---+---+---
         6 | 7 | 8 \n
                     BOARD

      board.print_board.should == board_look
    end
  end

  describe "available moves" do
    it "has available moves" do
      board = Board.new
      moves = board.available_moves
      moves.should == 9
    end
  end

  describe "move available?" do
    it "is a specific move available" do
      board = Board.new
      board.move_available?(0).should be_true
    end
  end

  describe "place move" do
    it "places the current move on the board" do
      board = Board.new
      board.place_move(0, 'X')
      board.cells[0].should == 'X'

    end
  end

  context "is game over?" do
    before(:each) do
      @board = Board.new
    end

    describe "is_game_over?" do
      it "lets us know the game is not over" do
        @board.is_game_over?.should be_false
      end

      it "lets us know the game is over" do
        @board.cells = ['X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X']
        @board.is_game_over?.should be_true
      end
    end
  end

  describe "is it a tie?" do
    it "tells us there is a tie" do
      board = Board.new
      board.should_receive(:available_moves).and_return(0)
      board.tie?.should be_true
    end
  end

  context "who the winner is" do
    before(:each) do
      @board = Board.new
    end
    describe "winner" do
      it "tells us X is the winner" do
        @board.should_receive(:player_wins?).with('X').and_return(true)
        @board.winner.should == 'X'
      end
      it "tells us O is the winner" do
        @board.should_receive(:player_wins?).with('X').and_return(false)
        @board.should_receive(:player_wins?).with('O').and_return(true)
        @board.winner.should == 'O'
      end
      it "tells us nil is the winner" do
        @board.stub(:player_wins?).and_return(false)
        @board.winner.should be nil
      end
    end
  end
  context "winning combos" do
    before(:each) do
      @board = Board.new
    end
    describe "winning_moves" do
        it "tells us there is a winner for horizontal" do
        @board.cells = ['X', 'X', 'X', ' ', ' ', ' ', ' ', ' ', ' ']
        @board.player_wins?('X').should be_true
      end

      it "tells us there is a winner for vertical" do
        @board.cells = [' ', ' ', 'O', ' ', ' ', 'O', ' ', ' ', 'O']
        @board.player_wins?('O').should be_true
      end

      it "tells us there is a winner for diagonal" do
        @board.cells = ['Q', ' ', ' ', ' ', 'Q', ' ', ' ', ' ', 'Q']
        @board.player_wins?('Q').should be_true
      end

      it "tells us there is a block for horizontal" do
        @board.cells = ['X', 'O', 'X', ' ', ' ', ' ', ' ', ' ', ' ']
        @board.player_wins?('X').should be_false
      end
    end
  end
end
