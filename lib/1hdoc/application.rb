module HDOC
  ##
  # Provides an interface for interact with the program.
  class Application
    include Integration

    AVAILABLE_COMMANDS = [
      ['-i', '--init', 'Initialize necessary files.'],
      ['-c', '--commit', 'Register your progress and sync it.'],
      ['-s', '--sync', 'Manually synchronize your online repository.'],
      ['-v', '--version', 'Show program version.']
    ].freeze

    def initialize(option_parser = OptionParser)
      @option_parser = option_parser
      @config_file = '~/.1hdoc.yml'

      @config_options = Configuration.new(@config_file).options
      @log_path = File.join(@config_options['workspace'], 'log.yml')
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

      Configuration.init(@config_file, workspace: File.expand_path(workspace),
                                       auto_push: true)
      Committer.init(workspace)

      puts 'Here we are! You are ready to start.'
    end

    ##
    # Synchronize user's progress with the online repository.
    def sync
      log_handler = LogBuilder.new(@log_path)
      sync_repo(log_handler.log.keys.last, @config_options['workspace'])
    end

    ##
    # Track user's progress for the current day.
    def commit
      log_handler = LogBuilder.new(@log_path)

      return puts 'You are done for today :)' unless log_handler.record_not_exist?
      latest_day = log_handler.add(register_record)

      if @config_options['auto_push']
        puts 'Synchronizing with the online repository..'
        sync_repo(latest_day, @config_options['workspace'])
      end
    end

    def version
      puts '1hdoc ver0.1.0'
    end
  end
end
