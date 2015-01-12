require 'rails_helper'
require 'helpers/users'

describe 'Items' do

  context 'have not been added yet' do

    it 'should display a message saying no items added' do
      visit '/'
      expect(page).to have_content 'Sorry, no items match your Search criteria.'
    end

  end

  context 'have been added' do

    before do
      @item = Item.create(name: 'Orlando Guitar', user_id: 100)
      @userone = User.create(email: 'phil@hrc.com', password: 'testtest', id: 100)
      @usertwo = User.create(email: 'jimi@hrc.com', password: 'testtest', id: 200)
    end

    it 'should be displayed on the home page' do
      visit '/'
      expect(page).to have_content 'Orlando Guitar'
    end

    it 'should link to full details' do
      visit '/'
      click_link 'Orlando Guitar'
      expect(page).to have_content 'Orlando Guitar'
      expect(current_path).to eq "/items/#{@item.id}"
    end

    it 'can be edited by the owner' do
      sign_in('phil@hrc.com', 'testtest')
      click_link 'Orlando Guitar'
      click_link 'Edit'
      expect(page).to have_content 'Edit Orlando Guitar'
    end

    it 'cannot be edited by other users' do
      sign_in('jimi@hrc.com', 'testtest')
      click_link 'Orlando Guitar'
      expect(page).to_not have_link 'Edit'
    end

    it 'can be deleted by the owner' do
      sign_in('phil@hrc.com', 'testtest')
      click_link 'Orlando Guitar'
      click_link 'Delete'
      expect(page).to have_content 'Your pin has been removed successfully'
      expect(current_path).to eq '/'
    end

    it 'cannot be deleted by other users' do
      sign_in('jimi@hrc.com', 'testtest')
      click_link 'Orlando Guitar'
      expect(page).to_not have_content 'Delete'
    end

  end

  context 'can be added' do
    it 'should require registered user to complete a form' do
      sign_up
      sign_in('pete@hrc.com', 'testtest')
      click_link 'Add a new Item'
      fill_in 'Name', with: 'Orlando Guitar'
      fill_in 'Description', with: '1998 Les Paul. Black.'
      fill_in 'Price', with: 5
      click_button 'Submit Item'

      expect(page).to have_content 'Orlando Guitar'
      expect(current_path).to eq '/'
    end

    it 'only by registered users' do
      visit '/items/new'
      expect(page).to have_content 'You must be registered to list a new pin'
    end

    it 'with a photo' do
      sign_up
      sign_in('pete@hrc.com', 'testtest')
      click_link 'Add a new Item'
      fill_in 'Name', with: 'Orlando Guitar'
      fill_in 'Description', with: '1998 Les Paul. Black.'
      fill_in 'Price', with: 5
      attach_file 'Photo', 'spec/helpers/cow.jpg'
      click_button 'Submit Item'

      expect(page).to have_selector("img[alt='Cow']")
    end

  end

  context 'can be filtered' do
    before do
      @item_one = Item.create(name: 'test_one', location: 'London', occasion: 'Christmas', user_id: 100)
      @item_two = Item.create(name: 'test_two', location: 'London', occasion: 'Anniversary', user_id: 100)
      @item_three = Item.create(name: 'test_three', location: 'Paris', occasion: 'Staff', user_id: 100)
    end

    it 'by location' do
      visit '/'
      select 'Paris', from: 'search[location]'
      click_button 'Search'
      expect(page).to_not have_content 'test_one'
      expect(page).to have_content 'test_three'
    end

    it 'by occasion' do
      visit '/'
      select 'Christmas', from: 'search[occasion]'
      click_button 'Search'
      expect(page).to_not have_content 'test_two'
      expect(page).to have_content 'test_one'
    end

    it 'by location and occasion' do
      visit '/'
      select 'Paris', from: 'search[location]'
      select 'Staff', from: 'search[occasion]'
      click_button 'Search'
      expect(page).to_not have_content 'test_two'
      expect(page).to have_content 'test_three'
    end

    it 'by a keyword' do
      visit '/'
      fill_in 'keywordsearch', with: 'two'
      click_button 'Search'
      expect(page).to_not have_content 'test_one'
      expect(page).to have_content 'test_two'
    end
  end

end