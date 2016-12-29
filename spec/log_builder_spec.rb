require 'yaml'
require_relative 'spec_helper'
require_relative '../lib/1hdoc/log_builder'

describe HDOC::LogBuilder do
  $PROGRAM_NAME = __FILE__
  subject { described_class.new('./fixtures/log_example.yaml') }

  it 'should add a new record to the log' do
    subject.add(day: 2, progress: 'Fixed CSS', thoughts: '--', links: {})
    expect(subject.log[2]).not_to be_nil
  end

  it 'should transform symbols keys to string ones' do
    subject.add(day: 3, progress: 'Fixed CSS', thoughts: '--', links: {})
    expect(subject.log[3]['progress']).to eq('Fixed CSS')
  end

  it 'should raise an error if log file is not found' do
    expected_error = HDOC::LogBuilder::LogNotFound
    expect { described_class.new('u2/log.yaml') }.to raise_error(expected_error)
  end
end
