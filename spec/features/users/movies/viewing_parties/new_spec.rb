require 'rails_helper'

RSpec.describe 'New Viewing Party Page' do
  describe 'Create a new viewing party', :vcr do

    it 'I can create a new viewing party' do
      user1 = User.create!(email: 'jon@jon.com', name: 'Jon')
      user2 = User.create!(email: 'bob@bob.com', name: 'Bob')
      user3 = User.create!(email: 'sally@sally.com', name: 'Sally')
      movie = MovieService.new.top_rated_movies.first
      movie_details = MovieService.new.full_movie_details(movie[:id])

      visit new_user_dashboard_movie_viewing_party_path(user1, movie[:id])

      expect(page).to have_content('Viewing Party')
      expect(page).to have_link('Home')
      expect(page).to have_link('Discover Movies')
      expect(page).to have_content('Movie Title')
      expect(page).to have_content(movie[:title])
      expect(page).to have_content('Duration')
      expect(page).to have_content(movie[:runtime])
      expect(page).to have_content('Date')
      expect(page).to have_field('date')
      expect(page).to have_content('Time')
      expect(page).to have_field('time')
      expect(page).to have_field("#{user1.email}")
      expect(page).to have_content('Invite Other Users')
      expect(page).to have_button('Create Party')
      expect(page).to have_content(user1.email)
      expect(page).to have_content(user2.email)
      expect(page).to have_content(user3.email)
      expect(page).to have_content(user1.name)
      expect(page).to have_content(user2.name)
      expect(page).to have_content(user3.name)
    end

    it 'I can create a new viewing party' do
      user = User.create!(email: 'jon@jon.com', name: 'Jon')
      user2 = User.create!(email: 'bob@bob.com', name: 'Bob')
      movie = MovieService.new.top_rated_movies.first
      movie_details = MovieService.new.full_movie_details(movie[:id])

      visit new_user_dashboard_movie_viewing_party_path(user, movie[:id])

      fill_in :date, with: '2023-08-01'
      fill_in :time, with: '12:00'
      fill_in :duration, with: movie[:runtime]
      check user2.email
      click_on 'Create Party'

      expect(current_path).to eq(user_dashboard_path(user))
    end
  end
end