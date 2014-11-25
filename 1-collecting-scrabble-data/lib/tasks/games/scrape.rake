require 'internet_scrabble_club/scraper/games'

namespace :games do
  desc <<-DESCRIPTION
    Collects scrabble games from the ISC server and stores them in the database
  DESCRIPTION

  task :scrape do
    nickname, password = ENV.fetch('NICKNAME'), ENV.fetch('PASSWORD')

    scraper = InternetScrabbleClub::Scraper::Games.new(nickname, password)

    scraper.on_game do
      number_of_games = InternetScrabbleClub::Models::Game.count
      Celluloid::Logger.info("Parsed and stored game! (total: #{number_of_games})")
    end

    sleep
  end
end

