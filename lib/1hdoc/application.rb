module HDOC
  ##
  # Provides an interface for interact with the program.
  class Application
    AVAILABLE_COMMANDS = [
      ['-i', '--init', 'Initialize necessary files.'],
      ['-c', '--commit', 'Register your progress and sync it.'],
      ['-s', '--sync', 'Manually synchronize your online repository.'],
      ['-v', '--version', 'Show program version.']
    ].freeze

    def initialize(option_parser = OptionParser)
      @option_parser = option_parser
    end

    def run
      options = initialize_options
      options.parse!
    rescue @option_parser::InvalidOption
      puts options
    end

    private

    def initialize_options
      @option_parser.new do |opts|
        opts.banner = 'Usage: 1hdoc -h'

        AVAILABLE_COMMANDS.each do |command|
          opts.on(*command) { send(command[1].sub('--', '')) }
        end
      end
    end

    def init
      print 'Type the full path for your new repo (ex. ~/works/my_repo): '
      workspace = gets.chomp

      Configuration.init('~/.1hdoc.yml', File.expand_path(workspace))
      Committer.init(workspace)

      puts 'Here we are! You are ready to start.'
    end

    def version
      puts '1hdoc ver0.1.0'
    end
  end
end
