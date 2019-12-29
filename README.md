# RuboBot

RuboBot runs RuboCop Auto-correct for the cop with the lowest offense count, making it easier to incrementally improve your codebase.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubobot'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rubobot

## Usage

```sh
msg=`bundle exec rubobot` && git commit -am "$msg"
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/garethrees/rubobot.
