require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'validations' do
    it 'requires title presence' do
      book = Book.new(title: nil, description: 'Description', user_id: 1)
      expect(book).to_not be_valid
    end

    it 'requires description presence' do
      book = Book.new(title: 'Title', description: nil, user_id: 1)
      expect(book).to_not be_valid
    end

    it 'requires user_id presence' do
      book = Book.new(title: 'Title', description: 'Description', user_id: nil)
      expect(book).to_not be_valid
    end
  end

  context 'associations' do
    it 'belongs to a user' do
      expect(Book.reflect_on_association(:user).macro).to eq(:belongs_to)
    end
  end
end
