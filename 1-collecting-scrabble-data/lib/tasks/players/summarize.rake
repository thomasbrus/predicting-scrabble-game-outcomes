require 'internet_scrabble_club/metrics/players'

namespace :players do
  desc <<-DESCRIPTION
    Summarizes the collected Scrabble players by showing a number of metrics
  DESCRIPTION

  task :summarize do
    puts InternetScrabbleClub::Metrics::Players.new
  end
end

