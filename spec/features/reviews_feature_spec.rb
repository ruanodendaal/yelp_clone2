require 'rails_helper'

feature 'reviewing' do
  before do
    sign_up
    create_restaurant
  end

  scenario 'allows user to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review Hotdog'
    fill_in "Thoughts", with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'so so'
  end

  scenario 'allows user to delete their own reviews' do
    sign_out
    sign_up(email: 'cat@cat.com')
    write_review(thoughts: 'Amazing')
    click_link 'Hotdog'
    click_link 'Delete review'
    expect(page).not_to have_content 'Amazing'
  end

  scenario 'user can only delete own reviews' do
    sign_out
    sign_up(email: 'cat@cat.com')
    write_review(thoughts: 'Amazing')
    sign_out
    login
    click_link 'Hotdog'
    expect(page).not_to have_content 'Delete review'
  end

  context 'view average rating' do
    before do
      sign_out
      sign_up(email: 'cat@cat.com')
    end

    scenario '1 review returns that rating' do
      write_review(rating: 4)
      expect(page).to have_content('Average rating: ★★★★☆')
    end

    scenario 'returns the average' do
      write_review(rating: 1)
      sign_out
      sign_up(email: 'sheep@cat.com')
      write_review(rating: 5)
      expect(page).to have_content('Average rating: ★★★☆☆')
    end
  end
end
