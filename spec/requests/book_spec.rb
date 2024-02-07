require 'rails_helper'

RSpec.describe "Books", type: :request do
  describe "GET /books" do
    it "renders the index template" do
      # Assuming you have some books already created
      get "/books"
      expect(response).to be_successful
    end
  end

  describe "GET /books/:id" do
    let(:book) { Book.create(title: "Test Book", description: "Test Description", user_id: 1) }

    it "returns a success response" do
      get "/books/#{book.id}"
      expect(response).to be_successful
    end
  end

  describe "GET /books/new" do
    it "renders the new template" do
      get "/books/new"
      expect(response).to be_successful
    end
  end

  describe "POST /books" do
    let(:valid_attributes) { { title: "Test Book", description: "Test Description", user_id: 1 } }

    it "creates a new book with valid parameters" do
      expect {
        post "/books", params: { book: valid_attributes }
      }.to change(Book, :count).by(1)
    end
  end

  describe "DELETE /books/:id" do
    let!(:book) { Book.create(title: "Test Book", description: "Test Description", user_id: 1) }

    it "destroys the requested book" do
      expect {
        delete "/books/#{book.id}"
      }.to change(Book, :count).by(-1)
    end
  end
end
