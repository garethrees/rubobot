# frozen_string_literal: true

module RuboBot
  # The project we're working on
  class ProjectDir
    def initialize(dir, git_repo: git_repo)
      @dir = dir
      @repo = git_repo || GitRepo.new(dir)
    end

    def run_rubobot
      puts "#{offenses.send(:sorted_offenses)}"

      loop do
        puts 'Getting offenses'
        cop = offenses.next.name

        puts "Auto-correcting #{ cop }"
        commit_message = autocorrect(cop)

        if files_changed?
          puts "Committing #{ cop }"
          repo.commit_all(commit_message)
          break
        end
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

    def autocorrect(cop)
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
