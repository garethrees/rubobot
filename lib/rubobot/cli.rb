# frozen_string_literal: true

module RuboBot
  # Entrypoint for running RuboBot from the CLI
  class CLI
    STATUS_SUCCESS = 0
    STATUS_FAILURE = 1

    def run(args = ARGV)
      project_dir = ProjectDir.new(args[0] || Dir.pwd)
      project_dir.run_rubobot
      STATUS_SUCCESS
    rescue RuboBot::RuboCop::NoOffensesError
      STATUS_FAILURE
    end
  end
end
