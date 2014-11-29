module InternetScrabbleClub
  module FeatureConstructors
    class Base
      attr_reader :turns, :game

      def initialize(turns, game)
        @turns, @game = turns, game
      end

      def construct
        fail NotImplementedError
      end

      def name
        namespaces = self.class.name.split(':')
        namespaces.last.gsub(/(.)([A-Z])/, '\1_\2').downcase
      end
    end
  end
end
