module Destiny
  class PlayerClass
    attr_reader :hash, :type, :name, :identifier, :vendor_id

    def initialize(data)
      @hash = data[:class_hash]
      @type = data[:class_type]
      @name = data[:class_name]
      @identifier = data[:class_identifier]
      @vendor_id = data[:mentor_vendor_identifier]
    end
  end
end
