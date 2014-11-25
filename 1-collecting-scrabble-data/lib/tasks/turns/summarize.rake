require 'internet_scrabble_club/metrics/turns'

namespace :turns do
  desc <<-DESCRIPTION
    Summarizes the collected Scrabble moves by showing a number of metrics
  DESCRIPTION

  task :summarize do
    puts InternetScrabbleClub::Metrics::Turns.new
  end
end

