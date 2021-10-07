class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :body, presence: true

  def self.search(keyword)
    where(["body like?", "%#{keyword}%"])
  end
end
