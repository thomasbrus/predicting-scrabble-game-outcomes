require_relative '../../scrabble'
require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class SecondPlayerRackValue < Base
      def construct
        rack = SecondPlayerRack.new(turns, game).construct

        rack.each_char.reduce(0) do |total, character|
          total + Scrabble::LETTERS.fetch(character).fetch(:value)
        end
      end
    end
  end
end
