# frozen_string_literal: true

Given('there are representatives in the system') do
  @representative = Representative.create!(
    name:    'John Doe',
    ocdid:   'ocd-division/country:us/state:ca/sldl:12',
    title:   'Assembly Member',
    address: '123 Main St Sacramento CA 95814',
    party:   'Democratic',
    photo:   'https://example.com/photo.jpg'
  )
end

When('I visit the representative\'s profile page') do
  visit representative_path(@representative)
end

Then('I should see the representative\'s name') do
  expect(page).to have_content(@representative.name)
end

Then('I should see the representative\'s office title') do
  expect(page).to have_content(@representative.title)
end

Then('I should see the representative\'s contact address') do
  expect(page).to have_content(@representative.address)
end

Then('I should see the representative\'s political party') do
  expect(page).to have_content(@representative.party)
end

Then('I should see the representative\'s photo') do
  expect(page).to have_selector("img[src='#{@representative.photo}']")
end

When(/^I click on state (.+)$/) do |state|
  visit state_map_path(state)
end

When(/^I click on county (.+)$/) do |county|
  visit search_representatives_path(county)
end

Then(/^I should see text matching "([^"]*)"$/) do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_xpath('//*', text: regexp)
  else
    assert page.has_xpath?('//*', text: regexp)
  end
end
