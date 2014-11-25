require 'celluloid'
require 'events'
require 'internet_scrabble_club/client'

require_relative '../db'
require_relative '../models/plays'
require_relative '../client/entity_extractors/examine/history'

module InternetScrabbleClub

  class Scraper

    class Games
      include Celluloid

      execute_block_on_receiver :on_game

      class EmptyRequestQueue < StandardError
        def initialize(message = nil)
          super(message || 'Reached end of the requests queue.')
        end
      end

      def initialize(nickname, password)
        @client = Client.new
        @event_emitter = Events::EventEmitter.new

        @game_requests_queue = construct_game_requests_queue
        @game_requests_queue.push(->(*) { fail EmptyRequestQueue })

        @client.authenticate(nickname, password) do
          @game_requests_queue.shift.call(@client) do |examine_history_response|
            create_models_from_response(examine_history_response)
            @event_emitter.emit(:game_created)
          end
        end
      end

      def on_game(&callback)
        @event_emitter.on(:game_created, &callback)
      end

      def create_models_from_response(response)
        create_dictionary_from_response(response)
        create_first_player_from_response(response)
        create_second_player_from_response(response)
        create_game_from_response(response)
        # TODO: Solve this in a more elegant way!
        create_plays_from_response(response) unless InternetScrabbleClub::Models::Game.last.plays.count > 0

        @game_requests_queue.shift.call(@client) do |examine_history_response|
          create_models_from_response(examine_history_response)
          @event_emitter.emit(:game_created)
        end
      end

      def create_dictionary_from_response(response)
        extract_dictionary_entity_from_response(response).save
      end

      def create_first_player_from_response(response)
        extract_first_player_entity_from_response(response).save
      end

      def create_second_player_from_response(response)
        extract_second_player_entity_from_response(response).save
      end

      def create_game_from_response(response)
        extract_game_entity_from_response(response).save
      end

      def create_plays_from_response(response)
        extract_play_models_from_response(response).each(&:save)
      end

      def extract_dictionary_entity_from_response(response)
        extract_models_from_response(response).dictionary
      end

      def extract_first_player_entity_from_response(response)
        extract_models_from_response(response).first_player
      end

      def extract_second_player_entity_from_response(response)
        extract_models_from_response(response).second_player
      end

      def extract_play_models_from_response(response)
        extract_models_from_response(response).plays
      end

      def extract_game_entity_from_response(response)
        extract_models_from_response(response).game
      end

      def extract_models_from_response(response)
        (@extracted_models ||= {})[response] ||= Client::EntityExtractors::Examine::History.new(response)
      end

      private

      def construct_game_requests_queue
        players_without_games.reduce([]) do |queue, player|
          queue += (10.times.map do |game_number|
            Proc.new do |client, &callback|
              commands = %w(EXAMINE HISTORY)
              arguments = [player.nickname, game_number]
              client.send_request(commands[0], commands[1], *arguments, &callback)
            end
          end)
        end
      end

      def players_without_games
        InternetScrabbleClub::Models::Player.all.select do |player|
          player.initiated_games.none? && player.accepted_games.none?
        end
      end
    end

  end
end
