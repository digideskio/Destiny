require 'http'
require_relative 'configuration'
require_relative 'error'
require_relative 'string'
require_relative 'logger'

module Destiny
  class Request

    def get(path, host: 'www.bungie.net', protocol: 'https', uri: nil)
      uri ||= "#{protocol}://#{host}#{parse_path(path)}"
      Destiny.logger.debug "GET #{uri}"
      response = connection.get(uri)
      handle_response(response)
    end

    private
      def parse_path(path)
        path.gsub(/:membership_id/, Destiny.configuration.membership_id)
      end

      def connection
        HTTP.headers(default_headers)
      end

      def default_headers
        {
          'X-API-Key' => Destiny.configuration.api_key
        }
      end

      def handle_response(response)
        if response.status == 307 && (uri = response.headers['location'])
          @redirect_count ||= 1
          if @redirect_count >= 5
            raise Destiny::HTTPToManyRedirects
          end
          @redirect_count += 1
          return get('', uri: uri)
        end
        raise Destiny::HTTPError.new(response.status) unless response.status.between?(200, 299)
        data = JSON.parse(response.body)
        raise Destiny::PlatformError.new(data['ErrorStatus']) unless data['ErrorCode'] == 1
        normalize_value(data['Response'])
      end

      def normalize_value(value)
        case value
        when Hash
          normalize_hash(value)
        when Array
          normalize_array(value)
        when String
          find_date(value)
        else
          value
        end
      end

      def normalize_array(array)
        arr = []
        array.each do |value|
          arr << normalize_value(value)
        end
        arr
      end

      def normalize_hash(hash)
        {}.tap do |normal|
          hash.each do |key, value|
            normal[key.to_s.destiny_to_snake_case.to_sym] = normalize_value(value)
          end
        end
      end

      def find_date(string)
        if /^([\d]{4}-[\d]{2}-[\d]{2}T[\d]{2}:[\d]{2}:[\d]{2}\.[\d]{3}Z)$/.match(string)
          DateTime.parse(string)
        else
          string
        end
      end
  end
end
