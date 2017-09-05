require "ncypher/version"

require 'base64'
require 'rbnacl/libsodium'
require 'rbnacl'

module Ncypher

  class Ncypher

    def initialize(key_filename: '.ncypher_key', key: nil)
      @key = key ? Base64.strict_decode64(key.strip) : nil
      @key_filename = key_filename
    end

    def decrypt(ciphertext_b64)
      box.decrypt(Base64.strict_decode64(ciphertext_b64.strip))
    end

    def encrypt(plaintext)
      Base64.strict_encode64(box.encrypt(plaintext))
    end

    def generate_key
      generated_key = RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes)
      Base64.strict_encode64(generated_key)
    end

    def key
      @key ||= begin
                 saved_key = ENV['NCYPHER_KEY'] || find_keyfile
                 abort "Can't find .ncypher_key file or NCYPHER_KEY env variable" if saved_key.nil?
                 Base64.strict_decode64(saved_key.strip)
               end
    end

    def key_b64
      Base64.strict_encode64 key
    end

    def self.decrypt(cyphertext_b64)
      Ncypher.new.decrypt cyphertext_b64
    end

    def self.encrypt(plaintext)
      Ncypher.new.encrypt plaintext
    end

    def self.generate_key
      Ncypher.new.generate_key
    end

    def self.key
      Ncypher.new.key
    end

    def self.key_b64
      Ncypher.new.key_b64
    end

    private
    def box
      RbNaCl::SimpleBox.from_secret_key(key)
    end

    def find_keyfile(folder: '.')
      path = "#{folder}/#{@key_filename}"
      return File.read(path) if File.exist?(path)
      return nil if folder == '/'
      folder = File.expand_path("#{folder}/../")
      find_keyfile(folder: folder)
    end

  end

end
