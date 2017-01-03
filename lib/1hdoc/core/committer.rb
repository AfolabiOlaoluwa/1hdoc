module HDOC
  ##
  # Provides an interface for Git in order to manage user's repo.
  # It's based upon `git` gem.
  class Committer
    attr_reader :git

    ##
    # Initialize the workspace.
    def self.init(path, git = Git)
      path = File.expand_path(path)

      $stderr.puts 'Cloning #100DaysOfCode repository..'
      git.clone('https://github.com/domcorvasce/100-days-of-code', path)
    end

    def initialize(path, git = Git)
      @path = path
      @repo = git.open(path)
    end

    def push(message)
      @repo.add(all: true)
      @repo.commit(message)
      @repo.push
    end
  end
end