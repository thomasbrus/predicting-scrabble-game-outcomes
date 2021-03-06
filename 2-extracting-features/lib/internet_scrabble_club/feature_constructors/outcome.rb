require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class Outcome < Base
      def construct
        game.first_player_final_score > game.second_player_final_score
      end
    end
  end
end
