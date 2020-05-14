require 'log_parser/stats/unique_visit_count'

RSpec.describe LogParser::Stats::UniqueVisitCount do
  describe '#record' do
    let(:page) { Faker::Lorem.words(number: 2).join('/') }
    let(:ips) { Array.new(rand 3..4) { Faker::Internet.ip_v4_address } }

    it 'records each visit from new ip' do
      ips.flat_map { |ip| [ip] * rand(1..3) }.shuffle.each do |ip|
        subject.record page, ip
      end
      expect(subject.result).to eq [
        [page, ips.count]
      ]
    end
  end
end
