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

Then(/^I should see a "([^"]*)" category$/) do |text|
  expect(page).to have_selector('h3', text: text)
end

Then(/^I should see a search result with title "([^"]*)"$/) do |text|
  expect(page).to have_selector('a', class: %w(gs-title govuk-link), text: text)
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

When(/^I click the search button$/) do
  click_button(class: 'gsc-search-button')
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in(field, with: value)
end

Then(/^I should get "([^"]*)" results$/) do |num|
  expect(page).to have_selector('a', class: %w(gs-title govuk-link), count: num)
end

And(/^I take a screenshot with name "([^"]*)" to detect changes$/) do |filename|
  # Scroll to the section that matters, i.e. the search bar and a few results
  scroll_to(page.find('#google-custom-search'))

  # Set the focus back to the text input
  page.find('input.gsc-input').click

  # Take a screenshot and performs a diff against the previous (committed) version
  #
  # Please note that the diff test can fail from time to time due to results being
  # returned in a different order or the snippets wording changing. If this happens,
  # the new screenshot will overwrite the previous one. Always check the changes to
  # evaluate if this new screenshot is legit and should be committed or if there
  # are any regressions that we must address in code.
  screenshot filename

  # Check if there have been changes to the file since last commit
  # This command will return 1 if there are changes (so we fail the test) or 0 otherwise
  # We disable this on CI because screenshots will be different as it runs on Ubuntu etc.
  # However on CI we store as artifacts the screenshots for later inspection.
  if ENV['CI_DISABLE_SCREENSHOT_DIFF']
    warn('[!] Disabling screenshot diffs because we are running on CI.')
  else
    `git diff --exit-code features/screenshots/#{filename}.png`
    fail("[!] '#{filename}.png' screenshot has diffs. Make sure this is not a regression.") if $?.exitstatus != 0
  end
end
