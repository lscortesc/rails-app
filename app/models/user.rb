class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  before_save { self.email = email.downcase }

  validates :username, presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 5, maximum: 30 }
  validates :email, presence: true,
            length: { maximum: 65 },
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX }

  has_secure_password

  has_many :comments
  has_many :articles
end
