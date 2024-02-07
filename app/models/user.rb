class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


         validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
         validates :password, presence: true, length: { minimum: 6 }
         validates :password_confirmation, presence: true
         validates :role, presence: true, inclusion: { in: %w(admin regular_user) }

         has_many :comments, dependent: :delete_all
         has_many :books, dependent: :delete_all

         enum role: { regular_user: 0, admin: 1 }
end
