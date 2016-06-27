class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  has_many :assignments 
  has_many :tasks, through: :assignments

  before_save :verify_authentication_token

  def tasks_created
    Task.where(author: self)
  end

  def self.authenticate(credentials)
    user = self.find_by(email: credentials[:email])
    user if user && user.valid_password?(credentials[:password])
  end
  
  private

  def verify_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_auth_token
    end
  end

  def generate_auth_token
    loop do
      token = SecureRandom.urlsafe_base64(15)
      break token unless User.where(authentication_token: token).any?
    end
  end
end