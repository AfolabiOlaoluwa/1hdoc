require 'git'
require_relative 'spec_helper'
require_relative '../lib/1hdoc/core/configuration'
require_relative '../lib/1hdoc/core/committer'

describe HDOC::Committer do
  context ' during initialization' do
    it 'should raise an error if unable to find the workspace' do
      workspace = '~/worksp4c3x1'
      expect { described_class.new(workspace) }.to raise_error(ArgumentError)
    end
  end

  context '.init' do
    before do
      allow($stderr).to receive(:puts)
      @repo_dir = expand_path('./fixtures/100-days-of-code')
    end

    after { FileUtils.remove_dir(@repo_dir) }

    it 'should initialize the workspace' do
      described_class.init(@repo_dir)
      expect { Git.open(@repo_dir) }.not_to raise_error
    end
  end
end
