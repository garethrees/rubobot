# frozen_string_literal: true

module RuboBot
  # The project we're working on
  class ProjectDir
    def initialize(dir, repo: repo)
      @dir = dir
      @repo = repo || GitRepo.new(dir)
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
  end
end
