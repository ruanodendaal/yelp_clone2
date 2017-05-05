class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy
  belongs_to :user, dependent: :destroy

  validates :name, length: { minimum: 3 }, uniqueness: true

  def build_review(review, user)
    review = reviews.build(review)
    review.user = user
    review
  end
end
