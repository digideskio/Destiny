require_relative 'request'
require_relative 'character'

module Destiny
  class User
    module MembershipType
      BUNGIE = 254
      XBOX   = 1
      PSN    = 2
    end

    attr_accessor :membership_id, :membership_type, :destiny_id

    def initialize(membership_id: nil, membership_type: nil)
      @membership_id = membership_id || Destiny.configuration.membership_id
      @membership_type = membership_type || Destiny::User::MembershipType::XBOX
    end

    def load
      @has_loaded ||= begin
        response = Destiny::Request.new.get("/Platform/User/GetBungieNetUserById/#{membership_id}")
        response.delete(:membership_id)
        response.each do |key, value|
          instance_variable_set("@#{key.to_s}", value)
        end
        true
      end
    end

    def display_name
      load
      if membership_type == Destiny::User::MembershipType::XBOX
        @xbox_display_name
      else
        @psn_display_name
      end
    end

    def destiny_id
      @destiny_id ||= begin
        load
        data = Destiny::Request.new.get("/Platform/Destiny/SearchDestinyPlayer/#{membership_type}/#{display_name}")
        data.first[:membership_id]
      end
    end

    def characters
      @characters ||= begin
        data = Destiny::Request.new.get("/Platform/Destiny/#{membership_type}/Account/#{destiny_id}/Summary/?definitions=true")
        characters = []
        data[:data][:characters].each do |c|
          characters << Destiny::Character.new(c, data[:definitions])
        end
        characters
      end
    end

  end
end
