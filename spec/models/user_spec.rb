require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'requires email presence' do
      user = User.new(email: nil)
      expect(user).to_not be_valid
    end

    it 'requires email uniqueness' do
      existing_user = User.create(email: 'test@example.com', password: 'password')
      user = User.new(email: existing_user.email)
      expect(user).to_not be_valid
    end

    it 'requires a valid email format' do
      user = User.new(email: 'invalid_email')
      expect(user).to_not be_valid
    end

    it 'requires password presence' do
      user = User.new(password: nil)
      expect(user).to_not be_valid
    end

    it 'requires a minimum password length of 6 characters' do
      user = User.new(password: '12345')
      expect(user).to_not be_valid
    end

    it 'requires password confirmation' do
      user = User.new(password_confirmation: nil)
      expect(user).to_not be_valid
    end

    it 'requires a role to be present and be either admin or regular_user' do
      user = User.new(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        role: :admin
      )
      expect(user).to be_valid

      user = User.new(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        role: :regular_user
      )
      expect(user).to be_valid
    end
  end

end
