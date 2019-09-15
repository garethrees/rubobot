# frozen_string_literal: true

module RuboBot
  module RuboCop
    # An offense found by RuboCop
    class Offense
      def initialize(offense_data)
        @offense_data = offense_data
      end

      def name
        offense.name
      end

      def count
        offense.count
      end

      def ==(other)
        offense_data == other.offense_data
      end

      protected

      attr_reader :offense_data

      private

      def offense
        data = Struct.new(:name, :count)
        data.new(*offense_data.first)
      end
    end
  end
end
