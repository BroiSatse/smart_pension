require 'log_parser/cli/run'
require 'spec/unit/shared/callable'

RSpec.describe LogParser::CLI::Run do
  let(:options) { instance_double LogParser::CLI::Options }
  subject { described_class.new options }

  it_behaves_like 'callable class'

  describe '#run!' do
    let(:files) { Array.new(rand 2..3) { File.join *Faker::Lorem.words(number: 3) } }
    let(:options) do
      instance_double LogParser::CLI::Options,
        files: files
    end

    before do
      allow(LogParser::Run).to receive(:call)
    end
  end
end
