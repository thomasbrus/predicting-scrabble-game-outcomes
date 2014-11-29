require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class Progress < Base
      def construct
        number_of_turns = NumberOfTurns.new(turns, game).construct.reduce(:+)
        number_of_tiles_left = NumberOfTilesLeft.new(turns, game).construct
        number_of_turns / number_of_tiles_left.to_f
      end
    end
  end
end
