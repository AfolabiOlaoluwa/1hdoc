module HDOC
  ##
  # Provides an interface for Git in order to manage user's repo.
  # It's based upon `git` gem.
  class Committer
    attr_reader :git
    WorkspaceNotFound = Class.new(RuntimeError)

    ##
    # Initialize the workspace.
    def self.init(path, forked_repo_url, git = Git)
      forked_repo = git.clone('https://github.com/Kallaway/100-days-of-code', path)
      forked_repo.remote('origin').remove
      forked_repo.add_remote('origin', forked_repo_url)

      path
    end

    def initialize(path = '~/.1hdoc.yml', config_parser = Configuration, git = Git)
      @path = File.expand_path(path, File.dirname($PROGRAM_NAME))
      @config = config_parser.new(@path).options
      @git = git

      check_for_workspace
    end

    def commit(message)
      @git.commit(message)
    end

    def add
      @git.add(all: true)
    end

    private

    def check_for_workspace
      @git.open(@config['workspace'] || 'nil')
    end
  end
end
