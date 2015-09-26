require 'spec_helper'

describe Destiny do
  describe '#configuration' do
    let(:api_key) { 'xyz' }
    let(:membership_id) { '123' }

    before do
      Destiny.configure do |config|
        config.api_key = api_key
        config.membership_id = membership_id
      end
    end

    it 'has an api_key' do
      expect(Destiny.configuration.api_key).to eq api_key
    end

    it 'has a membership_id' do
      expect(Destiny.configuration.membership_id).to eq membership_id
    end

  end
end
