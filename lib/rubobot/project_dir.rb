# frozen_string_literal: true

module RuboBot
  # The project we're working on
  class ProjectDir
    def initialize(dir)
      @dir = dir
    end

    def files_changed?(diff_tool: Git::Diff.new(to_s))
      diff_tool.files_changed?
    end

    def to_s
      dir
    end

    private

    attr_reader :dir
  end
end
