# frozen_string_literal: true

module RuboBot
  # Entrypoint for running RuboBot from the CLI
  class CLI
    STATUS_SUCCESS = 0
    STATUS_FAILURE = 1

    def run(args = ARGV)
      project_dir = args[0] || Dir.pwd
      rubocop_run = RuboBot::RuboCop::Run.new(project_dir)
      rubocop_run.run
      offenses = rubocop_run.offenses
      puts offenses.send :sorted_offenses
      STATUS_SUCCESS
    rescue RuboBot::RuboCop::NoOffensesError
      STATUS_FAILURE
    end
  end
end
