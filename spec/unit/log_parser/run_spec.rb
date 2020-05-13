require 'log_parser/run'
require 'spec/unit/shared/callable'

RSpec.describe LogParser::Run do
  it_behaves_like 'callable class'

  let(:loaders) { Array.new(rand 1..3) { generate_fake_loader } }
  let(:stat) { generate_fake_stat }

  subject(:result) { described_class.new(loaders: loaders, stat: stat).() }

  it 'returns given stat generator result' do
    expect(result).to eq stat.result
  end

  it 'records all data from loaders into the stat generator' do
    result

    loaders.map(&:to_a).inject(:+).group_by(&:itself).each do |(path, ip), visits_ary|
      expect(stat).to have_received(:record)
        .with(path, ip)
        .exactly(visits_ary.count).times
    end
  end

  private

  let(:ips) { Array.new(rand 2..4) { Faker::Internet.unique.ip_v4_address } }
  let(:paths) { Array.new(rand 2..4) { Faker::Lorem.words(number: rand(0..3)).join('/') } }

  def generate_fake_loader
    Array.new(rand 3..5) { [paths.sample, ips.sample] }.each
  end

  def generate_fake_stat
    double 'Fake stat generator',
      record: nil,
      result: Array.new(rand 2..3) { [(paths + ips).sample, rand(0..10)] }
  end
end
