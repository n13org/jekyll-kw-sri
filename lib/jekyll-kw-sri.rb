# frozen_string_literal: true

require 'jekyll-kw-sri/configuration'
require 'jekyll-kw-sri/parser'

require 'jekyll'

module Jekyll
  module KargWare
    # jekyll-kw-sri custom tag
    class SriScssHashTag < Jekyll::Tags::IncludeRelativeTag
      # class SriScssHashTag < Liquid::Tag

      alias super_render render

      def initialize(tag_name, input, tokens)
        super

        raise 'Please enter a file path' if input.length <= 0

        # File.exists? is file?

        @tag_name = tag_name

        # puts syntax_example
      end

      # def syntax_example
      #     "{% #{@tag_name} css/main.scss %}"
      # end

      def render(context)
        cache_compiled_scss(@file, context, lambda {
          if context.nil? || context.registers[:site].nil?
            puts 'WARNING: There was no context, generate default site and context'
            site = Jekyll::Site.new(Jekyll::Configuration::DEFAULTS)
            context = Liquid::Context.new({}, {}, { site: site })
          else
            site = context.registers[:site]
            # Read the global configuration
            @sri_config = context.registers[:site].config['kw-sri'] || {}
          end

          converter = site.find_converter_instance(Jekyll::Converters::Scss)

          # var scss = render(context)
          result = super_render(context) # super(context)
          scss = result.gsub(/^---.*---/m, '')
          data = converter.convert(scss)

          file = render_variable(context) || @file
          validate_file_name(file)
          path = locate_include_file(context, file, site.safe)

          Integrity::Parser.new(@sri_config).calc_integrity(path, data)
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
    end
  end
end

Liquid::Template.register_tag('sri_scss_hash', Jekyll::KargWare::SriScssHashTag)
