# frozen_string_literal: true

describe RuboBot::CLI do
  describe '#run' do
    subject { described_class.new.run }
    it { is_expected.to eq(0) }
  end
end
