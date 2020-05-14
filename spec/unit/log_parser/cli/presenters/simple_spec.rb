require 'log_parser/cli/presenters/simple'
require 'spec/unit/shared/callable'

RSpec.describe LogParser::CLI::Presenters::Simple do
  let(:data) { Array.new(rand 5..10) { [Faker::Lorem.word, rand(0..100)] } }
  subject(:result) { described_class.new(data).() }

  it_behaves_like 'callable class'

  it 'renders data into string by joing with tabs' do
    expect(result).to eq data.map { |row| row.join("\t") }.join("\n")
  end
end
