require_relative 'spec_helper'
require_relative '../lib/1hdoc'

describe HDOC::Application do
  before { @app = described_class.new }

  context '#run' do
    it 'should show help if no command is match' do
      ARGV[0] = '--invalid_command'
      expect { @app.run }.to output(/Usage: 1hdoc/).to_stdout
    end

    it 'should execute the right command' do
      ARGV[0] = '-v'
      expect { @app.run }.to output(/1hdoc ver/).to_stdout
    end
  end
end
