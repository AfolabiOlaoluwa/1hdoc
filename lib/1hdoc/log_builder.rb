module HDOC
  ##
  # Provides methods for manage user's log such as adding records.
  class LogBuilder
    attr_reader :log
    include Utilities

    def initialize(path, file_parser = YAML)
      @path = File.expand_path(path, File.dirname($PROGRAM_NAME))
      @log = retrieve_log(@path, file_parser)

      @current_day = Time.now.strftime('%Y-%m-%d')
      @record = {}
    end

    def add(**data)
      return false if record_already_exist?
      day = fetch_next_day

      @record[day] = stringify_symbols(data)
      @record[day]['published_on'] = @current_day

      build
    end

    private

    ##
    # Check if there's already a record for the current day.
    def record_already_exist?
      last_day = @log.keys.last
      !last_day.nil? && @log[last_day]['published_on'] == @current_day
    end

    def build
      File.open(@path, 'a') { |file| file.puts @record.to_yaml }
    end

    def fetch_next_day
      (@log.keys.last || 0) + 1
    end
  end
end
