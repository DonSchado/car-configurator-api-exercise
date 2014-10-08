require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  # c.debug_logger = $stderr
end

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros

  config.around(:each, :vcr) do |example|
    name = example.metadata[:description].parameterize
    VCR.use_cassette(name) { example.call }
  end
end
