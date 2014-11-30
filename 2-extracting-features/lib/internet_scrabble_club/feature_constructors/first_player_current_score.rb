require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class FirstPlayerCurrentScore < Base
      def construct
        first_player_turns = turns.select { |t| t.index.even? }
        first_player_turns.reduce(0) { |score, turn| score + turn.score.to_i }
      end
    end
  end
end
