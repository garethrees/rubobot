# frozen_string_literal: true

require 'optparse'

module RuboBot
  # Parse options passed from the CLI
  class CliOptions
    def initialize(args)
      @args = args
      @options = {}
    end

    def [](key)
      parse[key]
    end

    private

    attr_reader :args
    attr_reader :options

    def parse
      duped_args = args.dup
      option_parser.parse!(duped_args)
      options[:paths] = duped_args
      options
    end

     def option_parser
      OptionParser.new do |opts|
        opts.banner = 'Usage: rubobot [options] [paths]'

        opts.on('--commit-message', 'Print commit message') do |g|
          options[:commit_message] = true
        end

        opts.on('-v', '--version', 'Print version') do |g|
          options[:version] = true
        end

        opts.on('--verbose', 'Print debug info') do |g|
          options[:verbose] = true
        end
      end
    end
  end
end

