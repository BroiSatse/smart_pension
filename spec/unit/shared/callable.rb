RSpec.shared_examples 'callable class' do
  let(:args) { Faker::Lorem.words number: rand(2..4) }
  let(:instance) { instance_double described_class, call: true }

  before do
    allow(described_class).to receive(:new).with(*args).and_return instance
  end

  it 'creates and calls new instance' do
    described_class.(*args)
    expect(instance).to have_received(:call).with(no_args)
  end
end
