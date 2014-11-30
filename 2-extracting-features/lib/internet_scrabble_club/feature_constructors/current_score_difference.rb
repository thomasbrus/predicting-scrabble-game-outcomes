require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class CurrentScoreDifference < Base
      def construct
        first_player_score - second_player_score
      end

      private

      def first_player_score
        FirstPlayerCurrentScore.new(turns, game).construct
      end

      def second_player_score
        SecondPlayerCurrentScore.new(turns, game).construct
      end
    end
  end
end
