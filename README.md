[![Code Climate](https://codeclimate.com/github/pcboy/encipher/badges/gpa.svg)](https://codeclimate.com/github/pcboy/encipher)
[![Build Status](https://travis-ci.org/pcboy/encipher.svg)](https://travis-ci.org/pcboy/encipher)

# EnCipher

EnCipher is a gem to help you to encrypt your credentials in your ruby apps in a safe manner.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'encipher'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install encipher

## Basic Usage

First generate a new encryption key. Typically this key needs to be in your .gitignore.
You don't want it to be pushed to the repository. This file will be used by encipher each time you need to encrypt/decrypt something.
```
$> encipher generate_key > .encipher_key
```
You can also set the env variable `ENCIPHER_KEY` to that generated key (i.e `export ENCIPHER_KEY=kSzARCAw9uv/LQ1o75k5ica1oCpZBUCpP99Sy+s6L2c=`) instead of saving it to a file 

To encrypt a new password (or anything else):
```
$> encipher encrypt 'p4$$w0rd'
deB7ba27qR470UetK/HW47dYMN7p9hguuDiVt59U+Bly6cfQcjgbw/ui/2hBhCEa
```

Now you can directy put in your .yaml files:
```
defaults: &defaults
  my_password: <%= Encipher::Encipher.decrypt('lXEwfKv4dEjmK0kojEAnikNsLCsVCtSMiR2aSfM6uUXYn2DzCZ3O7SA9HaGnMp/kEEsI') %>
```

And Encipher::Encipher.decrypt will magically use your key in `.encipher_key` to decrypt that password at runtime. 
Note, you can also use the decrypt parameter in the encipher binary to do the decryption:
```
$> encipher decrypt deB7ba27qR470UetK/HW47dYMN7p9hguuDiVt59U+Bly6cfQcjgbw/ui/2hBhCEa 
p4$$w0rd 
```
So in the end:
```
$> encipher decrypt `encipher encrypt 'p4$$w0rd'`
p4$$w0rd
```

:)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pcboy/encipher. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

