require_relative 'spec_helper'
require_relative '../lib/1hdoc/configuration'

describe HDOC::Configuration do
  before do
    @config_path = './fixtures/config_example.yaml'
    @config = described_class.new(@config_path)
  end

  it 'should return an hash' do
    expect(@config.options['workspace']).to eq('~/workspace')
  end

  context ' during initialization' do
    it 'should raise an error because no file found' do
      expected_error = Errno::ENOENT
      expect { described_class.new('./fixt2res') }.to raise_error(expected_error)
    end
  end

  context '.init' do
    before { @config_path = expand_path('./fixtures/config_example_2.yaml') }
    after { File.delete(@config_path) }

    it 'should initialize a new configuration file' do
      described_class.init(@config_path)
      expect(File.exist?(@config_path)).to eq(true)
    end
  end
end
