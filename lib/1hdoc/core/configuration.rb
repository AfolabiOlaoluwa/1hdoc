module HDOC
  ##
  # Manage configuration files.
  class Configuration
    attr_reader :options
    include Utilities

    ##
    # Initialize a new configuration file.
    def self.init(path, options)
      options['auto_push'] ||= true
      File.open(File.expand_path(path), 'w') { |file| file.puts(options.to_yaml) }
    end

    def initialize(path, config_parser = YAML)
      @options = parse_file(expand_path(path), config_parser)
      sanitize_options
    end

    private

    def sanitize_options
      @options.each { |key, value| @options[key] = '' if value.nil? }
    end
  end
end
