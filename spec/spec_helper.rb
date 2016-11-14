require 'rspec'
require 'chef'
require 'chef/handler/recap'

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
end
