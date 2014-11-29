require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class NumberOfTurns < Base
      def construct
        [turns.map(&:index).count(&:even?), turns.map(&:index).count(&:odd?)]
      end
    end
  end
end
