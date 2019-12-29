# frozen_string_literal: true

require 'open3'

module RuboBot
  module RuboCop
    # Run rubocop to auto-correct a cop
    class AutoCorrect
      # Error for issues with running rubocop
      class RunError < StandardError; end

      # Error for calling methods on an AutoCorrect if the given Cop is not
      # able to Auto-Correct
      class NotAutoCorrectableError < StandardError; end

      def initialize(cop, paths)
        @cop = cop
        @paths = paths
      end

      def run
        files_changed?
      end

      def files_changed?
        return false unless autocorrect?
        status.success?
      end

      def commit_message
        raise NotAutoCorrectableError unless autocorrect?
        Git::CommitMessage.new(cop.name, command, stdout_str)
      end

      private

      attr_reader :cop
      attr_reader :paths

      def autocorrect?
        cop.support_autocorrect? && cop.autocorrect_enabled?
      end

      # attr_reader
      def stdout_str
        @stdout_str ||= run!.first
      end

      # attr_reader
      def status
        @status ||= run!.last
      end

      def run!
        @stdout_str, @status = Open3.capture2(command)
      end

      def command
        'rubocop --safe-auto-correct --format clang ' \
        "--only #{cop.name} #{paths.join(' ')}"
      end
    end
  end
end
