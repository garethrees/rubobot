# frozen_string_literal: true

module RuboBot
  module RuboCop
    # Raised when we've iterated through all offenses
    class NoOffensesError < StandardError; end

    # Offenses found by a RuboCop run
    class Offenses
      def initialize(paths)
        formatter = 'RuboBot::RuboCop::Formatter::OffenseCountFormatter'
        options = { format: formatter,
                    formatters: [[formatter]] }

        @paths = Array(paths)
        @runner = ::RuboCop::Runner.new(options, ::RuboCop::ConfigStore.new)
      end

      def next
        Offense.new([offenses.shift].to_h)
      rescue TypeError
        raise NoOffensesError
      end

      def size
        offenses.size
      end

      def ==(other)
        to_h == other.to_h
      end

      def to_h
        offenses.each_with_object({}) do |(cop, count), memo|
          memo[cop.name] = count
        end
      end

      private

      attr_reader :paths
      attr_reader :runner

      def offenses
        @offenses ||= offenses!
      end

      def offenses!
        sorted_offenses.
          each_with_object({}) do |(name, count), memo|
            cop = ::RuboCop::Cop::Cop.registry.find_by_cop_name(name).new
            memo[cop] = count
          end
      end

      def sorted_offenses
        runner.run(paths)
        formatter = runner.send(:formatter_set).first
        formatter.offense_counts.sort_by(&:last)
      end
    end
  end
end
