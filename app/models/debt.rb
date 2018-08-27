class Debt < ApplicationRecord
  belongs_to :bill
  has_one :payer, through: :bill
  belongs_to :borrower, foreign_key: "user_id", class_name: 'User'
end