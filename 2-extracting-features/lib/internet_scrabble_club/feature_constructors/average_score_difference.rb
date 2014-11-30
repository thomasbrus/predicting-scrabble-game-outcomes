require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class AverageScoreDifference < Base
      def construct
        first_player_average_score - second_player_average_score
      end

      private

      def first_player_average_score
        FirstPlayerCurrentScore.new(turns, game).construct
      end

      def second_player_average_score
        SecondPlayerCurrentScore.new(turns, game).construct
      end
    end
  end
end
