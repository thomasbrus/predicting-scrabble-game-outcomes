require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class Racks < Base
      def construct
        [first_player_rack, second_player_rack]
      end

      private

      def first_player_rack
        find_current_rack(turns) { |turn| turn.index.even? }
      end

      def second_player_rack
        find_current_rack(turns) { |turn| turn.index.odd? }
      end

      def find_current_rack(turns, &filter)
        turns.select(&filter).reduce('') do |current_rack, turn|
          turn.rack.nil? ? current_rack : turn.rack
        end
      end
    end
  end
end
