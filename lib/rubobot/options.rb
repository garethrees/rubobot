# frozen_string_literal: true

require 'optparse'

module RuboBot
  # Parse options passed from the CLI
  class Options
    def initialize(args)
      @args = args
    end

    def [](key)
      parse[key]
    end

    def to_hash
      parse
    end

    private

    attr_reader :args

    def parse
      options = {}
      option_parser.parse!(args, into: options)
      options[:paths] = args
      options
    end

    def option_parser
      OptionParser.new do |opts|
        opts.banner = 'Usage: rubobot [options] [paths]'
        opts.on('--commit-message', 'Print commit message')
        opts.on('-v', '--version', 'Print version')
        opts.on('--verbose', 'Print debug info')
      end
    end
  end
end
