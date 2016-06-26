class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :assignments 
  has_many :tasks, through: :assignments

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  def tasks_created
    Task.where(author: self)
  end
end
