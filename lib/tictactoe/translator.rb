require 'r18n-core'

R18n.default_places = '../../i18n/'
R18n.set('en')

include R18n::Helpers

class Translator

  def change_language(choice)
    if choice.to_i == 1
      R18n.set('en')
    elsif choice.to_i == 2
      R18n.set('sp')
    end
  end
end
