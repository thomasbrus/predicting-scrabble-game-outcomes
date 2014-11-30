require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class SecondPlayerNumberOfTurns < Base
      def construct
        turns.map(&:index).count(&:odd?)
      end
    end
  end
end
