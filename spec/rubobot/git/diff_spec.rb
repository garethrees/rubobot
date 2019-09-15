# frozen_string_literal: true

describe RuboBot::Git::Diff do
  subject { described_class.new(double('project_dir', to_str: '/tmp')) }

  describe '#files_changed?' do
    context 'when files have been modified' do
      before do
        allow(Kernel).to receive(:system).and_return('false!!')
      end

      xit 'returns true' do
        expect(subject.files_changed?).to eq(true)
      end
    end

    context 'when files have not been modified' do
      before do
        allow(Kernel).to receive(:system).and_return('true!!')
      end

      xit 'returns false' do
        expect(subject.files_changed?).to eq(false)
      end
    end
  end
end
