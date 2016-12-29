require_relative 'spec_helper'
require_relative '../lib/1hdoc/log_builder'

describe HDOC::LogBuilder do
  subject { described_class.new('./fixtures/log_example.yaml') }

  before do
    subject.add(day: 2, progress: 'Fixed CSS', thoughts: '--', links: {})
  end

  it 'should add a new record to the log' do
    expect(subject.log[2]).not_to be_nil
  end

  it 'should edit a record' do
    subject.edit(2, progress: 'Fixed CSS.')
    expect(subject.log[2]['progress']).to eq('Fixed CSS.')
  end

  it 'should write the edits on file' do
    filename = expand_path('fixtures/log_example_2.yaml')
    log = described_class.new(filename)

    log.add(day: 2, progress: 'Fixed CSS', thoughts: '--', links: {})
    log.build

    expect(File.read(filename)).to include('Fixed CSS')
    File.open(filename, 'w') { |file| file.puts '---' }
  end

  it 'should transform symbols keys to string ones' do
    expect(subject.log[2]['progress']).to eq('Fixed CSS')
  end

  it 'should raise an error if log file is not found' do
    expected_error = HDOC::Utilities::LogNotFound
    expect { described_class.new('u2/log.yaml') }.to raise_error(expected_error)
  end

  it 'should raise an error if day is not found' do
    expected_error = HDOC::Utilities::DayNotFound
    expect { subject.edit(21, progress: 'None') }.to raise_error(expected_error)
  end
end
