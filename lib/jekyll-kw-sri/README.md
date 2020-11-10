# jekyll-kw-sri

A plugin for jekyll to calculate integrity hashes for CSS (even SCSS and SASS) and JS files

## Configuration

Add `kw-sri` section to `_config.yml` configure the plugin globally.

```yaml
kw-sri:
  createTmpfile: false
  hash_type: 'sha384'
  write_source_mapping_url: true
```

 Configuration values

| Key                   | Description                                       | Values (**default**)                     |
|-----------------------|---------------------------------------------------|----------------------------|
| createTmpfile         | Debug-Only, save the rendered sass or scss as css | **false**, true            |
| hash_type              | Which kind of integrity hash                      | sha256, **sha384**, sha512 |
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