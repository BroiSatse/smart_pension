require 'log_parser/cli/run'
require 'spec/unit/shared/callable'

RSpec.describe LogParser::CLI::Run do
  let(:text_files) { [] }
  let(:options) { instance_double LogParser::CLI::Options, text_files: text_files }

  subject { described_class.new options }

  it_behaves_like 'callable class'

  describe '#call' do
    before do
      allow(LogParser::Run).to receive(:call)
    end

    it 'executes LogParser::Run' do
      subject.call
      expect(LogParser::Run).to have_received(:call)
    end

    describe 'text_files option' do
      let(:text_files) { Array.new(rand 2..4) { File.join *Faker::Lorem.words(number: 3) } }

      let(:fake_loaders) { Hash.new { |hash, key| hash[key] = double } }

      before do
        allow(LogParser::Loaders::TextFileLoader).to receive(:call) do |file_path|
          fake_loaders[file_path]
        end
      end

      it 'converts text_files from options into TextFileLoaders' do
        subject.call
        expect(LogParser::Run).to have_received(:call) do |loaders:, **|
          expect(loaders).to match_array fake_loaders.values
        end
      end
    end
  end
end
