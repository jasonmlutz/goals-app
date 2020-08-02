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
  subject(:user) do
    FactoryBot.build(:user,
      email: "jason@fakesite.com",
      password: "good_password")
  end

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email)}
  it { should validate_presence_of(:password_digest)}
  it { should validate_length_of(:password).is_at_least(6) }

  it "creates a password digest when a password is given" do
    expect(user.password_digest).to_not be_nil
  end

  describe '#is_password?' do
    it 'identifies a correct password' do
      expect(user.is_password?("good_password")).to be true
    end
    it 'identifies an incorrect password' do
      expect(user.is_password?("incorrect_password")).to be false
    end
  end

  it 'has a session token after initialization' do
    expect(user.session_token).to_not be_nil
  end

  it 'has an activation token after initialization' do
    expect(user.activation_token).to_not be_nil
  end

  describe 'User::generate_session_token' do
    it 'generates a session token' do
      token = User.generate_session_token
      expect(token).to_not be_nil
      expect(token).to be_instance_of(String)
    end
  end

  describe 'User::generate_activation_token' do
    it 'generates an activation token' do
      token = User.generate_activation_token
      expect(token).to_not be_nil
      expect(token).to be_instance_of(String)
    end
  end

  describe '#reset_session_token!' do
    before(:all) do
      @token_user = User.create(email: 'token@token.com', password: 'token_password')
      @old_token = @token_user.session_token
      @token_user.reset_session_token!
      @new_token = @token_user.session_token
    end

    after(:all) do
      @token_user.destroy
    end
    it 'sets a session token' do
      expect(@new_token).to_not be_nil
    end

    it "almost always sets a NEW token" do
      expect(@new_token).to_not eq(@old_token)
    end
  end

  describe 'User::find_by_credentials' do
    before(:all) do
      @new_user = User.new(email: 'kaylee@fakesite.com', password: 'good_password')
      @new_user.save
    end

    after(:all) do
      @new_user.destroy
    end

    it 'finds the user given correct credentials' do
      expect(User.find_by_credentials("kaylee@fakesite.com", "good_password")).to eq(@new_user)
    end

    it 'returns nil if no such email exists in the db' do
      expect(User.find_by_credentials("KAYLEE@fakesite.com", "good_password")).to be_nil
    end

    it 'returns nil if email exists and password is incorrect' do
      expect(User.find_by_credentials("kaylee@fakesite.com", "incorrect_password")).to be_nil
    end
  end
end
