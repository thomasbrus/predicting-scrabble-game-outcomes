require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class FinalTurn < Base
      def construct
        turns.last == game.plays.last
      end
    end
  end
end
