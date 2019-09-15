# frozen_string_literal: true

require 'open3'

module RuboBot
  module RuboCop
    # Run rubocop to collect a list of offenses
    class Run
      OFFENSE_PATTERN = %r{\A(?<count>\d+)\s+(?<cop>\w+\/\w+)\z}.freeze

      def initialize(project_dir)
        @project_dir = project_dir
        @stdout_str = ''
      end

      def offenses
        Offenses.new(offense_data)
      end

      def run
        @stdout_str, status = run!
        status.success?
      end

      private

      attr_reader :project_dir
      attr_reader :stdout_str

      def offense_data
        offense_lines.each_with_object({}) do |line, memo|
          memo[line[:cop]] = line[:count].to_i
        end
      end

      def offense_lines
        rubocop_output_lines.map { |line| line.match(OFFENSE_PATTERN) }.compact
      end

      def rubocop_output_lines
        stdout_str.each_line.map(&:chomp)
      end

      def run!
        Open3.capture2("rubocop -f o #{project_dir}")
      end
    end
  end
end
