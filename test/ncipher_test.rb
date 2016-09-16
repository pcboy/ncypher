require 'test_helper'

class NcipherTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ncipher::VERSION
  end

  def test_it_can_encrypt_decrypt
    ENV['NCIPHER_KEY'] = Ncipher::Ncipher.generate_key
    assert_equal(Ncipher::Ncipher.decrypt(Ncipher::Ncipher.encrypt('tartine')), 'tartine')
  end
end
