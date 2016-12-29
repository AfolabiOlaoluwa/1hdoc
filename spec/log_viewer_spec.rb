require_relative 'spec_helper'
require_relative '../lib/1hdoc/log_viewer'

describe HDOC::LogViewer do
  subject { described_class.new('./fixtures/log_example.yaml') }

  context '#show' do
    it 'should return the whole log' do
      expect(subject.show).to include('- Day 1 -')
      expect(subject.show).to include('- Day 2 -')
    end

    it 'should return a specific record' do
      expect(subject.show(2)).not_to include('- Day 1 -')
      expect(subject.show(2)).to include('- Day 2 -')
    end

    it 'should return anything if the given day is invalid' do
      expect(subject.show(-2)).to eq('')
    end
  end
end
