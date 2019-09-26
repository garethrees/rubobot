# frozen_string_literal: true

require 'git'
require 'time'

module RuboBot
  # The git repository for a ProjectDir
  class GitRepo
    # Raised when a commit is attempted when nothing has changed
    class NothingToCommit < StandardError; end

    def initialize(project_dir)
      @project_dir = project_dir
    end

    def commit_all(message)
      repo.add

      raise NothingToCommit unless files_changed?

      repo.checkout(branch_name, new_branch: true)
      repo.commit(message)
    end

    # Have the files changed in the project dir?
    def files_changed?
      repo.status.changed.any? || repo.status.added.any?
    end

    private

    attr_reader :project_dir

    def branch_name
      "rubobot-#{Time.now.strftime('%F-%H-%M-%S')}"
    end

    def repo
      @repo ||= ::Git.open(project_dir)
    end
  end
end
