class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  validates :username, presence: true, length: { in: 2..20 }

  has_many :group_users
  has_many :groups, through: :group_users

  has_many :bills_as_payer, source: :bill, class_name: 'Bill'
  has_many :debts_as_borrower, class_name: 'Debt'
  has_many :debts_as_payer, through: :bills_as_payer, source: :debts
  has_many :bills_as_borrower, through: :debts_as_borrower, source: :bill
end
