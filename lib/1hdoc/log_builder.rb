module HDOC
  # Manage user's log by adding or editing elements.
  class LogBuilder
    attr_reader :log

    LogNotFound = Class.new(RuntimeError)
    DayNotFound = Class.new(RuntimeError)

    def initialize(path, log_parser = YAML)
      @path = File.expand_path(path, File.dirname($PROGRAM_NAME))
      @log_parser = log_parser
      @log = retrieve_log
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

    private

    def retrieve_log
      raise LogNotFound, "Unable to find #{@path}" unless File.exist?(@path)
      @log_parser.load_file(@path) || {}
    end

    # Transform symbol's keys in string ones.
    def stringify_symbols(hash_object)
      keys = hash_object.keys

      0.upto(keys.length) do |pos|
        next unless keys[pos].is_a?(Symbol)
        hash_object[keys[pos].to_s] = hash_object.delete(keys[pos])
      end

      hash_object
    end
  end
end
