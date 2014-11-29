require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class RatingDifference < Base
      def construct
        ratings = Ratings.new(turns, game).construct
        ratings[0] - ratings[1]
      end
    end
  end
end
