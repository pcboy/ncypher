require "encipher/version"

require 'base64'
require 'rbnacl/libsodium'
require 'rbnacl'

module Encipher

  class Encipher

    def initialize(key_filename: '.encipher_key')
      @key_filename = key_filename
    end

    def decrypt(ciphertext_b64)
      box.decrypt(Base64.strict_decode64(ciphertext_b64))
    end

    def encrypt(plaintext)
      Base64.strict_encode64(box.encrypt(plaintext))
    end

    def generate_key
      generated_key = RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes)
      Base64.strict_encode64(generated_key)
    end

    def self.decrypt(cyphertext_b64)
      Encipher.new.decrypt cyphertext_b64
    end

    def self.encrypt(plaintext)
      Encipher.new.encrypt plaintext
    end

    def self.generate_key
      Encipher.new.generate_key
    end

    private
    def box
      RbNaCl::SimpleBox.from_secret_key(key)
    end

    def key
      saved_key = ENV['ENCIPHER_KEY'] || find_keyfile
      abort "Can't find .encipher_key file or ENCIPHER_KEY env variable" if saved_key.nil?
      Base64.decode64(saved_key)
    end

    def find_keyfile(folder: '.')
      path = "#{folder}/#{@key_filename}"
      return File.read(path) if File.exists?(path)
      return nil if folder == '/'
      folder = File.expand_path("#{folder}/../")
      find_keyfile(folder: folder)
    end

  end

end
