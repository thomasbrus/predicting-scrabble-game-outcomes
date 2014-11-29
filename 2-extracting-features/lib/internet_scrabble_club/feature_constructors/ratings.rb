require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class Ratings < Base
      def construct
        [game.first_player.rating, game.second_player.rating]
      end
    end
  end
end
