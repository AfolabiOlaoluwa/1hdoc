require_relative 'spec_helper'
require_relative '../lib/1hdoc/core/configuration'

describe HDOC::Configuration do
  before do
    @config_path = './fixtures/config_example.yaml'
    @config = described_class.new(@config_path)
  end

  it 'should return an hash' do
    expect(@config.options['workspace']).to eq('~/workspace')
  end

  context ' during initialization ' do
    it 'should raise an error because no file found' do
      expect { described_class.new('./fixt2res') }.to raise_error(Errno::ENOENT)
    end
  end

  context '.init' do
    before { @config_path = expand_path('./fixtures/config_example_2.yaml') }
    after  { File.delete(@config_path) }

    it 'should initialize a new configuration file' do
      described_class.init(@config_path, workspace: '~/Workspace/my_repo',
                                         auto_push: false)
      result = File.read(@config_path)

      expect(result).to include('~/Workspace/my_repo')
      expect(result).to include('auto_push: false')
    end
  end
end
