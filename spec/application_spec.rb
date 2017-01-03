require_relative 'spec_helper'
require_relative '../lib/1hdoc'

describe HDOC::Application do
  before do
    @config_file = File.expand_path('~/.1hdoc.yml')
    File.write(@config_file, 'workspace: RSpec') unless File.exist?(@config_file)
    @app = described_class.new
  end

  after { File.delete(@config_file) if File.read(@config_file) == 'workspace: RSpec' }

  context '#run' do
    it 'should show help if no command is match' do
      ARGV[0] = '--invalid_command'
      expect { @app.run }.to output(/Usage: 1hdoc/).to_stdout
    end
  end

  context '#version' do
    it 'should show right program version' do
      ARGV[0] = '-v'
      expect { @app.run }.to output("1hdoc ver#{HDOC::VERSION}\n").to_stdout
    end
  end
end
