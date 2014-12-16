require 'ostruct'
require 'pry'
require 'csv'
require 'colored'

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

class ResultWrapper
  def initialize(csv_row)
    @csv_row = csv_row
  end

  def actual
    to_boolean(@csv_row.fetch(:actual_outcome))
  end

  def predicted
    to_boolean(@csv_row.fetch(:predicted_outcome))
  end

  def probability_distribution
    @csv_row.values_at(:first_player_probability, :second_player_probability).map(&method(:Float))
  end

  def number_of_turns
    @csv_row.values_at(:first_player_number_of_turns, :second_player_number_of_turns).reduce(:+)
  end

  def method_missing(method, *args, &block)
    @csv_row.fetch(method) { super }
  end

  def respond_to_missing?(method, *)
    @csv_row.has_key?(method) || super
  end

  private

  def to_boolean(thing)
    { 'true' => true, 'false' => false }.fetch(thing)
  end

end

filename = ARGV.fetch(0)
results = CSV.table(filename).map(&ResultWrapper.method(:new))

def suprising_results(results)
  results.select do |result|
    (result.current_score_difference > 0) != result.actual &&
      result.current_score_difference != 0
  end
end

def more_suprising_results(results)
  results.select do |result|
    (result.rating_difference > 0) != result.actual &&
      result.rating_difference != 0
  end
end

def not_so_suprising_results(results)
  sorted_results = results.sort_by { |result| result.current_score_difference.abs }
  sorted_results.take((results.count * 0.10).ceil)
end

def group_by_score_difference(results)
  sorted_results = results.sort_by(&:absolute_score_difference)
  sorted_results.each_slice((results.count * 0.10).ceil)
end

def group_by_number_of_turns(results)
  sorted_results = results.sort_by(&:number_of_turns)
  sorted_results.each_slice((results.count * 0.10).ceil)
end

puts "\n# Grouped by number of turns (0-10%, 10%-20%, ...)"
puts group_by_number_of_turns(results).map(&Summary.method(:new))

puts "\n# Grouped by score difference (0-10%, 10%-20%, ...)"
puts group_by_score_difference(results).map(&Summary.method(:new))

# puts "# Only where sign(current_score_difference) != sign(final_score_difference)".bold.green
# puts Summary.new(suprising_results(results))

# puts "\n# Only where sign(rating_difference) != sign(final_score_difference)".bold.green
# puts Summary.new(more_suprising_results(results))

# puts "\n# Only where abs(score_difference) is small".bold.green
# puts Summary.new(not_so_suprising_results(results))

puts "\n# All turns".bold.green
puts Summary.new(results)

