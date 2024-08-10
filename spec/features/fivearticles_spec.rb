# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Edit news article form', type: :feature do
  before do
    @representative = Representative.create(name: 'John Doe')
    @issue = Issue.create(name: 'Healthcare')
    @article1 = Article.create(title: 'Top 5 Learning Tips', url: 'http://example.com/1',
                               description: 'Description of article 1')
    @article2 = Article.create(title: 'Top 10 Coding Practices', url: 'http://example.com/2',
                               description: 'Description of article 2')
    @articles = [@article1, @article2]
  end

  it 'User views the edit news article form with prefilled data' do
    visit edit_news_article_path

    expect(find_field('Representative').value).to eq('John Doe')
    expect(find_field('Issue').value).to eq('Healthcare')
    expect(page).to have_selector('input[type=radio]')
    expect(page).to have_select('Rating')
    expect(page).to have_button('Save')
    expect(page).to have_link('View news articles')
  end

  it 'User submits the form with new data' do
    visit edit_news_article_path

    choose('Top 5 Learning Tips')
    select '4', from: 'Rating'
    click_button 'Save'

    expect(page).to have_current_path(news_articles_path, ignore_query: true)
  end

  it 'User views article details' do
    visit edit_news_article_path

    within('.form-check', match: :first) do
      click_link 'Top 5 Learning Tips'
    end

    # check if article opened in new tab (?)
    expect(page.driver.browser.window_handles.count).to be > 1
  end
end