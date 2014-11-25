require 'internet_scrabble_club/metrics/games'

namespace :games do
  desc <<-DESCRIPTION
    Summarizes the collected Scrabble games by showing a number of metrics
  DESCRIPTION

  task :summarize do
    puts InternetScrabbleClub::Metrics::Games.new
  end
end

