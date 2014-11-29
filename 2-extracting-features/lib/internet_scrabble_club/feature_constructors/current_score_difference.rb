require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class CurrentScoreDifference < Base
      def construct
        scores = CurrentScores.new(turns, game).construct
        scores[0] - scores[1]
      end
    end
  end
end
