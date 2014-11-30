require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class FirstPlayerAverageScore < Base
      def construct
        current_score / number_of_turns.to_f
      end

      private

      def number_of_turns
        FeatureConstructors::FirstPlayerNumberOfTurns.new(turns, game).construct
      end

      def current_score
        FeatureConstructors::FirstPlayerCurrentScore.new(turns, game).construct
      end
    end
  end
end
