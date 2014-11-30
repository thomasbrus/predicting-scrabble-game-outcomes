require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class Progress < Base
      def construct
        number_of_tiles_left.zero? ? 0 : number_of_turns / number_of_tiles_left.to_f
      end

      private

      def number_of_turns
        turns.count
      end

      def number_of_tiles_left
        NumberOfTilesLeft.new(turns, game).construct
      end
    end
  end
end
