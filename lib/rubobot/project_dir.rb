# frozen_string_literal: true

module RuboBot
  # The project we're working on
  class ProjectDir
    def initialize(dir, git_repo: GitRepo.new(dir))
      @dir = dir
      @repo = git_repo
    end

    def run_rubobot
      loop do
        commit_message = autocorrect(next_cop)
        break if files_changed?
      end
    end

    def files_changed?
      repo.files_changed?
    end

    def to_s
      dir
    end

    private

    attr_reader :dir
    attr_reader :repo

    def next_cop
      puts 'Getting offenses'
      offenses.next.name
    end

    def autocorrect(cop)
      puts "Auto-correcting #{cop}"
      ac = RuboBot::RuboCop::AutoCorrect.new(dir, cop)
      ac.run
      ac.commit_message
    end

    def offenses
      rubocop_run = RuboBot::RuboCop::Run.new(dir)
      rubocop_run.run
      rubocop_run.offenses
    end
  end
end
