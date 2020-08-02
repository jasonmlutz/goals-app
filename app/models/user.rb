# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  email            :string           not null
#  password_digest  :string           not null
#  session_token    :string
#  activated        :boolean          default(FALSE)
#  activation_token :string
#  admin            :boolean          default(FALSE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class User < ApplicationRecord
  attr_reader :password

  after_initialize :ensure_session_token
  after_initialize :ensure_activation_token
  validates :email, :password_digest, :session_token, :activation_token, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def self.generate_activation_token
    SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.update(session_token: User.generate_session_token)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil if user.nil?
    if user.is_password?(password)
      return user
    else
      return nil
    end
  end

  private

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def ensure_activation_token
    self.activation_token ||= User.generate_activation_token
  end

end
