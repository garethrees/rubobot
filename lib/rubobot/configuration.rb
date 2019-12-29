# frozen_string_literal: true

module RuboBot
  # Configuration options
  class Configuration
    DEFAULTS = { verbose: false,
                 commit_message: false,
                 version: false,
                 stdout: $stdout,
                 stderr: $stderr,
                 ctime: Time.now }.freeze

    def initialize(options = {})
      @options = options
    end

    %i[verbose commit_message version].each do |option|
      define_method("#{option}?") { parsed_options[option] }
    end

    %i[stdout stderr ctime].each do |option|
      define_method(option) { parsed_options[option] }
    end

    private

    attr_reader :options

    def parsed_options
      @parsed_options ||= DEFAULTS.merge(options)
    end
  end
end
