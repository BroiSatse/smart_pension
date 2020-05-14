require 'pathname'

Example = Struct.new(:name, :command, :expected_output) do
  def self.from_file(file_path)
    command, *expected_output = File.read(file_path).lines
    new(file_path.basename, command.chomp, expected_output.join)
  end
end

RSpec.describe 'Examples', feature: true do
  examples_folder = Pathname.new(__FILE__).join('..', 'examples')

  examples_folder.children.each do |entry|
    example = Example.from_file(entry)

    describe example.name do
      let(:command) { example.command }
      let(:expected_output) { example.expected_output }

      it "`#{example.command}` generates expected output'" do
        expect(`#{command}`).to eq(expected_output), 'Incorrect output'
      end
    end
  end
end
