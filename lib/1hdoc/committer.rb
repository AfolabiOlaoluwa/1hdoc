module HDOC
  ##
  # Provides an interface for Git in order to manage user's repo.
  # It's based upon `git` gem.
  class Committer
    attr_reader :git
    WorkspaceNotFound = Class.new(RuntimeError)

    ##
    # Initialize the workspace.
    def self.init(path, git = Git)
      $stderr.puts 'Cloning #100DaysOfCode repository..'
      git.clone('https://github.com/Kallaway/100-days-of-code', path)
    end

    def initialize(path, git = Git)
      @path = path
      @git = git

      check_for_valid_repo
    end

    def commit(message)
      @git.commit(message)
    end

    def add
      @git.add(all: true)
    end

    private

    ##
    # Check if the the given path corresponds to a valid repo.
    # By default, Git.open should raises an error if the path isn't valid.
    def check_for_valid_repo
      @git.open(@path)
    end
  end
end
