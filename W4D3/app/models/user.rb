# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string
#  password_digest :string           not null
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'bcrypt'

class User < ApplicationRecord

  attr_reader :password

  validates :username, :session_token, presence: true
  validates :password_digest, presence: { message: "Password can't be blank" }
  validates :password, length: { minimum: 6, maximum: 64,
    message: "Password must be between 6 and 64 characters"}, allow_nil: true

  before_validation :ensure_session_token

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil if user.nil?

    return user if BCrypt::Password.new(user.password_digest).is_password?(password)

    nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    @session_token = User.generate_session_token
    save
  end

  def ensure_session_token
    reset_session_token! if @session_token.nil?
  end

  def password=(pass)
    @password = pass
    @password_digest = BCrypt::Password.create(@password)
  end
end
