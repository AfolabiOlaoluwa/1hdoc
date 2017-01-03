module HDOC
  ##
  # Provides methods used across various commands.
  module Integration
    QUESTIONS = {
      progress: 'Your progress:',
      thoughts: 'Your thoughts:',
      link: 'Link to work:'
    }.freeze

    def push_commit(workspace)
      committer = Committer.new(workspace)
      committer.push
      $stderr.puts 'Daily commit pushed with success!'
    rescue Exception => exception
      $stderr.puts exception.message
    end

    def register_daily_commit
      record = {}

      QUESTIONS.each do |key, question|
        record[key] = ask(question)
      end

      record
    end

    private

    def ask(message)
      puts message
      gets.chomp
    end
  end
end
