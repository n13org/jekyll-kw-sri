# frozen_string_literal: true

require 'digest'

module Jekyll
  module KargWare
    module Integrity
      # jekyll-kw-sri parser class
      class Parser
        attr_reader :configuration

        def initialize(options = {})
          @configuration = Configuration.new(options)
        end

        def calc_integrity(filename, data)
          hash_type = @configuration.hash_type

          data_modified = add_source_mapping_url(filename, data)

          # Debuging, save rendered css file as tmp file
          File.open(".#{filename}.tmp", 'w') { |file| file.write(data_modified) } if @configuration.create_tmpfile

          case hash_type
          when 'sha256'
            "sha256-#{Digest::SHA256.base64digest data_modified}"
          when 'sha384'
            "sha384-#{Digest::SHA384.base64digest data_modified}"
          when 'sha512'
            "sha512-#{Digest::SHA512.base64digest data_modified}"
          else
            raise Jekyll::KargWare::Integrity::InvalidHashTypeException, "The type of the hash '#{hash_type}' is invalid!'"
          end
        end

        def add_source_mapping_url(filename, data)
          if @configuration.write_source_mapping_url
            base = File.basename(filename)
            base = base.sub! 'scss', 'css'

            data + "\n/*# sourceMappingURL=#{base}.map */"
          else
            data
          end
        end
      end

      class InvalidHashTypeException < Gem::Exception; end
    end
  end
end
