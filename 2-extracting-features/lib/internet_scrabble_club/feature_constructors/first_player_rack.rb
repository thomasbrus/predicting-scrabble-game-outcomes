require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class FirstPlayerRack < Base
      def construct
        turns.reduce('') do |current_rack, turn|
          (!turn.rack.nil? && turn.index.even?) ? turn.rack : current_rack
        end
      end
    end
  end
end
