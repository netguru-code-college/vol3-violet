class Group < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { in: 5..255 }
  has_many :group_users
  has_many :users, through: :group_users
  has_many :bills, dependent: :destroy
  belongs_to :creator, class_name: 'User'
end
