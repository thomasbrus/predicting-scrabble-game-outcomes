require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class FinalScoreDifference < Base
      def construct
        first_player_final_score - second_player_final_score
      end

      private

      def first_player_final_score
        FirstPlayerFinalScore.new(turns, game).construct
      end

      def second_player_final_score
        SecondPlayerFinalScore.new(turns, game).construct
      end
    end
  end
end
