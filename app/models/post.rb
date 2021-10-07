class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  def self.search(keyword)
    where(["title like? OR body like?", "%#{keyword}%", "%#{keyword}%"])
  end
end
