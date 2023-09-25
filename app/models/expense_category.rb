class ExpenseCategory < ApplicationRecord
  belongs_to :expense, class_name: 'Expense', foreign_key: 'expense_id'
  belongs_to :category, class_name: 'Category', foreign_key: 'category_id'
end
