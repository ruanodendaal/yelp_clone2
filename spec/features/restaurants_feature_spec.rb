require 'rails_helper'

feature 'Restaurants' do

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'have been added' do
    scenario 'display restaurants' do
      sign_up
      create_restaurant
      visit '/restaurants'
      expect(page).to have_content 'Hotdog'
      expect(page).not_to have_content 'No restaurants yet'
    end
  end

  context 'creating restaurants' do
    scenario 'prompt user to fill out a form, then displays the new restaurant' do
      sign_up
      create_restaurant
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content 'Hotdog'
    end

    context 'invalid restaurant' do
      scenario 'does not let user submit a name that is too short' do
        sign_up
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
  end

  context 'viewing restaurants' do

    scenario 'lets a user view a restaurant' do
      sign_up
      create_restaurant(name: 'Tom & Jerry')
      click_link 'Tom & Jerry'
      expect(page).to have_content 'Tom & Jerry'
      expect(current_path).to eq "/restaurants/#{Restaurant.last.id}"
    end
  end

  context 'editing restaurants' do
    scenario 'let a user edit a restaurant' do
      sign_up
      create_restaurant
      visit '/restaurants'
      click_link 'Edit Hotdog'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Description', with: 'deep fried goodness'
      click_button 'Update Restaurant'
      click_link 'Kentucky Fried Chicken'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(page).to have_content 'deep fried goodness'
      expect(current_path).to eq "/restaurants/#{Restaurant.last.id}"
    end
  end

  context 'deleting restaurants' do
    before do
      sign_up
      create_restaurant
    end

    scenario 'removes a restaurant when user clicks delete link' do
      visit '/restaurants'
      click_link 'Delete Hotdog'
      expect(page).not_to have_content 'Hotdog'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

  context 'limits on what users can do' do
    scenario "site visiter can't add a restaurant" do
      visit root_path
      click_link "Add a restaurant"
      expect(page).not_to have_content "Create restaurant"
      expect(page).to have_content "Log in"
    end
  end

end
