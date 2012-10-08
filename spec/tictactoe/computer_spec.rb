require 'spec_helper'
  describe Computer do

    let(:board) {Board.new}
    let(:cpu) {Computer.new}

    #describe "make move" do
    #  it "should pick corner when starting with a blank board" do
    #    board.place_move(cpu.make_move(board), 'O')
    #    board.cells[0].should == 'O'
    #  end
    #end

    describe "make move" do
      it "should pick winning moves horizontally" do
        board.place_move(2, 'O')
        board.place_move(1, 'O')
        cpu.make_move(board).should == 0
      end
    end

    describe "make move" do
      it "should block winning move" do
        board.place_move(0, 'X')
        board.place_move(1, 'X')
        cpu.make_move(board).should == 2
      end
    end

    describe "make move" do
      it "should make the correct decision" do
        board.place_move(0, 'X')
        board.place_move(4, 'O')
        board.place_move(7, 'X')
        cpu.make_move(board).should == 3
      end
    end
  end
