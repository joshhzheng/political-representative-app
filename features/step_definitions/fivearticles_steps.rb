# frozen_string_literal: true

Given('I am on the edit news article page for Representative {string}') do |representative_id|
  visit representative_search_top_articles_path(representative_id: representative_id)
  @representative = Representative.find(representative_id)
  @news_item = NewsItem.create!(title: 'Sample Article', description: 'This is a sample article.', link: 'http://example.com', issue: 'Immigration', representative: @representative, rating: 3)
end

Then('I should see the Representative field prefilled with {string}') do |expected_representative|
  expect(find_field('Representative').value).to eq(expected_representative)
end

Then('I should see the Issue field prefilled with {string}') do |expected_issue|
  expect(find_field('Issue').value).to eq(expected_issue)
end

Then('I should see a radio button list for articles') do
  expect(page).to have_selector('input[type=radio]')
end

Then('I should see a select dropdown for Rating') do
  expect(page).to have_select('Rating')
end

Then('I should see a Save button') do
  expect(page).to have_button('Save')
end

Then('I should see a View news articles button') do
  expect(page).to have_link('View news articles')
end

When('I choose the article {string} from the list') do |article_title|
  article = page.find('label', text: article_title)
  radio_button_id = article[:for]
  choose(radio_button_id)
end

When('I select {string} from the Rating dropdown') do |rating|
  select rating, from: 'Rating'
end

When('I press {string}') do |button_text|
  click_button(button_text)
end

Then('I should be redirected to the news articles page') do
  expect(current_path).to eq(news_articles_path)
end

Then('I should see the article details in a new tab') do
  # not sure how to test if it opens in a new tab
end