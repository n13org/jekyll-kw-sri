# frozen_string_literal: true

require 'test_helper'
require 'jekyll-kw-sri/configuration'
require 'jekyll-kw-sri/converter'
require 'jekyll-kw-sri/parser'

# require 'spec_helper'

module Jekyll
  module KargWare
    module Integrity
      # Test the Liquid-Tag-Converter
      class TestConverter < Minitest::Test
        def test_default_converter
          converter = Jekyll::KargWare::Integrity::Converter.new

          assert_equal '_sass', converter.nico
        end

        # def test_convert
        #   converter = Jekyll::KargWare::Integrity::Converter.new

        #   content = <<~SCSS
        #     $font-stack: Helvetica, sans-serif;
        #     body {
        #       font-family: $font-stack;
        #       font-color: fuschia;
        #     }
        #   SCSS

        #   assert_equal '_sass', converter.convert(content)
        # end
      end
    end
  end
end
