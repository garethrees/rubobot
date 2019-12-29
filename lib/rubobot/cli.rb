# frozen_string_literal: true

module RuboBot
  # Entrypoint for running RuboBot from the CLI
  class CLI
    STATUS_SUCCESS = 0
    STATUS_FAILURE = 1

    def self.run(argv)
      options = Options.new(argv)
      new(options[:paths], Configuration.new(options)).run
    end

    def initialize(paths, configuration)
      @paths = paths
      @configuration = configuration
    end

    def run
      return output(VERSION) if configuration.version?

      commit_message = Bot.new(configuration).autocorrect(paths)
      output(commit_message) if configuration.commit_message?
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
    attr_reader :paths
  end
end
