# frozen_string_literal: true
require 'rubocop'

require 'rubobot/bot'
require 'rubobot/cli'
require 'rubobot/configuration'
require 'rubobot/options'
require 'rubobot/version'

require 'rubobot/git/commit_message'

require 'rubobot/rubocop/auto_correct'
require 'rubobot/rubocop/offense'
require 'rubobot/rubocop/offenses'

require 'rubobot/rubocop/formatter/offense_count_formatter'

# Automate RuboCop Auto-correct
module RuboBot
end
