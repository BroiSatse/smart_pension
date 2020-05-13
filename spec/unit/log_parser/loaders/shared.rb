RSpec.shared_examples 'log parser data loader' do
  it { is_expected.to respond_to(:each) }

  it 'yields two value array' do
    subject.each do |value|
      expect(value).to be_an(Array)
      expect(value.length).to eq 2
    end
  end
end
