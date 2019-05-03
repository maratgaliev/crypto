require 'test_helper'

class EncryptedStringTest < ActiveSupport::TestCase
  test 'should validate value' do
    str = EncryptedString.new
    assert_not str.save
  end

  test 'should use primary key' do
    str = EncryptedString.create(value: 'test')
    assert_equal true, str.data_encrypting_key.primary
  end
end
