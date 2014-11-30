require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class FirstPlayerRating < Base
      def construct
        game.first_player.rating
      end
    end
  end
end
