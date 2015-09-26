require 'spec_helper'

describe Destiny::Request do
  let(:request) { Destiny::Request.new }

  describe 'authentication' do
    it 'has api_key' do
      expect(request.send(:default_headers)['X-API-Key']).to_not be_nil
    end
  end
end
