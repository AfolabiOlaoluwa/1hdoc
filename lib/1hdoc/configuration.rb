module HDOC
  ##
  # Manage configuration file.
  class Configuration
    attr_reader :options
    FileNotFound = Class.new(RuntimeError)

    def initialize(path, config_parser = YAML)
      @path = File.expand_path(path, File.dirname($PROGRAM_NAME))
      @config_parser = config_parser

      @options = parse_configuration
    end

    private

    def parse_configuration
      raise FileNotFound, "Unable to find #{@path}" unless File.exist?(@path)
      @config_parser.load_file(@path) || {}
    end
  end
end
