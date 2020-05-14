require 'log_parser/cli/options'

RSpec.describe LogParser::CLI::Options do
  describe '.parse!' do
    let(:args) { %w[] }
    subject(:result) { described_class.parse! args }

    it 'returns instance of LogParses::CLI::Options' do
      expect(result).to be_an_instance_of described_class
    end

    describe '-f' do
      let(:files) { Array.new(rand 2..4) { File.join *Faker::Lorem.words(number: 3) } }
      let(:args) { files.flat_map { |file| ['-f', file] } }

      it 'defines files to be loaded' do
        expect(result.text_files).to eq files
      end
    end

    describe '--unique' do
      context 'without the --unique option' do
        it 'sets unique flag to false' do
          expect(result.unique).to be false
        end
      end

      context 'with the --unique option' do
        let(:args) { %w[--unique]}

        it 'sets unique flag to true' do
          expect(result.unique).to be true
        end
      end
    end
  end
end
