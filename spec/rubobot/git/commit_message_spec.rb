# frozen_string_literal: true

describe RuboBot::Git::CommitMessage do
  subject { described_class.new(cop, command, stdout) }

  let(:cop) { 'Some/Cop' }
  let(:command) { 'rubocop -a --only Some/Cop /tmp' }
  let(:stdout) { 'Foo Bar Baz' }

  describe '#subject' do
    it 'returns the commit message subject' do
      expect(subject.subject).to eq('Auto-correct Some/Cop')
    end
  end

  describe '#body' do
    it 'returns the commit message body' do
      expect(subject.body).to eq(<<~MSG)
        rubocop -a --only Some/Cop /tmp

        Foo Bar Baz
      MSG
    end
  end

  describe '#to_s' do
    let(:msg) do
      <<~MSG
        Auto-correct Some/Cop

        rubocop -a --only Some/Cop /tmp

        Foo Bar Baz
      MSG
    end

    it 'returns a formatted commit message' do
      expect(subject.to_s).to eq(msg)
    end
  end

  describe '#==' do
    it 'is equal if the data is the same' do
      expect(subject).to eq(subject)
    end

    it 'is not equal if the data is different' do
      expect(subject).not_to eq(described_class.new('Other/Cop', 'foo', 'bar'))
    end
  end
end
