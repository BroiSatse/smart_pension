require 'log_parser/cli/run'
require 'spec/unit/shared/callable'

RSpec.describe LogParser::CLI::Run do
  let(:text_files) { [] }
  let(:unique) { false }
  let(:fake_data) { double 'data' }
  let(:presenter) { double 'presenter', call: Faker::Lorem.paragraph }
  let(:output) { StringIO.new }

  let(:options) do
    instance_double LogParser::CLI::Options,
      text_files: text_files,
      unique: unique
  end

  before do
    allow(described_class::PresenterRegistry).to receive(:get).and_return presenter
  end

  subject { described_class.new options, out: output }

  it_behaves_like 'callable class'

  describe '#call' do
    before do
      allow(LogParser::Run).to receive(:call).and_return fake_data
    end

    it 'executes LogParser::Run' do
      subject.call
      expect(LogParser::Run).to have_received(:call)
    end

    describe 'text_files option conversion' do
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

    describe 'handling unique option' do
      context 'when flag is set to false' do
        let(:unique) { false }

        it 'injects VisitCount stat generator' do
          subject.call
          expect(LogParser::Run).to have_received(:call) do |stat:, **|
            expect(stat).to be_instance_of LogParser::Stats::VisitCount
          end
        end
      end

      context 'when flag is set to true' do
        let(:unique) { true }

        it 'injects UniqueVisitCount stat generator' do
          subject.call
          expect(LogParser::Run).to have_received(:call) do |stat:, **|
            expect(stat).to be_instance_of LogParser::Stats::UniqueVisitCount
          end
        end
      end
    end

    it 'displays data using correct presenter' do
      subject.call

      expect(described_class::PresenterRegistry).to have_received(:get).with('simple')
    end
  end
end
