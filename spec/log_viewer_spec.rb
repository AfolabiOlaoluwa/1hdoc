require_relative 'spec_helper'
require_relative '../lib/1hdoc/log_viewer'

describe HDOC::LogViewer do
  subject { described_class.new('./fixtures/log_example.yaml') }

  it 'should show the whole log' do
    expect(subject.show).to include('- Day 1 -')
    expect(subject.show).to include('- Day 2 -')
  end

  it 'should show a specific record' do
    expect(subject.show(2)).not_to include('- Day 1 -')
    expect(subject.show(2)).to include('- Day 2 -')
  end
end
