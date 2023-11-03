class Expense < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  has_and_belongs_to_many :categories, join_table: 'categories_expenses', dependent: :destroy

  validates :author_id, presence: true
  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates_presence_of :category_ids, message: 'Please select at least one category'

  attribute :amount, :decimal, default: 0
end
