require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class SecondPlayerRating < Base
      def construct
        game.second_player.rating
      end
    end
  end
end
