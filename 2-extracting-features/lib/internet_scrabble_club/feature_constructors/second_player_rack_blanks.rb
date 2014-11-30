require_relative '../../scrabble'
require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class SecondPlayerRackBlanks < Base
      def construct
        SecondPlayerRack.new(turns, game).construct.count('?')
      end
    end
  end
end
