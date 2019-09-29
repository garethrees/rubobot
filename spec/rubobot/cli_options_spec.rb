# frozen_string_literal: true

describe RuboBot::CliOptions do
  describe '#[]' do
    it 'returns the value for a flag' do
      expect(described_class.new(%w[--verbose])[:verbose]).to eq(true)
    end

    it 'returns the value for a short flag' do
      expect(described_class.new(%w[-v])[:version]).to eq(true)
    end

    it 'extracts the first path' do
      expect(described_class.new(%w[/some/path /another/path])[:path]).
        to eq('/some/path')
    end
  end

  describe '#to_hash' do
    it 'returns the given arguments parsed into a hash' do
      args = %w[-v --verbose /some/path]
      expected = { version: true, verbose: true, path: '/some/path' }
      expect(described_class.new(args).to_hash).to eq(expected)
    end
  end
end
