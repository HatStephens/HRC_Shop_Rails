require 'spec_helper'
require 'helpers/items'

RSpec.describe Item, type: :model do

  it 'is invalid if the name is more than 50 characters' do
    item = Item.create(name:'Reallyreallyreallyreallyreallyreallylongnameforthe Item')
    expect(item).not_to be_valid
    # expect(item).to have(1).error_on(:name)
  end

  it 'must have a name' do
    item = Item.create(name:'', user_id: 1)
    expect(item).not_to be_valid
  end

  it 'can have a description up to 250 characters' do
    item = Item.create(name:'Test Pin', description: long_text, user_id: 1)
    expect(item).not_to be_valid
  end

  it 'must have a user_id' do
    item = Item.create(name:'Test Pin')
    expect(item).not_to be_valid
  end

end

