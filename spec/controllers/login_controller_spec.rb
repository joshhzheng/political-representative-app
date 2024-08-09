# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #login' do
    it 'renders the login page' do
      get :login
      expect(response).to be_successful
    end
  end

  describe 'GET #logout' do
    it 'logs out the user and redirects to root' do
      session[:current_user_id] = user.id
      get :logout
      expect(session[:current_user_id]).to be_nil
      expect(response).to redirect_to(root_path)
    end
  end

  # Add more tests for OAuth callbacks as needed
end
