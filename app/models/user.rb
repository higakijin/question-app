class User < ApplicationRecord
  has_secure_password
  attachment :image

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
end
