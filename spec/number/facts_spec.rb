# frozen_string_literal: true

RSpec.describe Number::Facts, :vcr do
  describe '.request' do
    it 'returns fact about the number' do
      result = described_class.request(number: 42)

      require 'pry'
      binding.pry

      expect(result).to be_success
      expect(result.fact)
        .to include(:text, type: :trivia, number: 42, found: true)
    end
  end
end
