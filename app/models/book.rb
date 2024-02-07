class Book < ApplicationRecord

    validates :title,  :description, presence: true
    validates :title, length: { maximum: 100 }
    validates :description, length: { maximum: 500 }

    has_many :comments, dependent: :delete_all
    belongs_to :user
    has_one_attached :image
end
