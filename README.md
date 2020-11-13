# jekyll-kw-sri

[![Gem Version](https://badge.fury.io/rb/jekyll-kw-sri.svg)](https://badge.fury.io/rb/jekyll-kw-sri)

A plugin for [jekyll][Jekyll Website] to calculate [Subresource Integrity][Wikipedia SRI] (SRI) hashes for CSS (even SCSS and SASS) and JS files during build time.

> **Subresource Integrity** (SRI) is a security feature that enables browsers to verify that resources they fetch (for example, from a CDN) are delivered without unexpected manipulation. It works by allowing you to provide a cryptographic hash that a fetched resource must match.

from [Mozilla docs][Mozilla Subresource Integrity]

## 🔥 Usage 

### Usage for version `>= v0.1.0`

Use the [Jekyll Includes] `kw-integrity-css.html` for css, scss and sass; and the `kw-integrity-js.html` for js. 

> For static, non-rendered `css` files the hash values have to me calculated and stored in a file. See `Action Items / Shell commands` section about SRI! All the hash-files should be stored in `./_includes/integrity` so they can easy used.

The markdown syntax shows the include file with one paramter "the filename". 

```markdown
{% include kw-integrity-css.html file='style.scss' %}
```

The rendered html will use the default path, the css file and the calculated hash.

```html
<link rel="stylesheet" href="/assets/css/style.css" integrity="sha384-cl6CK1yzEvoM3Sw3dL8YAm/P2VpQiD+mAFVkkb6Bh+23PP1ow2gXXGw4WnQlzO0B" crossorigin="anonymous">
```

The markdown syntax shows the include file with all paramters. All parameter can be omit. The **default values** are file = "main.scss", path = "assets/css/" and hash = "sha384".

```markdown
{% include kw-integrity-css.html file='style.scss' path='my/folder/to/css/' hash='sha512' %}
```

### Usage for version `< v0.1.0`

Use the [custom tag][Jekyll Liquid] `sri_scss_hash`. 

> This approach was inspired by [vcsjones.dev Blog] and [vcsjones.dev GitHub].

The `html` inside the post or page markdown file, shows a usage of a `scss` file which will be compiled to a `css`. The hash of the integrity will be generated during the build time. 

```html
<link rel="stylesheet" href="{{ '/assets/css/kargware.css' | relative_url }}" integrity="{% sri_scss_hash /assets/css/kargware.scss %}" crossorigin="anonymous">
```

The result of the html inside the markdown is the `href` and the `integrity`.

```html
<link rel="stylesheet" href="/assets/css/kargware.css" integrity="sha384-cl6CK1yzEvoM3Sw3dL8YAm/P2VpQiD+mAFVkkb6Bh+23PP1ow2gXXGw4WnQlzO0B" crossorigin="anonymous">
```

## Changelog

* 0.0.x Add the custom tag `{% sri_scss_hash %}`
* 0.1.0 Add html include files to use them with  `{% include kw-integrity-css.html %}` or `{% include kw-integrity-js.html %}`

## ⚙️ Configuration

Add `kw-sri` section to `_config.yml` configure the plugin globally. If you want to use defauls you can ommit the config-section.

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

## 🚀 Action Items / Shell commands

Run linting and tests

```sh
bundle exec rubocop
bundle exec rake test
```

Build gem package

```sh
bundle exec rake build
```

Publish gem package

```sh
bundle exec rake release
```

Calc a SRI Integrity hash of `./style.css` in format `sha256`

```shell
openssl dgst -sha256 -binary ./style.css | openssl base64 -A
```

Calc different **SRI integrity** hash-files from `css-files` (same is valid for `js-files`) in format `sha256`, `sha384` and `sha512` inside a **Makefile**

```plain
calc-integrity-files:
	for strength in 256 384 512 ; do \
		cat ./assets/css/style.min.css | openssl dgst -sha$$strength -binary | openssl base64 -A > ./_includes/integrity/style.min.css.sha$$strength ; \
		cat ./assets/css/main.css | openssl dgst -sha$$strength -binary | openssl base64 -A > ./_includes/integrity/main.css.sha$$strength ; \
		cat ./assets/js/script.js | openssl dgst -sha$$strength -binary | openssl base64 -A > ./_includes/integrity/script.js.sha$$strength ; \
	done
```

## 📝 Notes / Hints

### Appraisal - Gemfile Generator

[GitHub](https://github.com/thoughtbot/appraisal)

1. Create a `Appraisals` file
2. Generate `Gemfiles`

```sh
bundle exec appraisal generate
```

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

### Setup Steps

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

## 👋 Big Thanks to my inspiration sources

* `SRI with Jekyll` [vcsjones.dev Blog] and [vcsjones.dev GitHub]
* [GitHub Project jekyll/jekyll]
* [GitHub Project Shopify/liquid]
* `Use jekyll filter scssify` [andreaverlicchi blog scssify]
* [Blog How to create customizable Liquid tags in Jekyll]
* [Ruby Module Digest]

[Jekyll Website]: https://jekyllrb.com/
[Jekyll Liquid]: https://jekyllrb.com/docs/liquid/
[Jekyll Includes]: https://jekyllrb.com/docs/includes/
[Wikipedia SRI]: https://en.wikipedia.org/wiki/Subresource_Integrity
[Mozilla Subresource Integrity]: https://developer.mozilla.org/en-US/docs/Web/Security/Subresource_Integrity
[vcsjones.dev GitHub]: https://github.com/vcsjones/vcsjones.dev/tree/main
[vcsjones.dev Blog]: https://vcsjones.dev/2016/11/02/sri-with-jekyll/
[GitHub Project jekyll/jekyll]: https://github.com/jekyll/jekyll
[GitHub Project Shopify/liquid]: https://github.com/Shopify/liquid
[andreaverlicchi blog scssify]: https://www.andreaverlicchi.eu/critical-css-jekyll-sass-github-pages/
[Ruby Module Digest]: https://ruby-doc.com/stdlib/libdoc/digest/rdoc/Digest.html
[Blog How to create customizable Liquid tags in Jekyll]: https://blog.sverrirs.com/2016/04/custom-jekyll-tags.html