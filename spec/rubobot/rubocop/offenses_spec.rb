# frozen_string_literal: true

describe RuboBot::RuboCop::Offenses do
  describe '#next' do
    subject { described_class.new(data) }

    let(:data) { { 'Some/Offense' => 400, 'Another/BadOffense' => 200 } }

    it 'returns the offense with the lowest count' do
      expected = RuboBot::RuboCop::Offense.new('Another/BadOffense' => 200)
      expect(subject.next).to eq(expected)
    end

    it 'returns offenses consecutively' do
      expected = RuboBot::RuboCop::Offense.new('Some/Offense' => 400)
      subject.next
      expect(subject.next).to eq(expected)
    end

    it 'raises an error if there are no more offenses' do
      subject.next
      subject.next
      expect { subject.next }.to raise_error(RuboBot::RuboCop::NoOffensesError)
    end
  end

  describe '#size' do
    subject { described_class.new(data).size }
    let(:data) { { 'Some/Offense' => 400, 'Another/BadOffense' => 200 } }
    it { is_expected.to eq(2) }
  end

  describe '#==' do
    let(:data_a) { { 'Some/Offense' => 123, 'Another/BadOffense' => 456 } }
    let(:data_b) { { 'Some/Offense' => 321, 'Foo/BarOffense' => 4 } }

    it 'is equal if the data is the same' do
      expect(described_class.new(data_a)).to eq(described_class.new(data_a))
    end

    it 'is not equal if the data is different' do
      expect(described_class.new(data_a)).not_to eq(described_class.new(data_b))
    end
  end
end
