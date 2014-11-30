require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class FirstPlayerFinalScore < Base
      def construct
        game.first_player_final_score
      end
    end
  end
end
