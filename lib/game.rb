require "../lib/board.rb"
require "../lib/io.rb"

class Game
  attr_accessor :board, :computer

  def initialize
    @io = InputOutput.new
    @board = Board.new
    @player = 'X'
    @computer = Computer.new
  end

  def start_game
    @io.output "\tTic Tac Toe\n\n"
    @computer = Computer.new
    until @board.is_game_over?
      start_turn
      cell = get_move
      move(cell)
      end_turn
    end
  end

  def start_turn
    draw_board
    @io.output "It's #{@player}s Turn"
  end

  def get_move
    @io.output "-> "
    cell = get_input
      if !@board.move_available?(cell)
        puts "Invalid Move"
        get_move
      end
      move(cell)
      draw_board
    return cell
  end

  def get_input
    @io.input.to_i
  end

  def draw_board
    system('clear')
    @io.output "\tMoves Available: #{ @board.available_moves} \n\n"
    @io.output @board.print_board
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
    if @board.winner
      game_over
    elsif @board.tie?
      @io.output "Tie Game!"
      play_again
    end
  end

  def moves_left
    @board.available_moves
  end

  def game_over
    @io.output "Player #{@board.winner} Wins!"
    @io.output "Game Over!"
    play_again
  end

  def play_again
    @io.output "Do you want to play again?(Yes or No)"
    if @io.input.downcase =~ /yes/
      system('clear')
      g = Game.new
      g.start_game
    else
      @io.output "Goodbye!"
      exit(0)
    end
  end

  def computer_turn
   @board.place_move(@computer.make_move(@board), 'O')
   draw_board
   check_game_state
  end
end
