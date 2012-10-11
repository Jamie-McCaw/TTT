class Game
  attr_accessor :board, :computer

  def initialize
    @io = InputOutput.new
    @board = Board.new
    @player = 'X'
    @computer = Computer.new

  end

  def start_game
    until @board.is_game_over?
      start_turn
      cell = get_move
      move(cell)
      end_turn
    end
  end

  def start_turn
    draw_board
    @io.outputs t.game.player.turn(@player)
  end

  def get_move
    get_cell_from_user
  end

  def get_cell_from_user
    @io.prints t.game.input.symbol
    test_user_input(@io.input)
  end

  def test_user_input(users_input)
    if users_input =~ /[0-9]/ && @board.move_available?(users_input.to_i)
      return users_input.to_i.abs
    else
      invalid_move
    end
  end

  def invalid_move
    @io.outputs t.game.moves.invalid
    get_cell_from_user
  end

  def draw_board
    system('clear')
    @io.outputs_header t.welcome.message
    @io.outputs_header t.game.moves.message(@board.available_moves)
    @io.outputs @board.print_board
  end

  def move(cell)
    @board.place_move(cell, @player)
  end

  def end_turn
    draw_board
    check_game_state
    computer_turn
  end

  def check_game_state
    if game_over
      print_winning_message
      play_again
    end
  end

  def print_winning_message
    if @board.winner
      @io.outputs t.game.over.winner(@board.winner)
    elsif @board.tie?
      @io.outputs t.game.over.tie
    end
  end

  def game_over
    return @board.winner || @board.tie?
  end

  def moves_left
    @board.available_moves
  end

  def play_again
    @io.prints t.game.over.play_again
    if @io.input.downcase =~ /yes/
      system('clear')
      Game.new.start_game
    else
      @io.outputs t.game.over.exit
      exit(0)
    end
  end

  def computer_turn
    @io.outputs t.game.computer.wait
    @board.place_move(@computer.make_move(@board), 'O')
    draw_board
    check_game_state
  end
end
