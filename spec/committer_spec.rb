require 'git'
require 'fileutils'
require_relative 'spec_helper'
require_relative '../lib/1hdoc/configuration'
require_relative '../lib/1hdoc/committer'

describe HDOC::Committer do
  context '#initialize' do
    it 'should raise an error if unable to find the workspace' do
      config_file = './fixtures/config_example_2.yaml'
      expect { described_class.new(config_file) }.to raise_error(ArgumentError)
    end
  end

  context '.init' do
    before { @repo_dir = expand_path('./fixtures/100-days-of-code') }
    after  { FileUtils.remove_dir(@repo_dir) }

    it 'should initialize the workspace' do
      described_class.init(@repo_dir, 'https://github.com/domcorvasce/100-days-of-code')
      expect { Git.open(@repo_dir) }.not_to raise_error
    end
  end
end
