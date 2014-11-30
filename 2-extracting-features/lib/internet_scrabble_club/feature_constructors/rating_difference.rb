require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class RatingDifference < Base
      def construct
        first_player_rating - second_player_rating
      end

      private

      def first_player_rating
        FirstPlayerRating.new(turns, game).construct
      end

      def second_player_rating
        SecondPlayerRating.new(turns, game).construct
      end
    end
  end
end
