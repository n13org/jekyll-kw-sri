# jekyll-kw-sri

[![Gem Version](https://badge.fury.io/rb/jekyll-kw-sri.svg)](https://badge.fury.io/rb/jekyll-kw-sri)

A plugin for jekyll to calculate [Subresource Integrity][Wikipedia SRI] (SRI) hashes for CSS (even SCSS and SASS) and JS files during build time.

> **Subresource Integrity** (SRI) is a security feature that enables browsers to verify that resources they fetch (for example, from a CDN) are delivered without unexpected manipulation. It works by allowing you to provide a cryptographic hash that a fetched resource must match.

from [Mozilla docs][Mozilla Subresource Integrity]

## Configuration

Add `kw-sri` section to `_config.yml` configure the plugin globally.

```yaml
kw-sri:
  createTmpfile: false
  hash_type: 'sha384'
  write_source_mapping_url: true
```

 Configuration values

| Key                      | Description                                       | Values (**default**)       |
|--------------------------|---------------------------------------------------|----------------------------|
| createTmpfile            | Debug-Only, save the rendered sass or scss as css | **false**, true            |
| hash_type                | Which kind of integrity hash                      | sha256, **sha384**, sha512 |
| write_source_mapping_url | Add the map-file like to the css                  | false, **true**            |              

Add `sri: true` to **Front Matter** of  `<page>` or `<post>` to activate the sri plugin.

## Build gem

## Publish gem

## Run tests

```sh
bundle exec rake test
```

### Appraisal - Gemfile Generator

[GitHub](https://github.com/thoughtbot/appraisal)

1. Create a `Appraisals` file
2. Generate `Gemfiles`

```sh
bundle exec appraisal generate
```

## Notes / Hints

### Site context is empty

Inside the `render(context)` function of a `Liquid::Tag` there is a context object. With that context you can get the `site` object, anyhow when you want to cretae your temporry **site** and **context** you need a workaround.

Normal way to get the site object from the render function of a custom tag

```ruby
site = context.registers[:site]
```

Create a temporary site and context of a **jekyll** environment

```ruby
site = Jekyll::Site.new(Jekyll::Configuration::DEFAULTS)
context = Liquid::Context.new({}, {}, { site: site })
```         

### Base class for custom tag
Use `Jekyll::Tags::IncludeRelativeTag` instead of `Liquid::Tag` as base class of the custom jekyll tag `SriScssHashTag` will help to read the content of the scss or sass files.

### Find Scss converter

Sometimes, especially during testing, the site object is not perfectly setup. So the function `find_converter_instance` will throw an error. 

**Default** implementation to find the converter.

```ruby
converter = site.find_converter_instance(Jekyll::Converters::Scss)
```

**Workaround** implementation to find the converter.

```ruby
converter = if defined? site.find_converter_instance
              site.find_converter_instance(Jekyll::Converters::Scss)
            else
              site.getConverterImpl(::Jekyll::Converters::Scss)
            end
```

## SRI Integrity

```shell
openssl dgst -sha256 -binary ./style.css | openssl base64 -A
```

## Setup Steps

```sh
bundle init
bundle add rake
bundle add simplecov
bundle add minitest
bundle add minitest-reporters
bundle add minitest-profile
bundle add rspec-mocks
bundle add rdiscount
bundle add redcarpet
bundle add shoulda
```

[Wikipedia SRI]: https://en.wikipedia.org/wiki/Subresource_Integrity
[Mozilla Subresource Integrity]: https://developer.mozilla.org/en-US/docs/Web/Security/Subresource_Integrity