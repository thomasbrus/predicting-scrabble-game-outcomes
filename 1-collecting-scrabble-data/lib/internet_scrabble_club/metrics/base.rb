module InternetScrabbleClub
  module Metrics
    class Base
      attr_reader :title, :metrics

      NEWLINE_CHARACTER = "\n"

      def initialize(title, metrics)
        @title, @metrics = title, metrics
      end

      def to_s; format_metrics; end

      private

      def format_metrics
        String.new.tap do |str|
          str << title << NEWLINE_CHARACTER
          str << ('=' * 40) << NEWLINE_CHARACTER
          str << format_metrics_body
          str << ('-' * 40) << NEWLINE_CHARACTER
          str << NEWLINE_CHARACTER
        end
      end

      def format_metrics_body
        metrics.map { |metric|
          metric[:name].to_s.ljust(40 / 2) << metric[:value].to_s.rjust(40 / 2)
        }.join(NEWLINE_CHARACTER) << NEWLINE_CHARACTER
      end
    end
  end
end
