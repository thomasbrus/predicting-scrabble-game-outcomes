module InternetScrabbleClub
  class FeatureVector
    attr_reader :turns, :game

    def initialize(turns:, game:)
      @turns, @game = turns, game
      @feature_constructors = []
    end

    private_class_method :new

    def self.construct(turns:, game:)
      new(turns: turns, game: game).tap do |feature_vector|
        yield(feature_vector)
      end
    end

    def use(feature_constructor_klass)
      @feature_constructors << feature_constructor_klass.public_method(:new)
    end

    def to_a
      to_h.values
    end

    def to_h
      @feature_constructors.reduce({}) do |hsh, feature_constructor_factory|
        feature_constructor = feature_constructor_factory.call(turns, game)
        hsh[feature_constructor.name] = feature_constructor.construct
        hsh
      end
    end
  end
end
