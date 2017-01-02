module HDOC
  ##
  # Provides methods for manage user's log such as adding records.
  class LogBuilder
    attr_reader :log
    include Utilities

    def initialize(path, file_parser = YAML)
      @path = File.expand_path(path, File.dirname($PROGRAM_NAME))
      @log = retrieve_log(@path, file_parser)

      @today_date = Time.now.strftime('%Y-%m-%d')
      @record = {}
    end

    def add(data)
      day = fetch_current_day

      @record[day] = stringify_symbols(data)
      @record[day]['published_on'] = @today_date

      append_to_log
    end

    ##
    # Check if there is no record for the current day.
    def record_not_exist?
      last_day = @log.keys.last
      last_day.nil? || @log[last_day]['published_on'] != @today_date
    end

    private

    def append_to_log
      File.open(@path, 'a') { |file| file.puts @record.to_yaml.sub('---', '') }
      @record.keys.first
    end

    def fetch_current_day
      (@log.keys.last || 0) + 1
    end
  end
end
