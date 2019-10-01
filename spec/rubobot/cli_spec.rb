# frozen_string_literal: true

require 'stringio'

describe RuboBot::CLI do
  let(:project_dir) { RuboBot::ProjectDir.new('/tmp') }

  describe '#run' do
    subject { described_class.new(project_dir, configuration).run }

    let(:configuration) do
      RuboBot::Configuration.new(version: true, stdout: StringIO.new)
    end

    context 'when version: true' do
      it { is_expected.to eq(0) }
    end

    context 'when version: true and capturing stdout' do
      let(:configuration) do
        RuboBot::Configuration.new(version: true, stdout: $stdout)
      end

      it 'prints the version' do
        expect { subject }.to output("#{RuboBot::VERSION}\n").to_stdout
      end
    end
  end
end
