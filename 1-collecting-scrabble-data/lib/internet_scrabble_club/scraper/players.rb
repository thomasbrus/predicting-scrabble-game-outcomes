require 'celluloid'
require 'events'

require_relative '../client'
require_relative '../db'
require_relative '../models/plays'
require_relative '../client/entity_extractors/examine/history'

module InternetScrabbleClub

  class Scraper

    class Players
      include Celluloid

      execute_block_on_receiver :on_player

      def initialize(nickname, password)
        @client = Client.new
        @client.authenticate(nickname, password)

        @event_emitter = Events::EventEmitter.new

        @client.on_response(/^(UN)SEEK$/) do |response|
          player = create_player_from_response(response)
          @event_emitter.emit(:player_created, player)
        end
      end

      def on_player(&callback)
        @event_emitter.on(:player_created) { |player| callback.call(player) }
      end

      private

      def create_player_from_response(response)
        InternetScrabbleClub::Models::Player.first_or_create(
          { nickname: response.fetch(:nickname) },
          { nickname: response.fetch(:nickname), rating: response.fetch(:rating, nil) }
        )
      end
    end

  end
end
