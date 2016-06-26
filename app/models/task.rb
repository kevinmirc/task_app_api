class Task < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  has_many :assignments
  has_many :users, through: :assignments

  validates :title, presence: true
end
