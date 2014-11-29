require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class NextPlayer < Base
      def construct
        turns.last.index.even? ? :first_player : :second_player
      end
    end
  end
end
