module HDOC
  ##
  # Implements methods and constants used by many independents classes.
  module Utilities
    ##
    # Load log from a YAML file.
    def retrieve_log(path, file_parser)
      raise Errno::ENOENT, "Unable to load #{@path}" unless File.exist?(path)
      file_parser.load_file(path) || {}
    end

    ##
    # Transform symbol's keys in string ones.
    def stringify_symbols(hash_object)
      keys = hash_object.keys

      0.upto(keys.length) do |pos|
        target_key = keys[pos]

        next unless target_key.is_a?(Symbol)
        hash_object[target_key.to_s] = hash_object.delete(target_key)
      end

      hash_object
    end
  end
end
