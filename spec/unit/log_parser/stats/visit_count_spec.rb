require 'log_parser/stats/visit_count'

RSpec.describe LogParser::Stats::VisitCount do
  describe '#record' do
    let(:ips) { Array.new(rand 2..4) { Faker::Internet.unique.ip_v4_address } }
    let(:pages) { Array.new(rand 2..4) { Faker::Internet.unique.ip_v4_address } }

    let(:all_visits) { Array.new(rand 5..10) { [pages.sample, ips.sample] } }

    it 'correctly records total visit count' do
      all_visits.each do |page, ip|
        subject.record(page, ip)
      end

      expect(subject.result).to eq(
        all_visits
          .group_by(&:first)
          .map { |page, ary| [page, ary.count] }
          .sort_by{ |_page, count| -count }
      )
    end
  end

  private

  def random_page_path
    Faker::Lorem.unique.words(number: rand(2..3)).join('/')
  end
end
