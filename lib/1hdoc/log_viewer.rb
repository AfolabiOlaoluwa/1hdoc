module HDOC
  ##
  # Show the user's log in a human-readable way.
  class LogViewer
    include Utilities

    def initialize(path, file_parser = YAML)
      @path = File.expand_path(path, File.dirname($PROGRAM_NAME))
      @log = retrieve_log(@path, file_parser)
    end

    def show(log_day = nil)
      result = ''

      @log.each do |day, data|
        # Check if the user asked for a specific day, so ignore the others.
        next if !log_day.nil? && day != log_day

        links = data['links'].map { |title, url| "#{title}: #{url}" }.join("\n  ")
        result << format_log(day, data, links)
      end

      result
    end

    private

    ##
    # Format log's data in order to get something like:
    #   ```
    #   - Day 1 -
    #     ** Progress **
    #     Fixed CSS, worked on canvas functionality for the app.
    #
    #     ** Thoughts **
    #     I really struggled with CSS.
    #
    #     ** Links **
    #     Calculator App: http://www.example.com/
    #   ```
    def format_log(day, data, links)
      %(
        |- Day #{day} -
        |
        |  ** Progress ** \n  #{data['progress']}
        |
        |  ** Thoughts ** \n  #{data['thoughts']}
        |
        |  ** Links **    \n  #{links}
      ).gsub(/ +\|/, '')
    end
  end
end
