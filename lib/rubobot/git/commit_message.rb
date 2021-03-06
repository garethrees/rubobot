# frozen_string_literal: true

module RuboBot
  module Git
    # A Git commit message
    class CommitMessage
      def initialize(cop, command, stdout)
        @cop = cop
        @command = command
        @stdout = stdout
      end

      def subject
        "Auto-correct #{cop}"
      end

      def body
        <<~MSG
          #{command}

          #{stdout}
        MSG
      end

      def to_s
        <<~MSG.chomp
          #{subject}

          #{body}
        MSG
      end

      def ==(other)
        to_h == other.to_h
      end

      protected

      def to_h
        { cop: cop,
          command: command,
          stdout: stdout }
      end

      private

      attr_reader :cop
      attr_reader :command
      attr_reader :stdout
    end
  end
end
