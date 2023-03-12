class User < ApplicationRecord
    has_secure_password
    has_many :areas, dependent: :delete_all
    validates :username, :password_digest, presence: true

    validates :email, uniqueness: true, presence: true
end
