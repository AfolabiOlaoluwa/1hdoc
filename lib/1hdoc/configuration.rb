module HDOC
  ##
  # Manage configuration files.
  class Configuration
    attr_reader :options

    OPTIONS = {
      'workspace' => '~/Workspace/my_repo',
      'auto_push' => true
    }.freeze

    ##
    # Initialize a configuration file.
    def self.init(path)
      File.open(path, 'w') { |file| file.puts(OPTIONS.to_yaml) }
    end

    def initialize(path, config_parser = YAML)
      @path = File.expand_path(path, File.dirname($PROGRAM_NAME))
      @config_parser = config_parser

      @options = parse_configuration
      sanitize_options
    end

    private

    def parse_configuration
      raise Errno::ENOENT, "Unable to find #{@path}" unless File.exist?(@path)
      @config_parser.load_file(@path) || {}
    end

    def sanitize_options
      @options.each { |key, value| @options[key] = '' if value.nil? }
    end
  end
end
