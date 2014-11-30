require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class SecondPlayerRack < Base
      def construct
        turns.reduce('') do |current_rack, turn|
          (!turn.rack.nil? && turn.index.odd?) ? turn.rack : current_rack
        end
      end
    end
  end
end
