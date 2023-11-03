require 'rails_helper'

RSpec.describe 'Categories/index', type: :feature do
  before(:each) do
    @user = User.create(id: '3', name: 'Massam', email: 'massam@gmail.com', password: '123abc')
    @category = Category.create(id: '3', name: 'Office Payments',
                                icon: 'https://www.eatthis.com/wp-content/uploads/sites/4/2019/02/mcdonalds-logo.jpg?quality=82&strip=1',
                                user: @user)
    visit new_user_session_path
    fill_in 'Email', with: 'massam@gmail.com'
    fill_in 'Password', with: '123abc'
    click_button 'Log in'
  end
  describe 'Testing index view of categories' do
    it 'should contain page heading' do
      expect(page).to have_content 'Categories'
    end
    it 'should have category name' do
      expect(page).to have_content 'Office Payments'
    end
    it 'should have category name' do
      expect(page).to have_content '$0.0'
    end
  end

  describe 'Testing new view of categories' do
    before(:each) { click_link 'New Category' }
    it 'should have name field' do
      expect(page).to have_field(type: 'text')
    end
    it 'should have icon field' do
      expect(page).to have_field(type: 'text')
    end
    it 'should have submit field' do
      expect(page).to have_button(type: 'submit')
    end
  end
end
