require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'validations' do
    it 'requires content presence' do
      comment = Comment.new(content: nil, user_id: 1, book_id: 1)
      expect(comment).to_not be_valid
    end

    it 'requires user_id presence' do
      comment = Comment.new(content: 'Content', user_id: nil, book_id: 1)
      expect(comment).to_not be_valid
    end

    it 'requires book_id presence' do
      comment = Comment.new(content: 'Content', user_id: 1, book_id: nil)
      expect(comment).to_not be_valid
    end
  end
end
