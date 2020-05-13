require 'log_parser/loaders/text_file_loader'
require_relative './shared'

RSpec.describe LogParser::Loaders::TextFileLoader do
  let(:file_path) { ROOT.join('spec', 'fixtures').children.sample }
  subject { described_class.(file_path) }

  it_behaves_like 'log parser data loader'

  it 'yields the content read from the file' do
    File.readlines(file_path).zip(subject).each do |source, yielded|
      expect(yielded.join ' ').to eq source.chop
    end
  end
end
