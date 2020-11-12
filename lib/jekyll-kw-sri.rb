# frozen_string_literal: true

require 'jekyll-kw-sri/configuration'
require 'jekyll-kw-sri/parser'

require 'jekyll'

module Jekyll
  module KargWare
    # jekyll-kw-sri custom tag
    class SriScssHashTag < Jekyll::Tags::IncludeRelativeTag
      def initialize(tag_name, input, tokens)
        super

        raise 'Please enter a file path' if input.length <= 0
        # File.exists? is file?
      end

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

          # Render the context with the base-class
          converter = site.find_converter_instance(Jekyll::Converters::Scss)
          result = super(context) # super_render(context)
          scss = result.gsub(/^---.*---/m, '')
          data = converter.convert(scss)

          # Get path out of the file object
          file = render_variable(context) || @file
          validate_file_name(file)
          path = locate_include_file(context, file, site.safe)

          # Use default config for kw-sri if it is nil
          @sri_config ||= Jekyll::KargWare::Integrity::Configuration::DEFAULT_CONFIG

          Integrity::Parser.new(@sri_config).calc_integrity(path, data)
        })
      end

      def cache_compiled_scss(path, _context, compute)
        @cached_scss ||= {}
        if @cached_scss.key?(path)
          @cached_scss[path]
        else
          @cached_scss[path] = compute.call
        end
      end

      # Register the sccs file as include folder
      def tag_includes_dirs(context)
        [context.registers[:site].source].freeze
      end
    end
  end
end

Liquid::Template.register_tag('sri_scss_hash', Jekyll::KargWare::SriScssHashTag)
