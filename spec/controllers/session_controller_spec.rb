# frozen_string_literal: true

# TODO: Could not get session controller to work. Needs routing and a separate controller action to test against
require 'rails_helper'

RSpec.describe SessionController, type: :controller do
  let(:user) { create(:user) }

  before do
    pending 'This feature test is broken'
  end

  before do
    session[:current_user_id] = user.id
  end

  describe 'GET #some_action' do
    it 'allows access when logged in' do
      get :select_query
      expect(response).to be_successful
      expect(assigns(:news_item)).to eq(news_item)  # Check if the news_item is assigned correctly
    end
  end

  describe 'GET #some_action when not logged in' do
    before do
      session[:current_user_id] = nil
    end

    it 'redirects to login page when not logged in' do
      get :select_query
      expect(response).to redirect_to(login_url)
      expect(session[:destination_after_login]).to eq(request.env['REQUEST_URI'])
    end
  end
end
