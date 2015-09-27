module Destiny
  class Race
    attr_reader :hash, :type, :name, :description

    def initialize(data)
      @hash = data[:race_hash]
      @type = data[:race_name]
      @description = data[:race_description]
    end
  end
end
