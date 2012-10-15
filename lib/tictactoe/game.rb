class Game
  attr_accessor :board, :computer

  def initialize(choice)
    @io = InputOutput.new
    @board = Board.new
    @player = 'X'
    @other_player = 'O'    
    if choice == '1'
      start_game
    elsif choice == '2'
      @computer = Computer.new('O')
      @computer_sym = 'O'
      start_game
    elsif choice == '3'
      computer_vs_computer
    end
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
    if @computer_sym == @player
      computer_turn
    else 
    @io.prints t.game.input.symbol
    test_user_input(@io.input)
    end
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
    switch_players
  end

  def switch_players
    @player, @other_player = @other_player, @player  
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
    if @io.input.downcase =~ (/yes|si/)
      system('clear')
      Menu.new.game_setup
    else
      @io.outputs t.game.over.exit
      exit(0)
    end
  end

  def computer_turn
    @io.outputs t.game.computer.wait
    move = @computer.make_move(@board)
    @board.place_move(move, @computer_sym)
    return move
  end

  def computer_vs_computer
    computer1 = Computer.new('X')
    computer2 = Computer.new('O')
    until @board.is_game_over?
      draw_board
      @io.outputs t.game.computer.wait
      @board.place_move(computer1.make_move(@board), 'X')
      @board.place_move(computer2.make_move(@board), 'O')
      draw_board
      check_game_state
    end
  end
end
