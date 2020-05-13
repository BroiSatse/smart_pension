require 'log_parser/cli/options'

RSpec.describe LogParser::CLI::Options do
  describe '.parse!' do
    let(:args) { %w[] }
    subject(:result) { described_class.parse! args }

    it 'returns instance of LogParses::CLI::Options' do
      expect(subject).to be_an_instance_of described_class
    end

    describe '-f' do
      let(:files) { Array.new(rand 2..4) { File.join *Faker::Lorem.words(number: 3) } }
      let(:args) { files.flat_map { |file| ['-f', file] } }

      it 'defines file to be loaded' do
        expect(subject.files).to eq files
      end
    end
  end
end
