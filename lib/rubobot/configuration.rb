# frozen_string_literal: true

module RuboBot
  # Configuration options
  class Configuration
    def initialize(options = Hash.new(false))
      @options = options
    end

    %i(verbose commit_message version).each do |option|
      define_method("#{option}?") { options[option] }
    end

    private

    attr_reader :options
  end
end
