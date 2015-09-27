module Destiny
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  class Configuration
    attr_accessor \
      :api_key,
      :membership_id,
      :log_level

    def initialize
      self.log_level = :debug
    end

  end
end
