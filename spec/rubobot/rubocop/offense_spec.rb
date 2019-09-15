# frozen_string_literal: true

describe RuboBot::RuboCop::Offense do
  describe '#name' do
    subject { described_class.new('Some/Offense' => 21).name }
    it { is_expected.to eq('Some/Offense') }
  end

  describe '#count' do
    subject { described_class.new('Some/Offense' => 21).count }
    it { is_expected.to eq(21) }
  end

  describe '#==' do
    let(:data_a) { { 'Some/Offense' => 123 } }
    let(:data_b) { { 'Another/Offense' => 321 } }

    it 'is equal if the data is the same' do
      expect(described_class.new(data_a)).to eq(described_class.new(data_a))
    end

    it 'is not equal if the data is different' do
      expect(described_class.new(data_a)).not_to eq(described_class.new(data_b))
    end
  end
end
