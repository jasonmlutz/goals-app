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
  validates :email, :password_digest, :session_token, :activation_token, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true 

  def password=(password)
  end

  def self.find_by_credentials(email, password)
  end


end
