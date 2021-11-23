When(/^I visit "([^"]*)"$/) do |path|
  visit path
end

Then(/^I should be on "([^"]*)"$/) do |page_name|
  expect("#{Capybara.app_host}#{URI.parse(current_url).path}").to eql("#{Capybara.app_host}#{page_name}")
end

Then(/^I should see "([^"]*)"$/) do |text|
  expect(page).to have_text(text)
end

Then(/^I should not see "([^"]*)"$/) do |text|
  expect(page).not_to have_text(text)
end

Then(/^I should see the button "([^"]*)"$/) do |text|
  expect(page).to have_button(text, match: :first)
end

Then(/^I should see a "([^"]*)" link to "([^"]*)"$/) do |text, href|
  expect(page).to have_link(text, href: href)
end

When(/^I click the "([^"]*)" link$/) do |text|
  click_link(text)
end

When(/^I click the "([^"]*)" button$/) do |text|
  click_button(text)
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in(field, with: value)
end
