require_relative 'base'

module InternetScrabbleClub
  module Metrics
    class Turns < Base
      def initialize
        super('Turn metrics', [
          { name: 'Moves', value: number_of_moves },
          { name: 'Passes', value: number_of_passes },
          { name: 'Exchanges', value: number_of_swaps },
          { name: 'Total', value: total }
        ])
      end

      def number_of_moves
        InternetScrabbleClub::Models::Plays::Move.count
      end

      def number_of_passes
        InternetScrabbleClub::Models::Plays::Pass.count
      end

      def number_of_swaps
        InternetScrabbleClub::Models::Plays::Change.count
      end

      def total
        number_of_moves + number_of_passes + number_of_swaps
      end
    end
  end
end
