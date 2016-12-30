require_relative 'spec_helper'
require_relative '../lib/1hdoc/log_builder'

describe HDOC::LogBuilder do
  before do
    @log_path = './fixtures/log_example_2.yaml'
    @log = described_class.new(@log_path)
  end

  context '#add' do
    it 'should add a new record to the log' do
      @log.add(progress: 'Fixed CSS.', thoughts: 'I love Sass', links: {})
      expect(read_file(@log_path)).to include('I love Sass')
    end

    it 'should return false because there is already a record' do
      expect(@log.add(progress: 'Fixed CSS.')).to eq(false)
    end

    it 'should numbering the days' do
      expect(read_file(@log_path)).to include('1')
      File.write(expand_path(@log_path), '')
    end
  end
end
