require_relative 'base'

module InternetScrabbleClub
  module Metrics
    class Games < Base
      def initialize
        super('Game metrics', [ { name: 'Total', value: total } ])
      end

      def total
        InternetScrabbleClub::Models::Game.count
      end
    end
  end
end
