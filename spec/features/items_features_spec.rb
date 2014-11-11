require 'rails_helper'

describe 'Items' do

  context 'have not been added' do

    it 'should display a message saying no items added' do
      visit '/items'

      expect(page).to have_content 'No items have been added to the site yet.'
      expect(page).to have_link 'Add a new Item'
    end

  end

  context 'have been added' do

    before do
      Item.create(name: 'Orlando Guitar')
    end

    it 'should be displayed on the screen' do
      visit '/items'

      expect(page).to have_content 'Orlando Guitar'
    end

  end

  context 'can be added' do

    it 'should require user to complete a form' do
      visit '/items'
      click_link 'Add a new Item'
      fill_in 'Name', with: 'Orlando Guitar'
      fill_in 'Description', with: '1998 Les Paul. Black.'
      fill_in 'Price', with: 5
      click_button 'Submit Item'

      expect(page).to have_content 'Orlando Guitar'
      expect(current_path).to eq '/items'
    end

  end

end