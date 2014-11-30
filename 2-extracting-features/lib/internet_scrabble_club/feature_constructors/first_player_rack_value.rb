require_relative '../../scrabble'
require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class FirstPlayerRackValue < Base
      def construct
        rack = FirstPlayerRack.new(turns, game).construct

        rack.each_char.reduce(0) do |total, character|
          total + Scrabble::LETTERS.fetch(character).fetch(:value)
        end
      end
    end
  end
end
