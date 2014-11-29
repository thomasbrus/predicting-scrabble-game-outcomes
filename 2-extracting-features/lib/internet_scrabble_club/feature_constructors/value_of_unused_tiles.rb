require_relative 'base'

module InternetScrabbleClub
  module FeatureConstructors
    class ValueOfUnusedTiles < Base
      def construct
        fail NotImplementedError
      end

      private

      def value
        # ...
      end
    end
  end
end
