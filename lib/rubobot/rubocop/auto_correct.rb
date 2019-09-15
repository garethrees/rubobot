# frozen_string_literal: true

require 'open3'

module RuboBot
  module RuboCop
    # Run rubocop to auto-correct a cop
    class AutoCorrect
      # Error for issues with running rubocop
      class RunError < StandardError; end

      def initialize(project_dir, cop)
        @project_dir = project_dir
        @cop = cop
      end

      def run
        @stdout_str, status = run!
        status.success?
      end

      def commit_message
        raise RunError unless stdout_str

        Git::CommitMessage.new(cop, command, stdout_str)
      end

      private

      attr_reader :project_dir
      attr_reader :stdout_str
      attr_reader :cop

      def run!
        Open3.capture2(command)
      end

      def command
        'rubocop --safe-auto-correct --format clang ' \
        "--only #{cop} #{project_dir}"
      end
    end
  end
end
