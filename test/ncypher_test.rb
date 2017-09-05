require 'test_helper'

class NcypherTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ncypher::VERSION
  end

  def test_it_can_encrypt_decrypt_with_specific_key
    key = Ncypher::Ncypher.generate_key
    encryptor = Ncypher::Ncypher.new(key: key)
    assert_equal(encryptor.decrypt(encryptor.encrypt('test')), 'test')
  end

  def test_it_can_encrypt_decrypt
    ENV['NCYPHER_KEY'] = Ncypher::Ncypher.generate_key
    assert_equal(Ncypher::Ncypher.decrypt(Ncypher::Ncypher.encrypt('tartine')), 'tartine')
  end
end
