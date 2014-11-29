require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class FinalScoreDifference < Base
      def construct
        final_scores = FinalScores.new(turns, game).construct
        final_scores[0] - final_scores[1]
      end
    end
  end
end
