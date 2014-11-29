require_relative '../../scrabble'
require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class RackBlanks < Base
      def construct
        racks = Racks.new(turns, game).construct.map(&:to_s)
        [ count_blanks(racks[0]), count_blanks(racks[1]) ]
      end

      private

      def count_blanks(rack)
        rack.count('?')
      end
    end
  end
end
