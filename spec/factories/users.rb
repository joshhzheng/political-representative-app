# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name  { 'Doe' }
    uid        { '123456789' }
    provider   { :google_oauth2 } # or :github if you want to test GitHub login
  end
end
