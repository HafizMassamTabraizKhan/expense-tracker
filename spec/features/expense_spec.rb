require 'rails_helper'

RSpec.describe 'Expenses Integration', type: :feature do
  before(:each) do
    @user = User.create(name: 'Massam', email: 'massam@gmail.com', password: '123abc')
    @category = Category.create(name: 'Office Payments', icon: 'https://www.example.com/icon.jpg', user: @user)
    @expense = Expense.create(id: 2, name: 'Over Time', amount: 10.50, author_id: @user.id,
                              category_ids: [@category.id])
    visit new_user_session_path
    fill_in 'Email', with: 'massam@gmail.com'
    fill_in 'Password', with: '123abc'
    click_button 'Log in'
  end

  describe 'Index View' do
    before { visit category_path(@category) }

    it 'has total amount' do
      expect(page).to have_content('Total Amount:')
    end
    it 'has back link' do
      expect(page).to have_link('Back to categories', href: categories_path)
    end

    it 'has new expense create link' do
      expect(page).to have_link('New expense', href: new_category_expense_path(@category))
    end

    it 'has new destroy category link' do
      expect(page).to have_button('Delete this category', class: 'link_to delete')
    end
    it 'has expenses details' do
      expect(page).to have_content(@expense.name)
      expect(page).to have_content(@expense.amount)
    end
  end

  describe 'New Expense View' do
    before do
      visit category_expenses_path(@category)
      click_link 'New expense'
    end

    it 'displays the heading for new expense' do
      expect(page).to have_content('New Expense')
    end

    it 'displays the name field' do
      expect(page).to have_field('expense_name')
    end

    it 'displays the amount field' do
      expect(page).to have_field('expense_amount')
    end

    it 'displays the submit button' do
      expect(page).to have_button('Save')
    end
  end
end
