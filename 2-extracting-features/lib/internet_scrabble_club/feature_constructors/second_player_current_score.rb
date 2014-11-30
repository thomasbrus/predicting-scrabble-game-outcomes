require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class SecondPlayerCurrentScore < Base
      def construct
        second_player_turns = turns.select { |t| t.index.odd? }
        second_player_turns.reduce(0) { |score, turn| score + turn.score.to_i }
      end
    end
  end
end
