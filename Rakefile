require 'rake'
require 'rspec'

task :tests do
  Dir['spec/*_spec.rb'].each { |test| sh "rspec #{test}" }
end

task :default => :tests

