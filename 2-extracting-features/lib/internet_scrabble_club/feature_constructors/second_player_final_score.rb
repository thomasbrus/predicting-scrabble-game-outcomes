require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class SecondPlayerFinalScore < Base
      def construct
        game.second_player_final_score
      end
    end
  end
end
