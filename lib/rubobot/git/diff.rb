# frozen_string_literal: true

module RuboBot
  module Git
    # Diff
    class Diff
      def initialize(project_dir)
        @project_dir = project_dir
      end

      # Have the files changed in the project dir?
      #
      # `git diff --quiet` exits with 1 if there were differences and 0 means no
      # differences.
      #
      # `system` returns true if the exit code was 0, and false for non-zero
      # exits.
      #
      # Therefore, we need to swap the Boolean on return.
      def files_changed?
        Dir.chdir(project_dir) do
          @status = system('git diff --quiet')
        end

        @status ? false : true
      end

      private

      attr_reader :project_dir
    end
  end
end
