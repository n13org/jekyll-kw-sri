# frozen_string_literal: true

module Jekyll
    module KargWare
        module Integrity
            # jekyll-kw-sri configuration class
            class Configuration
                attr_accessor :hashType, :write_sourceMappingURL, :create_tmpfile
  
                DEFAULT_CONFIG = {
                    'hashType' => 'sha384',
                    'writeSourceMappingURL' => true,
                    'createTmpfile' => false
                }.freeze
  
                def initialize(options)
                    options = generate_option_hash(options)
            
                    @hashType = options['hashType']
                    @write_sourceMappingURL = options['writeSourceMappingURL']
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