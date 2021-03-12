# frozen_string_literal: true

RSpec.describe Number::Facts::Client, :vcr do
  subject(:client) { described_class.new }

  describe '.request' do
    it 'returns fact about the number' do
      result = client.request(number: 42)

      expect(result).to be_success
      expect(result.fact)
        .to include(:text, type: :trivia, number: 42, found: true)
    end

    it 'returns fact about random number' do
      result = client.request

      expect(result).to be_success
      expect(result.fact)
        .to include(:text, :number, type: :trivia, found: true)
    end

    it 'returns fact about random number between min and max' do
      result = client.request(min: 1, max: 10)

      expect(result).to be_success
      expect(result.fact)
        .to include(:text, :number, type: :trivia, found: true)
    end

    it 'returns fragment fact about the number' do
      result = client.request(number: 42, fragment: true)

      expect(result).to be_success
      expect(result.fact)
        .to include(:text, :type, number: 42, found: true)
    end

    it 'returns typed fact about the number' do
      result = client.request(number: 42, type: :math)

      expect(result).to be_success
      expect(result.fact)
        .to include(:text, type: :math, number: 42, found: true)
    end

    it 'returns fact about a number with notfound fallback' do
      result = client.request(number: 35353, notfound: :floor)

      expect(result).to be_success
      expect(result.fact)
        .to include(:text, type: :trivia, number: 35000, found: false)
    end

    it 'returns default fact about the number with default fallback' do
      result = client.request(number: 35353, default: 'foo')

      expect(result).to be_success
      expect(result.fact)
        .to include(type: :trivia, number: 35353, found: false, text: 'foo')
    end

    it 'return facts about the date' do
      result = client.request(number: '1/15', type: :date)

      expect(result).to be_success
      expect(result.fact)
        .to include(:year, :text, number: 15, type: :date, found: true)
    end

    it 'return facts about the year' do
      result = client.request(number: 2010, type: :year)

      expect(result).to be_success
      expect(result.fact)
        .to include(:text, :date, number: 2010, type: :year, found: true)
    end

    it 'raises error with invalid number' do
      expect(client.request(number: 'foo'))
        .to be_failure
    end
  end
end
