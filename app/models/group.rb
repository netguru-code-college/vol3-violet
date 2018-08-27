class Group < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { in: 5..255 }
  has_many :group_users
  has_many :users, through: :group_users
end
