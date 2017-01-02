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
      @config_file = '~/.1hdoc.yml'
    end

    ##
    # Parse defined options.
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

    ##
    # Initialize necessary files such as the configuration file.
    def init
      print 'Type the full path for your new repo (ex. ~/works/my_repo): '
      workspace = gets.chomp

      Configuration.init(@config_file, File.expand_path(workspace))
      Committer.init(workspace)

      puts 'Here we are! You are ready to start.'
    end

    ##
    # Synchronize user's progress with the online repository.
    def sync
      config = Configuration.new(@config_file)
      log_handler = LogBuilder.new(File.join(config.options['workspace'], 'log.yml'))

      sync_repo(log_handler.log.keys.last, config.options)
    end

    def sync_repo(day, options)
      return unless options['auto_push']

      committer = Committer.new(options['workspace'])
      committer.push("Add Day #{day}")
    rescue Exception => exception
      puts exception.message
    end

    def version
      puts '1hdoc ver0.1.0'
    end
  end
end
