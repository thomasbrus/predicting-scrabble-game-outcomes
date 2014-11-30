require_relative '../../scrabble'
require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class FirstPlayerRackBlanks < Base
      def construct
        FirstPlayerRack.new(turns, game).construct.count('?')
      end
    end
  end
end
