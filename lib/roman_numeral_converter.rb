# frozen_string_literal: true

require_relative '../utils/roman_dictionary'

class RomanNumeralConverter
  include RomanDictionary

  class Error < StandardError; end
  class NonIntegerError < Error; end
  class OutOfRangeError < Error; end

  attr_reader :number

  def initialize(number)
    @number = number
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
    raise NonIntegerError, "number must be an Integer" unless number.is_a?(Integer)
    raise OutOfRangeError,  "number must be between #{MIN} and #{MAX}" unless in_roman_range?(number)
  end
end
