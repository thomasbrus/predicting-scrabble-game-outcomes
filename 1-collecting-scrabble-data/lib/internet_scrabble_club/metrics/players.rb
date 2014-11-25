require_relative 'base'

module InternetScrabbleClub
  module Metrics
    class Players < Base
      def initialize
        super('Player metrics', [ { name: 'Total', value: total } ])
      end

      def total
        InternetScrabbleClub::Models::Player.count
      end
    end
  end
end
