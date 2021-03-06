# frozen_string_literal: true

describe RuboBot::Configuration do
  describe '#commit_message?' do
    context 'with the defaults' do
      subject { described_class.new.commit_message? }
      it { is_expected.to eq(false) }
    end

    context 'when initialised as true' do
      subject { described_class.new(commit_message: true).commit_message? }
      it { is_expected.to eq(true) }
    end

    context 'when initialised as false' do
      subject { described_class.new(commit_message: false).commit_message? }
      it { is_expected.to eq(false) }
    end
  end

  describe '#verbose?' do
    context 'with the defaults' do
      subject { described_class.new.verbose? }
      it { is_expected.to eq(false) }
    end

    context 'when initialised as true' do
      subject { described_class.new(verbose: true).verbose? }
      it { is_expected.to eq(true) }
    end

    context 'when initialised false' do
      subject { described_class.new(verbose: false).verbose? }
      it { is_expected.to eq(false) }
    end
  end

  describe '#version?' do
    context 'with the defaults' do
      subject { described_class.new.version? }
      it { is_expected.to eq(false) }
    end

    context 'when initialised as true' do
      subject { described_class.new(version: true).version? }
      it { is_expected.to eq(true) }
    end

    context 'when initialised false' do
      subject { described_class.new(version: false).version? }
      it { is_expected.to eq(false) }
    end
  end

  describe '#stdout' do
    context 'with the defaults' do
      subject { described_class.new.stdout }
      it { is_expected.to eq($stdout) }
    end

    context 'when given a custom value' do
      subject { described_class.new(stdout: custom_stdout).stdout }
      let(:custom_stdout) { double }
      it { is_expected.to eq(custom_stdout) }
    end
  end

  describe '#stderr' do
    context 'with the defaults' do
      subject { described_class.new.stderr }
      it { is_expected.to eq($stderr) }
    end

    context 'when given a custom value' do
      subject { described_class.new(stderr: custom_stderr).stderr }
      let(:custom_stderr) { double }
      it { is_expected.to eq(custom_stderr) }
    end
  end
end
