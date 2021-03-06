require 'rails_helper'
RSpec.describe Restaurant, type: :model do

  it { should belong_to(:user) }

  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid unless it has a unique name' do
    user = User.create(email: "dog@dog.com", password: 'password123')
    user.restaurants.create(name: "Moe's tavern")
    restaurant = user.restaurants.new(name: "Moe's tavern")
    expect(restaurant).to have(1).error_on(:name)
  end

  describe 'reviews' do
    describe '#build_with_user' do
      let(:user) { User.create email: 'test@test.com' }
      let(:restaurant) { Restaurant.create name: 'KFC' }
      let(:review_params) { { rating: '5', thoughts: 'yum' } }

      subject(:review) {restaurant.reviews.build_with_user(review_params, user)}

      it 'builds a review' do
        expect(review).to be_a Review
      end

      it 'builds a review associated with the specified user' do
        expect(review.user).to eq user
      end
    end
  end

  describe '#average_rating' do
    it 'returns the average' do
      user = User.create(email: "dog@dog.com", password: 'password123')
      restaurant = user.restaurants.create(name: "Cat's pyjamas")
      user_2 = User.create(email: "second_user@name.com", password: 'password', password_confirmation: 'password')
      restaurant.reviews.create(rating: 1, user: user_2)
      user_3 = User.create(email: "third_user@name.com", password: 'password', password_confirmation: 'password')
      restaurant.reviews.create(rating: 5, user: user_3)
      expect(restaurant.average_rating).to eq 3
    end
  end
end
