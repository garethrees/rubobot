# frozen_string_literal: true
require 'stringio'

module RuboBot
  module RuboCop
    module Formatter
      # This formatter collects the list of offended cops with a count of how
      # many offenses of their kind were found. Ordered by desc offense count.
      # Does not print output.
      class ClangStyleFormatter < ::RuboCop::Formatter::ClangStyleFormatter
        attr_reader :offense_counts

        def initialize(output, options = {})
          @output = StringIO.new
          @options = options
        end
      end
    end
  end
end
