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
require 'rails_helper'

describe User do
  subject(:user) { User.new(email: 'jason@fakesite.com', password: 'great_password') }


  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest)}
  it { should validate_presence_of(:session_token)}
  it { should validate_presence_of(:activation_token)}

  it 'validates length of password' do
    subject(:short_password) { User.new(email: 'jason@fakesite.com', password: 'poor') }
    subject(:empty_password) { User.new(email: 'jason@fakesite.com', password: '') }
    expect(short_password.valid?).to be false
    expect(empty_password.valid?).to be true
  end
end
