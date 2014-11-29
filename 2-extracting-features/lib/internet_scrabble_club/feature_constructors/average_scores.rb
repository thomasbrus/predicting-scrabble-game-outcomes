require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class AverageScores < Base
      def construct
        [ current_scores[0] / number_of_turns[0].to_f,
          current_scores[1] / number_of_turns[1].to_f
        ]
      end

      private

      def number_of_turns
        FeatureConstructors::NumberOfTurns.new(turns, game).construct
      end

      def current_scores
        FeatureConstructors::CurrentScores.new(turns, game).construct
      end
    end
  end
end
