require "../lib/computer.rb"
require "../lib/board.rb"

  describe Computer do

    describe "make move" do
      it "should pick corner when starting with a blank board" do
        board = Board.new
        cpu = Computer.new
        board.place_move(cpu.make_move(board), 'O')
        board.cells[0].should == 'O'
      end
    end

    describe "make move" do
      it "should pick winning moves horizontally" do
        board = Board.new
        cpu = Computer.new
        board.place_move(2, 'O')
        board.place_move(1, 'O')
        cpu.make_move(board).should == 0
      end
    end

  end
