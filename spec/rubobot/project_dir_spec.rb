# frozen_string_literal: true

describe RuboBot::ProjectDir do
  subject { described_class.new('/tmp') }

  describe '#files_changed?' do
    context 'when files have been modified' do
      let(:diff_tool) { double('RuboBot::Git::Diff', files_changed?: true) }

      it 'returns true' do
        expect(subject.files_changed?(diff_tool: diff_tool)).to eq(true)
      end
    end

    context 'when files have not been modified' do
      let(:diff_tool) { double('RuboBot::Git::Diff', files_changed?: false) }

      it 'returns false' do
        expect(subject.files_changed?(diff_tool: diff_tool)).to eq(false)
      end
    end
  end

  describe '#to_s' do
    it 'returns the project_dir path as a string' do
      expect(subject.to_s).to eq('/tmp')
    end
  end
end
