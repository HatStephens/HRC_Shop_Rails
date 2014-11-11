require 'spec_helper'

RSpec.describe Item, type: :model do

  it 'is invalid if the name is more than 50 characters' do
    item = Item.create(name:'Reallyreallyreallyreallyreallyreallylongnameforthe Item')
    expect(item).not_to be_valid
    # expect(item).to have(1).error_on(:name)
  end

end