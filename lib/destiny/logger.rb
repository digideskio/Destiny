require_relative 'configuration'

module Destiny

  def self.logger
    @logger ||= Logger.new
  end

  class Logger

    def debug(message)
      return if Destiny.configuration.log_level == :none
      if defined?(Rails::Logger)
        Rails.logger.debug message
      else
        puts "DEBUG - #{message}"
      end
    end

  end
end
