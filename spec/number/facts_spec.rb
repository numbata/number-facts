# frozen_string_literal: true

RSpec.describe Number::Facts, :vcr do
  it 'has a version number' do
    expect(described_class::VERSION).not_to be nil
  end

  describe '.fetch' do
    it 'returns fact about the number' do
      expect(described_class.fetch(42))
        .to include(:text, type: :trivia, number: 42, found: true)
    end

    it 'returns fact about random number' do
      expect(described_class.fetch)
        .to include(:text, :number, type: :trivia, found: true)
    end

    it 'returns fact about random number between min and max' do
      expect(described_class.fetch(min: 1, max: 10))
        .to include(:text, :number, type: :trivia, found: true)
    end

    it 'returns fragment fact about the number' do
      expect(described_class.fetch(42, fragment: true))
        .to include(:text, :type, number: 42, found: true)
    end

    it 'returns typed fact about the number' do
      expect(described_class.fetch(42, type: :math))
        .to include(:text, type: :math, number: 42, found: true)
    end

    it 'returns fact about a number with notfound fallback' do
      expect(described_class.fetch(35353, notfound: :floor))
        .to include(:text, type: :trivia, number: 35000, found: true)
    end

    it 'returns default fact about the number with default fallback' do
      expect(described_class.fetch(35353, default: 'foo'))
        .to include(type: :trivia, number: 35000, found: true, text: 'foo')
    end

    it 'raises error with invalid number' do
      expect { described_class.fetch('foo') }
        .to raise_error(StandardError)
    end
  end
end
