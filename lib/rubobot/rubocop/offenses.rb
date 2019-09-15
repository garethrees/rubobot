# frozen_string_literal: true

module RuboBot
  module RuboCop
    # Raised when we've iterated through all offenses
    class NoOffensesError < StandardError; end

    # Offenses found by a RuboCop run
    class Offenses
      def initialize(offense_data)
        @offense_data = offense_data
      end

      def next
        Offense.new(next_data)
      end

      def size
        offense_data.size
      end

      def ==(other)
        offense_data == other.offense_data
      end

      protected

      attr_reader :offense_data

      private

      def next_data
        [sorted_offenses.shift].to_h
      rescue TypeError
        raise NoOffensesError
      end

      def sorted_offenses
        @sorted_offenses ||= offense_data.sort_by { |_, value| value }.to_h
      end
    end
  end
end
