require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class CurrentScores < Base
      def construct
        [ calculate_score(turns.select { |t| t.index.even? }),
          calculate_score(turns.select { |t| t.index.odd? })
        ]
      end

      private

      def calculate_score(turns)
        turns.reduce(0) do |score, turn|
          score + (turn.respond_to?(:score) && !turn.score.nil? ? turn.score : 0)
        end
      end
    end
  end
end
