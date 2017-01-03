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
      @config_file = File.expand_path('~/.1hdoc.yml')

      return init unless File.exist?(@config_file)

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

        opts.on('-l', '--log [DAY]', 'Show the entire log or per day') do |day|
          show_log(day)
        end
      end
    end

    ##
    # Initialize necessary files such as the configuration file.
    def init
      print 'Type the full path for your new repo (ex. ~/works/my_repo): '
      workspace = $stdin.gets.chomp

      Configuration.init(@config_file, 'workspace' => File.expand_path(workspace),
                                       'auto_push' => true)
      Committer.init(workspace)

      puts 'Here we are! You are ready to start.'
    end

    ##
    # Track user's progress for the current day.
    def commit
      log_handler = LogBuilder.new(@log_path)
      committer = Committer.new(@config_options['workspace'])

      return puts 'You are done for today :)' unless log_handler.record_not_exist?

      latest_day = log_handler.add(register_daily_commit)
      committer.commit("Add Day #{latest_day}")

      push_commit(@config_options['workspace']) if @config_options['auto_push']
    end

    ##
    # Manually push the daily commit to user's repository.
    def sync
      push_commit(@config_options['workspace'])
    end

    def version
      puts '1hdoc ver' + VERSION
    end
  end
end
