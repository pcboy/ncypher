# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ncipher/version'

Gem::Specification.new do |spec|
  spec.name          = "ncipher"
  spec.version       = Ncipher::VERSION
  spec.authors       = ["David Hagege"]
  spec.email         = ["david.hagege@gmail.com"]

  spec.summary       = %q{Ncipher lets you encrypt/decrypt credentials in a safe and transparent way}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/pcboy/ncipher"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.license       = 'WTFPL'

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_dependency 'rbnacl-libsodium', '~> 1.0.10'
  spec.add_dependency 'rbnacl', '~> 3.0.1'
end
