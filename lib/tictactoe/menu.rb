class Menu

  def initialize
    @io = InputOutput.new
    @translate = Translator.new
  end

  def game_setup
    player_choose_language
    player_choose_game
  end

  def player_choose_language
    @io.outputs t.menu.language.choose
    language_options
    get_user_language
  end

  def player_choose_game
    @io.outputs t.menu.game.choose
    game_options
    get_user_game
  end

  def get_user_language
    @io.prints t.game.input.symbol
    @translate.change_language(@io.input)
  end

  def get_user_game
    @io.prints t.game.input.symbol
    game_type(@io.input)
  end

  def game_type(choice)
    until choice == '1' || choice == '2' || choice == '3'
      get_user_game
    end
    Game.new(choice)
  end

  def game_options
    print_with_options([t.menu.game.one,
                        t.menu.game.two,
                        t.menu.game.three])
  end

  def language_options
    print_with_options([t.menu.language.one,
                        t.menu.language.two])
  end

  def print_with_options(options)
    options.each {|option| @io.outputs option}
  end
end
