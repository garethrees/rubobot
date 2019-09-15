# frozen_string_literal: true

require 'git'

module RuboBot
  class GitRepo
    def initialize(project_dir)
      @project_dir = project_dir
    end

    # Have the files changed in the project dir?
    def files_changed?
      repo.status.changed.any?
    end

    private

    attr_reader :project_dir

    def repo
      @repo ||= Git.open(project_dir)
    end
  end
end
