module Destiny
  class Gender
    attr_reader :hash, :type, :name, :description
    def initialize(data)
      @hash = data[:gender_hash]
      @type = data[:gender_type]
      @name = data[:gender_name]
      @description = data[:gender_description]
    end
  end
end
