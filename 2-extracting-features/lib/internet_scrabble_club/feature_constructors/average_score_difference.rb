require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class AverageScoreDifference < Base
      def construct
        average_scores = AverageScores.new(turns, game).construct
        average_scores[0] - average_scores[1]
      end
    end
  end
end
