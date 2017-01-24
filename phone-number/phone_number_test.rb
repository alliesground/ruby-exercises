require 'minitest/autorun'
require_relative 'phone_number'

class PhoneNumberTest < MiniTest::Unit::TestCase
  def setup; end

  def test_cleans_number
    p_number = PhoneNumber.new('(123) 456-7890')
    assert_equal('1234567890', p_number.number)
  end

  def test_non_numeric_phone_number
    p_number = PhoneNumber.new('a123c23345')
    assert_equal(nil, p_number.numeric?)
  end

  def test_valid_phone_number
    p_number = PhoneNumber.new('1234567890')
    assert_equal(true, p_number.valid?)
  end

  def test_11_digit_phone_number_with_first_digit_1
    p_number = PhoneNumber.new('11234567890')
    assert_equal(true, p_number.valid_11_digits?)
  end

  def test_11_digit_phone_number_with_first_digit_not_1
    p_number = PhoneNumber.new('21234567890')
    assert_equal(nil, p_number.valid_11_digits?)
  end

  def test_number_greater_than_11_digits
    p_number = PhoneNumber.new('121234567890')
    assert_equal(nil, p_number > 11)
  end

  def test_number_less_than_10_digits
    p_number = PhoneNumber.new('123456789')
    assert_equal(nil, p_number < 10)
  end
end
