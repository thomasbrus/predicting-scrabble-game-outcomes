require 'pry'

module InternetScrabbleClub
  class FeatureVector
    attr_reader :current_turn

    def initialize(current_turn:)
      @current_turn = current_turn
      @feature_constructors = []
    end

    private_class_method :new

    def self.construct(current_turn:)
      new(current_turn: current_turn).tap do |feature_vector|
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

    private

    def turns
      game.plays.all(:index.lte => current_turn.index)
    end

    def game
      current_turn.game
    end
  end
end
