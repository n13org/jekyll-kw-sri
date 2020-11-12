# frozen_string_literal: true

require 'fileutils'
require 'jekyll'
require 'jekyll-sass-converter'

module Jekyll
  module KargWare
    module Integrity
      # jekyll-kw-sri converter class, bassed on the scss-converter
      class Converter < Jekyll::Converters::Scss
        def nico
          sass_dir
        end

        def convert_extended
          convert('Nico')
        end
      end
    end
  end
end
