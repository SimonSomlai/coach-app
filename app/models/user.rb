class User < ActiveRecord::Base
  # Virtual attribute to create remember_digest
  attr_accessor :remember_token

  # Save emails as downcase to the db
  before_save { self.email = email.downcase }
  before_save { self.name = name.capitalize }

  # Email validation regex
  REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # Validations
  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: {maximum: 150}, format: { with: REGEX }
  validates :password, length: { minimum: 6 }, on: :create

  # Adds virtual attributes password & password_confirmation to User and saves them as password_digest using BCrypt
  has_secure_password

  # Profile Image Using carrierwave
  mount_uploader :image, ImageUploader

  # ----------------------- MODEL METHODS ----------------------------------------------

  # Returns hash digest of given string using BCrypt
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Generates url-safe 16 character string
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Sets remember_token virtual attribute to a random string,
  # Updates remember_digest for object with a digest of that token
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Checks if remember_digest (model attribute) matches remember_token (is User.authenticated?("remember_token") true?)
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
