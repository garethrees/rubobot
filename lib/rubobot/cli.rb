# frozen_string_literal: true

module RuboBot
  # Entrypoint for running RuboBot from the CLI
  class CLI
    STATUS_SUCCESS = 0
    STATUS_FAILURE = 1

    def run(args = ARGV)
      project_dir = ProjectDir.new(args[0] || Dir.pwd)

      rubocop_run = RuboBot::RuboCop::Run.new(project_dir)
      rubocop_run.run

      offenses = rubocop_run.offenses
      puts offenses.send :sorted_offenses

      loop do
        cop = offenses.next.name
        puts "Running #{ cop }"

        ac = RuboBot::RuboCop::AutoCorrect.new(project_dir, cop)
        ac.run

        if project_dir.files_changed?
          puts "Committing #{ cop }"
          Git::Commit.new(project_dir).create(ac.commit_message)

          break STATUS_SUCCESS
        end
      end
    rescue RuboBot::RuboCop::NoOffensesError
      STATUS_FAILURE
    end
  end
end
