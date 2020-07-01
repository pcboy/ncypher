[![Code Climate](https://codeclimate.com/github/pcboy/ncypher/badges/gpa.svg)](https://codeclimate.com/github/pcboy/ncypher)
[![Build Status](https://travis-ci.org/pcboy/ncypher.svg)](https://travis-ci.org/pcboy/ncypher)

# Ncypher

Ncypher is a gem to help you to encrypt your credentials in your projects in a safe manner.

## Upgrade from versions before 1.0
Versions before 1.0 were using rbnacl-libsodium gem which is now deprecated.  
The big difference is that now you need to have libsodium installed on your host system.  
That also means faster gem installation. =)  
Check https://github.com/RubyCrypto/rbnacl/wiki/Installing-libsodium for more info.  
Note: You need Argon2 support. So libsodium >= v1.0.15


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ncypher'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ncypher

## Basic Usage

First generate a new encryption key. Typically this key needs to be in your .gitignore.
You don't want it to be pushed to the repository. This file will be used by ncypher each time you need to encrypt/decrypt something. You need to call it `.ncypher_key` and put it in the current folder or any other folder before. (i.e ~/.ncypher_key is fine for instance).
```
$> ncypher generate_key > .ncypher_key
```
You can also set the env variable `NCYPHER_KEY` to that generated key (i.e `export NCYPHER_KEY=kSzARCAw9uv/LQ1o75k5ica1oCpZBUCpP99Sy+s6L2c=`) instead of saving it to a file 

To encrypt a new password (or anything else), ncypher supports stdin. So you can do:
```
$> ncypher encrypt < secret_file > secret_file.encrypted
$> ncypher decrypt < secret_file.encrypted > secret_file
$> ncypher encrypt
mypassword
<CTRL+D>
TAmmvlinPFBmH9bx+IW9L5lKkRdgv3Yv3P4kyyIs0uTTyiTunG7vZ+DNVHMJiuviHOHg
```
I highly recommend you to always use that method! As passing the password as parameter will keep it in your shell history (unless you have HISTFILE=/dev/null).

If you want to do it by passing the pass as parameter:

```
$> ncypher encrypt 'p4$$w0rd'
deB7ba27qR470UetK/HW47dYMN7p9hguuDiVt59U+Bly6cfQcjgbw/ui/2hBhCEa
```

Note, you can also use the decrypt parameter in the ncypher binary to do the decryption:
```
$> ncypher decrypt deB7ba27qR470UetK/HW47dYMN7p9hguuDiVt59U+Bly6cfQcjgbw/ui/2hBhCEa 
p4$$w0rd 
```
So in the end:
```
$> ncypher decrypt `ncypher encrypt 'p4$$w0rd'`
p4$$w0rd
```

:)

And if you are using ruby, Ncypher::Ncypher.decrypt will magically use your key in `.ncypher_key` to decrypt that password at runtime. 
Now you can directy put in your .yaml files:
```
defaults: &defaults
  my_password: <%= Ncypher::Ncypher.decrypt('lXEwfKv4dEjmK0kojEAnikNsLCsVCtSMiR2aSfM6uUXYn2DzCZ3O7SA9HaGnMp/kEEsI') %>
```

## Password derived secret key

In some cases you may want to derive a key from a particular password you have memorized. You can simply do:

```
$> ncypher derive_key p4$$w0rd
R9RgHcFnuHr+86/7v3MdDyu3V63jh69VCPMXknA2v6E=
SALT: 4+d4JTGTxRbtXs1vYScBYg==
```

You can see that the salt is randomly generated for security reasons. You should put that salt in a `.ncypher_salt` file in the current directory (this file can be pushed to your repository). So that the next time you do `ncypher derive_key p4$$w0rd` you get the exact same ncyper\_key generated.  
Note that the salt is written on STDERR so you can directly do:

```
$> ncypher derive_key p4$$w0rd > .ncypher_key
SALT: WKCAkJcS65nx3lA/w1BmBw==
```

Then you have the ncypher\_key in .ncypher\_key. Be sure to save the salt if you want to be able to derive back the exact same key in the future.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pcboy/ncypher. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

