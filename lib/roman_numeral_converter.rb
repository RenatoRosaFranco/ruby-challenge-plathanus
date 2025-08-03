# frozen_string_literal: true

require_relative '../utils/roman_dictionary'

class RomanNumeralConverter
  include RomanDictionary

  class Error < StandardError; end
  class NonIntegerError < Error; end
  class OutOfRangeError < Error; end

  attr_reader :number, :min, :max

  def initialize(number, min: RomanDictionary::MIN, max: RomanDictionary::MAX)
    @number, @min, @max = number, min, max
    validate!
  end

  def to_roman
    n = number
    result = +""

    ROMAN_TABLE.each do |value, symbol|
      break if n.zero?
      q, n = n.divmod(value)
      result << symbol * q
    end

    result
  end

  private

  def validate!
    raise NonIntegerError, "expected Integer, got #{number.class}" unless number.is_a?(Integer)
    raise OutOfRangeError, "expected #{min}..#{max} got #{number}" unless (min..max).cover?(number)
  end
end
