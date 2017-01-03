require 'rspec'
require 'yaml'
require 'fileutils'
require_relative '../lib/1hdoc/core/utilities'

RSpec.configure do
  $PROGRAM_NAME = __FILE__

  def expand_path(path)
    File.expand_path(path, File.dirname($PROGRAM_NAME))
  end
end
