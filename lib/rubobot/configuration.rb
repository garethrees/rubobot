# frozen_string_literal: true

module RuboBot
  # Configuration options
  class Configuration
    DEFAULTS = { verbose: false,
                 commit_message: false,
                 version: false,
                 stdout: $stdout,
                 stderr: $stderr }.freeze

    def initialize(options = {})
      @options = options
    end

    %i[verbose commit_message version].each do |option|
      define_method("#{option}?") { parsed_options[option] }
    end

    %i[stdout stderr].each do |option|
      define_method(option) { parsed_options[option] }
    end

    private

    def parsed_options
      @parsed_options ||= DEFAULTS.merge(options)
    end

    attr_reader :options
  end
end
