require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class SecondPlayerNumberOfBingos < Base
      def construct
        turns.select { |turn| turn.index.odd? && turn.word.to_s.length == 7 }.count
      end
    end
  end
end
