class Restaurant < ApplicationRecord
  has_many :reviews do
    def build_with_user(attributes = {}, user)
      attributes[:user] ||= user
      build(attributes)
    end
  end


  belongs_to :user, dependent: :destroy

  validates :name, length: { minimum: 3 }, uniqueness: true

  def build_review(review, user)
    review = reviews.build(review)
    review.user = user
    review
  end
end
