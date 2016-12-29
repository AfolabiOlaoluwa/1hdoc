module HDOC
  ##
  # Manage user's log providing methods for:
  #   - add a record to the log
  #   - add an existing record
  #   - translate the log's hash in YAML
  class LogBuilder
    attr_reader :log
    include Utilities

    def initialize(path, file_parser = YAML)
      @path = File.expand_path(path, File.dirname($PROGRAM_NAME))
      @log = retrieve_log(@path, file_parser)
    end

    def add(**data)
      day = data.delete(:day)
      @log[day] = stringify_symbols(data)
    end

    def build
      File.open(@path, 'w') { |file| file.puts @log.to_yaml }
    end

    def edit(day, **data)
      raise DayNotFound, "Unable to find 'Day #{day}'" unless @log[day]
      @log[day].merge!(stringify_symbols(data))
    end
  end
end
