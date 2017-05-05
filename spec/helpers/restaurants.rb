module RestaurantHelpers

  def create_restaurant(name: 'Hotdog')
    click_link 'Add a restaurant'
    fill_in 'Name', with: name
    click_button 'Create Restaurant'
  end
end
