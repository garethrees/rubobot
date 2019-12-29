# frozen_string_literal: true

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

        formatter = 'RuboBot::RuboCop::Formatter::ClangStyleFormatter'
        options = { safe_auto_correct: true,
                    auto_correct: true,
                    format: formatter,
                    formatters: [[formatter]],
                    only: [cop.name] }

        @runner = ::RuboCop::Runner.new(options, ::RuboCop::ConfigStore.new)
      end

      def run
        files_changed?
      end

      def files_changed?
        status
      end

      def commit_message
        raise NotAutoCorrectableError unless autocorrect?
        Git::CommitMessage.new(cop.name, command, stdout_str)
      end

      private

      attr_reader :cop
      attr_reader :paths
      attr_reader :runner

      def autocorrect?
        cop.support_autocorrect? && cop.autocorrect_enabled?
      end

      def status
        @status ||= run!
      end

      def stdout_str
        return @stdout_str if @stdout_str
        run!
        @stdout_str = runner.send(:formatter_set).first.output.string
      end

      def run!
        return false unless autocorrect?
        runner.run(paths)
      end

      # The command we would have run if shelling out, so that we can record it
      # in the commit message for manual reproduction.
      def command
        'rubocop --safe-auto-correct --format clang ' \
        "--only #{cop.name} #{paths.join(' ')}"
      end
    end
  end
end
