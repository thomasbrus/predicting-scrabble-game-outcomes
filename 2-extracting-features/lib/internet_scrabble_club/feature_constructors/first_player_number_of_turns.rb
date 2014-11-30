require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class FirstPlayerNumberOfTurns < Base
      def construct
        turns.map(&:index).count(&:even?)
      end
    end
  end
end
