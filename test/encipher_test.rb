require 'test_helper'

class EncipherTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Encipher::VERSION
  end

  def test_it_can_encrypt_decrypt
    ENV['ENCIPHER_KEY'] = Encipher::Encipher.generate_key
    assert_equal(Encipher::Encipher.decrypt(Encipher::Encipher.encrypt('tartine')), 'tartine')
  end
end
