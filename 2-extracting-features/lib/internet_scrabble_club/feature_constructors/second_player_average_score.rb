require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class SecondPlayerAverageScore < Base
      def construct
        number_of_turns.zero? ? 0 : current_score / number_of_turns.to_f
      end

      private

      def number_of_turns
        FeatureConstructors::SecondPlayerNumberOfTurns.new(turns, game).construct
      end

      def current_score
        FeatureConstructors::SecondPlayerCurrentScore.new(turns, game).construct
      end
    end
  end
end
