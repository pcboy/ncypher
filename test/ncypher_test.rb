require 'test_helper'

class NcypherTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ncypher::VERSION
  end

  def test_it_can_encrypt_decrypt
    ENV['NCYPHER_KEY'] = Ncypher::Ncypher.generate_key
    assert_equal(Ncypher::Ncypher.decrypt(Ncypher::Ncypher.encrypt('tartine')), 'tartine')
  end
end
