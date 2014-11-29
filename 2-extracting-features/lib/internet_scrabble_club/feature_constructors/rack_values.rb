require_relative '../../scrabble'
require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class RackValues < Base
      def construct
        racks = Racks.new(turns, game).construct.map(&:to_s)
        [ calculate_face_value(racks[0]), calculate_face_value(racks[1]) ]
      end

      private

      def calculate_face_value(rack)
        rack.each_char.reduce(0) do |total, character|
          total + Scrabble::LETTERS.fetch(character).fetch(:value)
        end
      end
    end
  end
end
