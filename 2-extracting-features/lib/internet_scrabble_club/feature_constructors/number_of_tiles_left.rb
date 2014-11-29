require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class NumberOfTilesLeft < Base
      INITIAL_NUMBER_OF_TILES = 100

      def construct
        turns.reduce(INITIAL_NUMBER_OF_TILES) do |tiles_left, turn|
          tiles_left - turn.word.to_s.length
        end
      end
    end
  end
end
