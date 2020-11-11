# frozen_string_literal: true

require 'jekyll-kw-sri/configuration'
require 'jekyll-kw-sri/parser'

require 'jekyll'

module Jekyll
  module KargWare
    # jekyll-kw-sri custom tag
    class SriScssHashTag < Jekyll::Tags::IncludeRelativeTag
      # class SriScssHashTag < Liquid::Tag
      def initialize(tag_name, input, tokens)
        super

        raise 'Please enter a file path' if input.length <= 0

        @scss_file = strip_or_self(input)
        # File.exists? is file?

        @tag_name = tag_name
      end

      # def syntax_example
      #     "{% #{@tag_name} css/main.scss %}"
      # end

      def render(context)
        # return '' unless context.registers[:page]['sri']

        # # Read the global configuration
        # @sri_config = context.registers[:site].config['kw-sri'] || {}

        cache_compiled_scss(@file, context, lambda {
          site = context.registers[:site]

          converter = site.find_converter_instance(Jekyll::Converters::Scss)
          # converter = if defined? site.find_converter_instance
          #               site.find_converter_instance(Jekyll::Converters::Scss)
          #             else
          #               site.getConverterImpl(::Jekyll::Converters::Scss)
          #             end

          result = super(context)
          scss = result.gsub(/^---.*---/m, '')
          data = converter.convert(scss)

          ## Debuging
          # File.open("." + @scss_file + ".tmp", 'w') { |file| file.write(data) }

          Integrity::Parser.new(@sri_config).calc_integrity(@scss_file, data)
        })
      end

      def cache_compiled_scss(path, _context, compute)
        # @@cached_scss ||= {}
        # if @@cached_scss.key?(path)
        #   @@cached_scss[path]
        # else
        #   @@cached_scss[path] = compute.call
        # end

        @cached_scss ||= {}
        if @cached_scss.key?(path)
          @cached_scss[path]
        else
          @cached_scss[path] = compute.call
        end
      end

      # https://stackoverflow.com/a/1000975
      def strip_or_self(str)
        str.strip! || str
      end

      def tag_includes_dirs(context)
        [context.registers[:site].source].freeze
      end
    end
  end
end

Liquid::Template.register_tag('sri_scss_hash', Jekyll::KargWare::SriScssHashTag)
