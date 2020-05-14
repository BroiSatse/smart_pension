require 'log_parser/cli/presenters/pretty'
require 'spec/unit/shared/callable'

RSpec.describe LogParser::CLI::Presenters::Pretty do
  let(:data) { double }
  let(:fake_output) { Faker::Lorem.paragraph }
  subject(:result) { described_class.new(data).() }

  it_behaves_like 'callable class'

  before do
    allow(Terminal::Table).to receive(:new).with(rows: data).and_return fake_output
  end

  it 'renders data into string by joing with tabs' do
    expect(result).to eq fake_output
  end
end
