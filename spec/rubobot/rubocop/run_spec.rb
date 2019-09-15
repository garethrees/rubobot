# frozen_string_literal: true

describe RuboBot::RuboCop::Run do
  subject { described_class.new(double('project_dir')) }

  describe '#offenses' do
    let(:mock_output) do
      <<~STDOUT
        foo
        123 Some/Offense
        456 Another/BadOffense
        bar
      STDOUT
    end

    let(:mock_status) { double('Process::Status', success?: true) }

    context 'rubocop has been run' do
      before do
        allow(subject).to receive(:run!).
          and_return([mock_output, mock_status])
        subject.run
      end

      it 'returns a list of offenses' do
        data = { 'Some/Offense' => 123, 'Another/BadOffense' => 456 }
        expect(subject.offenses).to eq(RuboBot::RuboCop::Offenses.new(data))
      end
    end

    context 'rubocop has not been run' do
      it 'returns an empty offense list' do
        expect(subject.offenses).to eq(RuboBot::RuboCop::Offenses.new({}))
      end
    end
  end

  describe '#run' do
    context 'the rubocop run was successful' do
      let(:mock_status) { double('Process::Status', success?: true) }

      before do
        allow(Open3).to receive(:capture2).and_return(['yay', mock_status])
      end

      it 'returns true' do
        expect(subject.run).to eq(true)
      end
    end

    context 'the rubocop run failed' do
      let(:mock_status) { double('Process::Status', success?: false) }

      before do
        allow(Open3).to receive(:capture2).and_return(['noo', mock_status])
      end

      it 'returns false' do
        expect(subject.run).to eq(false)
      end
    end
  end
end
