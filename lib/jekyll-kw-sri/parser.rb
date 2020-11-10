# frozen_string_literal: true

require 'digest'

module Jekyll
    module KargWare
        module Integrity
            # jekyll-kw-sri parser class
            class Parser
                attr_accessor :configuration

                def initialize(options = {})
                    @configuration = Configuration.new(options)
                end

                def calc_integrity(filename, data)
                    hashType = @configuration.hashType

                    data = add_sourceMappingURL(filename)

                    case hashType
                    when 'sha256'
                        "sha256-#{Digest::SHA256.base64digest data}"
                    when 'sha384'
                        "sha384-#{Digest::SHA384.base64digest data}"
                    when 'sha512'
                        "sha512-#{Digest::SHA512.base64digest data}"
                    else
                        raise Gem::InvalidHashTypeException, "The type of the hash '#{hashType}' is invalid!'"
                    end
                end

                def add_sourceMappingURL(filename)
                    if (@configuration.write_sourceMappingURL) 
                        base = File.basename(filename)
                        base = base.sub! 'scss', 'css'
        
                        "\n/*# sourceMappingURL=" + base + ".map */"
                    else 
                        ""
                    end
                end
            end

            class Gem::InvalidHashTypeException < Gem::Exception; end
        end
    end
end