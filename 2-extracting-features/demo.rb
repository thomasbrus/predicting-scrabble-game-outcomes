require 'pp'

require_relative '../1-collecting-scrabble-data/lib/internet_scrabble_club/db'
require_relative './lib/internet_scrabble_club/feature_vector'
require_relative './lib/internet_scrabble_club/feature_constructors'

games_with_winners = InternetScrabbleClub::Models::Game.all.select(&:winner?)

games_with_winners.each_with_index do |game, index|
  puts "Processing game #{index} / #{games_with_winners.count}"

  game.plays.each do |play|
    vector = InternetScrabbleClub::FeatureVector.construct(current_turn: play) do |fv|
      fv.use InternetScrabbleClub::FeatureConstructors::CurrentScores
      fv.use InternetScrabbleClub::FeatureConstructors::CurrentScoreDifference
      fv.use InternetScrabbleClub::FeatureConstructors::AverageScores
      fv.use InternetScrabbleClub::FeatureConstructors::AverageScoreDifference
      fv.use InternetScrabbleClub::FeatureConstructors::Ratings
      fv.use InternetScrabbleClub::FeatureConstructors::RatingDifference
      fv.use InternetScrabbleClub::FeatureConstructors::NextPlayer
      fv.use InternetScrabbleClub::FeatureConstructors::NumberOfTilesLeft
      fv.use InternetScrabbleClub::FeatureConstructors::NumberOfTurns
      fv.use InternetScrabbleClub::FeatureConstructors::Progress
      fv.use InternetScrabbleClub::FeatureConstructors::RackBlanks
      fv.use InternetScrabbleClub::FeatureConstructors::RackValues
      fv.use InternetScrabbleClub::FeatureConstructors::FinalScores
      fv.use InternetScrabbleClub::FeatureConstructors::FinalScoreDifference
      fv.use InternetScrabbleClub::FeatureConstructors::Outcome
    end

    pp vector.to_h
  end
end
