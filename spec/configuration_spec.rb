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

  context '#'
  it 'should raise an error because no file found' do
    expected_error = described_class::FileNotFound
    expect { described_class.new('./fixt2res') }.to raise_error(expected_error)
  end
end
