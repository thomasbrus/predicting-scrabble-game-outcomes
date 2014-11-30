require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class FirstPlayerNumberOfBingos < Base
      def construct
        turns.select { |turn| turn.index.even? && turn.word.to_s.length == 7 }.count
      end
    end
  end
end
