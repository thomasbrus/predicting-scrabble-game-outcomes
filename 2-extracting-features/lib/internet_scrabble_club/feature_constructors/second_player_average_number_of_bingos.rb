require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class SecondPlayerAverageNumberOfBingos < Base
      def construct
        number_of_turns.zero? ? 0 : number_of_bingos / number_of_turns.to_f
      end

      private

      def number_of_turns
        SecondPlayerNumberOfTurns.new(turns, game).construct
      end

      def number_of_bingos
        SecondPlayerNumberOfBingos.new(turns, game).construct
      end
    end
  end
end
