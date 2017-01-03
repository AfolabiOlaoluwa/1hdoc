module HDOC
  ##
  # Implements methods and constants used by many independents classes.
  module Utilities
    ##
    # Load log from a YAML file.
    def parse_file(path, file_parser)
      raise Errno::ENOENT, "Unable to find #{path}" unless File.exist?(path)
      file_parser.load_file(path) || {}
    end

    ##
    # Transform symbol's keys in string ones.
    def stringify_symbols(hash_object)
      hash_object.keys.each do |key|
        next unless key.is_a?(Symbol)
        hash_object[key.to_s] = hash_object.delete(key)
      end

      hash_object
    end

    def expand_path(path)
      File.expand_path(path, File.dirname($PROGRAM_NAME))
    end
  end
end
