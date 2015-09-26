$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pry'
require 'yaml'
require 'destiny'

SECRETS = YAML.load(File.read("#{File.expand_path('../../', __FILE__)}/secrets.yml"))

puts SECRETS

RSpec.configure do |config|
  config.before(:each) do
    Destiny.configure do |config|
      config.api_key = SECRETS['test']['api_key']
      config.membership_id = SECRETS['test']['membership_id']
    end
  end
end
