# frozen_string_literal: true

describe RuboBot::CliOptions do
  describe '#[]' do
    it 'returns the value for a flag' do
      expect(described_class.new(%w(--verbose))[:verbose]).to eq(true)
    end

    it 'returns the value for a short flag' do
      expect(described_class.new(%w(-v))[:version]).to eq(true)
    end

    it 'extracts the arguments as paths' do
      expect(described_class.new(%w(/some/path))[:paths]).to eq(%w(/some/path))
    end
  end
end
