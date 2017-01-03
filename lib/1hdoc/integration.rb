module HDOC
  ##
  # Provides methods used across various commands.
  module Integration
    def sync_repo(day, workspace)
      committer = Committer.new(workspace)
      committer.push("Add Day #{day}")
    rescue Exception => exception
      puts exception.message
    end

    def register_record
      record = {}

      puts 'Your progress: '
      record[:progress] = gets.chomp

      puts 'Your thoughts: '
      record[:thoughts] = gets.chomp

      puts 'Link to work: '
      record[:link] = gets.chomp

      record
    end
  end
end
