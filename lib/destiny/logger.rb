module Destiny

  def self.logger
    @logger ||= Logger.new
  end

  class Logger

    def debug(message)
      if defined?(Rails::Logger)
        Rails.logger.debug message
      else
        puts "DEBUG - #{message}"
      end
    end

  end
end
