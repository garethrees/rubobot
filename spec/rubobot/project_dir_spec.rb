# frozen_string_literal: true

describe RuboBot::ProjectDir do
  describe '#files_changed?' do
    subject { described_class.new('/tmp', repo: repo) }

    context 'when files have been modified' do
      let(:repo) { double('RuboBot::GitRepo', files_changed?: true) }

      it 'returns true' do
        expect(subject.files_changed?).to eq(true)
      end
    end

    context 'when files have not been modified' do
      let(:repo) { double('RuboBot::GitRepo', files_changed?: false) }

      it 'returns false' do
        expect(subject.files_changed?).to eq(false)
      end
    end
  end

  describe '#to_s' do
    subject { described_class.new('/tmp') }

    it 'returns the project_dir path as a string' do
      expect(subject.to_s).to eq('/tmp')
    end
  end
end
