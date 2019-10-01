# frozen_string_literal: true

module RuboBot
  # Entrypoint for running RuboBot from the CLI
  class CLI
    STATUS_SUCCESS = 0
    STATUS_FAILURE = 1

    def self.run(argv)
      cli_options = CliOptions.new(argv)
      configuration = Configuration.new(cli_options)
      project_dir = ProjectDir.new(cli_options[:path])
      new(project_dir, configuration).run
    end

    def initialize(project_dir, configuration)
      @project_dir = project_dir
      @configuration = configuration
    end

    def run
      return output(VERSION) if configuration.version?

      project_dir.run_rubobot
      STATUS_SUCCESS
    rescue RuboBot::RuboCop::NoOffensesError
      STATUS_FAILURE
    end

    private

    def output(string)
      configuration.stdout.puts(string)
      STATUS_SUCCESS
    end

    attr_reader :configuration
    attr_reader :project_dir
  end
end
