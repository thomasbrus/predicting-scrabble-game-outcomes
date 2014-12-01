require 'ostruct'
require 'csv'

filename = ARGV.fetch(0)

results = CSV.table(filename).map { |result|
  actual = { 'true' => true, 'false' => false }.fetch(result.fetch(:actual_outcome))
  predicted = { 'true' => true, 'false' => false }.fetch(result.fetch(:predicted_outcome))

  p1 = Float(result.fetch(:first_player_probability))
  p2 = Float(result.fetch(:first_player_probability))

  OpenStruct.new(result.to_h.merge({
    actual: actual,
    predicted: predicted,
    probability_distribution: [p1, p2]
  }))
}

class Summary
  def initialize(results)
    @results = results
  end

  def total
    @results.count
  end

  def accuracy
    (true_positives.count + false_negatives.count) / @results.count.to_f
  end

  def true_positives
    @results.select { |result| result.predicted == true && result.actual == true }
  end

  def false_positives
    @results.select { |result| result.predicted == true && result.actual == false }
  end

  def true_negatives
    @results.select { |result| result.predicted == false && result.actual == true }
  end

  def false_negatives
    @results.select { |result| result.predicted == false && result.actual == false }
  end

  def precision
    true_positives.count / (true_positives.count + false_positives.count).to_f
  end

  def recall
    true_positives.count / (true_positives.count + false_negatives.count).to_f
  end

  def f_measure
    2 * (precision * recall) / (precision + recall)
  end

  def estimated_probabilities
    @results.map { |result| result.probability_distribution.first }
  end

  def actual_outcomes
    @results.map { |result| result.actual ? 1 : 0 }
  end

  def brier_score
    estimated_probabilities.zip(actual_outcomes).reduce(0) do |acc, (probability, outcome)|
      acc + (probability - outcome) ** 2
    end / @results.count.to_f
  end

  def to_s
    "#<Summary count=#{total} accuracy=#{accuracy} brier_score=#{brier_score}>"
  end
end

puts Summary.new(results)
