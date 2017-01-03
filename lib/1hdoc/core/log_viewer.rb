module HDOC
  ##
  # Show the user's log in a human-readable way.
  class LogViewer
    include Utilities

    def initialize(path, file_parser = YAML)
      @path = expand_path(path)
      @log = parse_file(@path, file_parser)
    end

    ##
    # Show the entire log or filtered by day.
    def show(target_day = 0)
      result = ''

      @log.each do |day, data|
        next if !target_day.zero? && day != target_day
        result << format_log(day, data)
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
    #     -- Link to work: http://www.example.com/
    #   ```
    def format_log(day, data)
      %(
        |- Day #{day} -
        |
        |  ** Progress ** \n  #{data['progress']}
        |
        |  ** Thoughts ** \n  #{data['thoughts']}
        |
        |  -- Link to work: #{data['link']}
      ).gsub(/ +\|/, '')
    end
  end
end
