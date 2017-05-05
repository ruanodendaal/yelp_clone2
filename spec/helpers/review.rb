module ReviewHelpers

  def write_review(thoughts: 'Amazing', rating: '3')
    visit restaurants_path
    click_link 'Review Hotdog'
    fill_in 'Thoughts', with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end
end
