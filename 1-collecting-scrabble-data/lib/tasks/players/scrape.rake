require 'celluloid/logger'
require 'internet_scrabble_club/scraper/players'

namespace :players do
  desc <<-DESCRIPTION
    Collects nicknames from the ISC server and stores them in the database
  DESCRIPTION

  task :scrape do
    nickname, password = ENV.fetch('NICKNAME'), ENV.fetch('PASSWORD')

    scraper = InternetScrabbleClub::Scraper::Players.new(nickname, password)
    scraper.on_player { |player| Celluloid::Logger.info("Found & stored player: #{player}") }
    sleep
  end
end

