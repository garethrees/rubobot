# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubobot/version'

Gem::Specification.new do |spec|
  spec.name          = 'rubobot'
  spec.version       = RuboBot::VERSION
  spec.authors       = ['Gareth Rees']
  spec.email         = ['gareth@garethrees.co.uk']

  spec.summary       = 'Automate code cleanup, one cop at a time'
  spec.description   = 'Runs RuboCop Auto-correct for the cop with the ' \
                       'lowest offense count, making it easier to ' \
                       'incrementally improve your codebase.'

  spec.homepage      = 'https://github.com/garethrees/rubobot'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added
  # into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(spec)/})
    end
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rubocop', '0.63.1'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
