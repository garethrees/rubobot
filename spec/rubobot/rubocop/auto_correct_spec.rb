# frozen_string_literal: true

describe RuboBot::RuboCop::AutoCorrect do
  subject do
    described_class.new(double('project_dir', to_s: '/tmp'), 'Some/Cop')
  end

  describe '#commit_message' do
    let(:mock_output) do
      <<~STDOUT
        blah
      STDOUT
    end

    let(:mock_status) { double('Process::Status', success?: true) }

    context 'rubocop has been run' do
      before do
        allow(subject).to receive(:run!).
          and_return([mock_output, mock_status])
        subject.run
      end

      it 'returns a commit message based on the corrections' do
        cop = 'Some/Cop'
        cmd = 'rubocop --safe-auto-correct --format clang --only Some/Cop /tmp'
        out = mock_output

        expect(subject.commit_message).
          to eq(RuboBot::Git::CommitMessage.new(cop, cmd, out))
      end
    end

    context 'rubocop has not been run' do
      it 'returns an empty offense list' do
        expect { subject.commit_message }.
          to raise_error(RuboBot::RuboCop::AutoCorrect::RunError)
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
