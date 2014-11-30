require 'pp'

require_relative '../1-collecting-scrabble-data/lib/internet_scrabble_club/db'
require_relative './lib/internet_scrabble_club/feature_vector'
require_relative './lib/internet_scrabble_club/feature_constructors'

games_with_winners = InternetScrabbleClub::Models::Game.all.select(&:winner?)

games_with_winners.each_with_index do |game, index|
  puts "Processing game #{index} / #{games_with_winners.count}"
  plays = []

  game.plays.each do |play|
    plays << play

    vector = InternetScrabbleClub::FeatureVector.construct(turns: plays, game: game) do |fv|
      fv.use InternetScrabbleClub::FeatureConstructors::FirstPlayerCurrentScore
      fv.use InternetScrabbleClub::FeatureConstructors::SecondPlayerCurrentScore
      fv.use InternetScrabbleClub::FeatureConstructors::CurrentScoreDifference
      fv.use InternetScrabbleClub::FeatureConstructors::FirstPlayerAverageScore
      fv.use InternetScrabbleClub::FeatureConstructors::SecondPlayerAverageScore
      fv.use InternetScrabbleClub::FeatureConstructors::AverageScoreDifference
      fv.use InternetScrabbleClub::FeatureConstructors::FirstPlayerRating
      fv.use InternetScrabbleClub::FeatureConstructors::SecondPlayerRating
      fv.use InternetScrabbleClub::FeatureConstructors::RatingDifference
      fv.use InternetScrabbleClub::FeatureConstructors::FirstPlayerNumberOfBingos
      fv.use InternetScrabbleClub::FeatureConstructors::SecondPlayerNumberOfBingos
      fv.use InternetScrabbleClub::FeatureConstructors::FirstPlayerAverageNumberOfBingos
      fv.use InternetScrabbleClub::FeatureConstructors::SecondPlayerAverageNumberOfBingos
      fv.use InternetScrabbleClub::FeatureConstructors::NextPlayer
      fv.use InternetScrabbleClub::FeatureConstructors::NumberOfTilesLeft
      fv.use InternetScrabbleClub::FeatureConstructors::FirstPlayerNumberOfTurns
      fv.use InternetScrabbleClub::FeatureConstructors::SecondPlayerNumberOfTurns
      fv.use InternetScrabbleClub::FeatureConstructors::Progress
      fv.use InternetScrabbleClub::FeatureConstructors::FirstPlayerRackBlanks
      fv.use InternetScrabbleClub::FeatureConstructors::SecondPlayerRackBlanks
      fv.use InternetScrabbleClub::FeatureConstructors::FirstPlayerRackValue
      fv.use InternetScrabbleClub::FeatureConstructors::SecondPlayerRackValue
      fv.use InternetScrabbleClub::FeatureConstructors::FinalTurn
      fv.use InternetScrabbleClub::FeatureConstructors::FirstPlayerFinalScore
      fv.use InternetScrabbleClub::FeatureConstructors::SecondPlayerFinalScore
      fv.use InternetScrabbleClub::FeatureConstructors::FinalScoreDifference
      fv.use InternetScrabbleClub::FeatureConstructors::Outcome
    end

    pp vector.to_h
  end
end
