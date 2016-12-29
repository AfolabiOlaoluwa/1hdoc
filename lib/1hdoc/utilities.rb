module HDOC
  ##
  # Implements methods and constants used by many independents classes.
  module Utilities
    LogNotFound = Class.new(RuntimeError)
    DayNotFound = Class.new(RuntimeError)

    ##
    # Load log from a YAML file.
    def retrieve_log(path, file_parser)
      raise LogNotFound, "Unable to find #{@path}" unless File.exist?(path)
      file_parser.load_file(path) || {}
    end

    ##
    # Transform symbol's keys in string ones.
    def stringify_symbols(hash_object)
      keys = hash_object.keys

      0.upto(keys.length) do |pos|
        next unless keys[pos].is_a?(Symbol)
        hash_object[keys[pos].to_s] = hash_object.delete(keys[pos])
      end

      hash_object
    end
  end
end
