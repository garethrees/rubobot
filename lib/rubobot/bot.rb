# frozen_string_literal: true

module RuboBot
  # Run rubobot
  class Bot
    def initialize(configuration = Configuration.new)
      @configuration = configuration
    end

    def autocorrect(paths)
      loop do
        ac = RuboBot::RuboCop::AutoCorrect.new(next_cop(paths), paths)

        if ac.run
          configuration.stdout.puts(ac.commit_message)
          break
        end
      end
    end

    private

    attr_reader :configuration

    def next_cop(paths)
      offenses(paths).next.name
    end

    def offenses(paths)
      @offenses ||= offenses!(paths)
    end

    def offenses!(paths)
      RuboBot::RuboCop::Offenses.new(paths)
    end
  end
end
