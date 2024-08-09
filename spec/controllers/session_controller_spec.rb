# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionController, type: :controller do
  let(:user) { create(:user) }

  before do
    session[:current_user_id] = user.id
  end

  describe 'GET #some_action' do
    it 'allows access when logged in' do
      get :some_action
      expect(response).to be_successful
    end
  end

  describe 'GET #some_action when not logged in' do
    before do
      session[:current_user_id] = nil
    end

    it 'redirects to login page when not logged in' do
      get :some_action
      expect(response).to redirect_to(login_url)
      expect(session[:destination_after_login]).to eq(request.env['REQUEST_URI'])
    end
  end
end
