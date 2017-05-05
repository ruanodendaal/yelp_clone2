class Restaurant < ApplicationRecord
  has_many :reviews,
    -> { extending WithUserAssociationExtension },
    dependent: :destroy

  belongs_to :user, dependent: :destroy

  validates :name, length: { minimum: 3 }, uniqueness: true

  def build_review(review, user)
    review = reviews.build(review)
    review.user = user
    review
  end

  def average_rating
    return 'N/A' if reviews.none?
    reviews.average(:rating)
  end
end
