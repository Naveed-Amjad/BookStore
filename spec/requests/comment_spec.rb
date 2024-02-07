require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let!(:user) { User.create(email: "user@example.com", password: "password") }
  let!(:book) { Book.create(title: "Test Book", description: "Test Description", user_id: user.id) }
  let!(:comment) { Comment.create(content: "Test Comment", user_id: user.id, book_id: book.id) }

  describe "GET /comments" do
    it "renders the index template" do
      get "/comments"
      expect(response).to render_template(:index)
    end
  end

  describe "GET /comments/:id" do
    it "renders the show template" do
      get "/comments/#{comment.id}"
      expect(response).to render_template(:show)
    end
  end

  describe "GET /comments/new" do
    it "renders the new template" do
      get "/comments/new"
      expect(response).to render_template(:new)
    end
  end

  describe "POST /comments" do
    let(:valid_attributes) { { content: "Test Comment", user_id: user.id, book_id: book.id } }

    it "creates a new comment with valid parameters" do
      expect {
        post "/comments", params: { comment: valid_attributes }
      }.to change(Comment, :count).by(1)
    end
  end

  describe "GET /comments/:id/edit" do
    it "renders the edit template" do
      get "/comments/#{comment.id}/edit"
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH /comments/:id" do
    let(:new_content) { "Updated Comment Content" }

    it "updates the requested comment" do
      patch "/comments/#{comment.id}", params: { comment: { content: new_content } }
      comment.reload
      expect(comment.content).to eq(new_content)
    end
  end

  describe "DELETE /comments/:id" do
    it "destroys the requested comment" do
      expect {
        delete "/comments/#{comment.id}"
      }.to change(Comment, :count).by(-1)
    end
  end
end
