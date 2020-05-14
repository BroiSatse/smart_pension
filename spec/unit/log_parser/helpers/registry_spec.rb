require 'log_parser/helpers/lazy_registry'

# We are using `fork` in tests below to isolate process memory.This is to ensure that each test
# starts without constants being already loaded.
RSpec.describe LogParser::Helpers::LazyRegistry do
  before do
    subject.register :a, 'RegistrySpecFixture::A', 'spec/unit/log_parser/helpers/registry/a'
    subject.register :b, 'RegistrySpecFixture::NotB', 'spec/unit/log_parser/helpers/registry/b'
  end

  it 'loads the file and return declared constant on request' do
    process = fork do
      expect(subject.get(:a)).to eq RegistrySpecFixture::A
    end
    Process.wait(process)
  end

  it 'loads the file and return declared constant on request' do
    process = fork do
      expect(subject.get('a')).to eq RegistrySpecFixture::A
    end
    Process.wait(process)
  end
end
