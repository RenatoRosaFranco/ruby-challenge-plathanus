# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/roman_numeral_converter'

RSpec.describe RomanNumeralConverter, type: :class do
  describe 'validation' do
    context 'when number is not an Integer'do
      let(:error) { described_class::NonIntegerError }

      [3.14, "10", nil, true].each do |value|
        it "raises NonIntegerError for #{value.inspect}" do
          expect { described_class.new(value) }.to raise_error(error)
        end
      end
    end

    context 'when number is out of range' do
      let(:error) { described_class::OutOfRangeError }

      [0, -1, 4000].each do |value|
        it "raises OutOfRange for #{value}" do
          expect { described_class.new(value) }.to raise_error(error)
        end
      end
    end
  end

  describe '#to_roman' do
    subject(:roman) { described_class.new(input).to_roman }
  
    context 'with basic numerals' do
      dictionary = {
        1 => "I", 5 => "V", 10 => "X", 50 => "L",
        100 => "C", 500 => "D", 1000 => "M"
      }.freeze

      dictionary.each do |n, r|
        context "when input is #{n}" do
          let(:input) { n }
          it { is_expected.to eq(r) }
        end
      end
    end

    context 'with subtractive notation' do
      dictionary = {
        4 => "IV", 9 => "IX", 40 => "XL",
        90 => "XC", 400 => "CD", 900 => "CM"
      }.freeze

      dictionary.each do |n, r|
        context "when the input is #{n}" do
          let(:input) { n }
          it { is_expected.to eq(r) }
        end
      end
    end

    context 'with representative cases' do
      dictionary = {
        2 => "II", 3 => "III", 8 => "VIII", 14 => "XIV", 19 => "XIX", 29 => "XXIX",
        44=>"XLIV", 49=>"XLIX", 58=>"LVIII", 93=>"XCIII", 141=>"CXLI",
        242=>"CCXLII", 294=>"CCXCIV", 402=>"CDII", 944=>"CMXLIV",
        1453=>"MCDLIII", 1994=>"MCMXCIV", 2024=>"MMXXIV",
        3210=>"MMMCCX", 3888=>"MMMDCCCLXXXVIII", 3999=>"MMMCMXCIX"
      }.freeze

      dictionary.each do |n, r|
        context "when input is #{n}" do
          let(:input) { n }
          it { is_expected.to eq(r) }
        end
      end
    end

    context 'shape constraints' do
      let(:valid_chars) { /\A[IVXLCDM]+\z/ }
      let(:invalid_subtractive) { /(IL|IC|ID|IM|XD|XM|VC|VL|VX|LC|LD|LM|DM)/i }
      
      let(:samples) do
        [
         1, 3, 4, 9, 19, 40, 49, 58, 93, 141, 294, 
         402, 944, 1994, 2421, 3210, 3888, 3999
        ]
      end

      it 'produces only valid characters' do
        samples.each do |number|
          expect(described_class.new(number).to_roman).to match(valid_chars)
        end
      end

      it 'never repeats V, L, D; and never repeats I/X/C/M more than 3 times' do
        samples.each do |number|
          r = described_class.new(number).to_roman
          %w[I X C M].each { |ch| expect(r).not_to match(/#{ch}{4}/) }
          %w[V L D].each { |ch| expect(r).not_to match(/#{ch}{2}/) }
        end
      end

      it 'uses only valid subtractive pairs' do
        samples.each do |number|
          expect(described_class.new(number).to_roman).not_to match(invalid_subtractive)
        end
      end
    end

    context 'bounds' do
      context 'when input is 1' do
        let(:result) { "I" }
        let(:input) { 1 }

        it { is_expected.to eq(result) }
      end
      
      context 'when input is 3999' do
        let(:result) { "MMMCMXCIX" }
        let(:input) { 3999 }

        it { is_expected.to eq(result) }
      end
    end

    context 'immutability' do
      it 'does not mutate the stored number' do
        converter =  described_class.new(944)
        expect { converter.to_roman }.not_to change { converter.number }
      end
    end
  end
end
