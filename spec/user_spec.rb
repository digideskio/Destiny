require 'spec_helper'

describe Destiny::User do
  let(:user) { Destiny::User.new }

  it 'loads destiny id' do
    expect(user.destiny_id).to_not be_nil
  end

  it 'loads summary' do
    expect(user.characters.count).to eq 3
  end
end
