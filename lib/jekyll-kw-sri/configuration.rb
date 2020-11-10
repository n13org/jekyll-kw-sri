# frozen_string_literal: true

module Jekyll
  module KargWare
    module Integrity
      # jekyll-kw-sri configuration class
      class Configuration
        attr_accessor :hash_type, :write_source_mapping_url, :create_tmpfile

        DEFAULT_CONFIG = {
          'hashType' => 'sha384',
          'writeSourceMappingURL' => true,
          'createTmpfile' => false
        }.freeze

        def initialize(options)
          options = generate_option_hash(options)

          @hash_type = options['hashType']
          @write_source_mapping_url = options['writeSourceMappingURL']
          @create_tmpfile = options['createTmpfile']
        end

        private

        def generate_option_hash(options)
          DEFAULT_CONFIG.merge(options)
        rescue TypeError
          DEFAULT_CONFIG
        end
      end
    end
  end
end
