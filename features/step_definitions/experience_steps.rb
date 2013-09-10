def fill_experience_fields
  fill_in 'experience_team', with: 'Team Zero'
  select(Date.today.year,      from: 'experience_start_date_1i')
  select(Sport.first.name,     from: 'experience_sport_id')
  select(SportRole.first.name, from: 'experience_sport_role_id')
end

def fill_tournament_fields
  tournament = build :tournament
  find(:css, "input[id^='experience_tournaments_attributes_'][id$='_achievements']", ).set(tournament.achievements)
  find(:css, "input[id^='experience_tournaments_attributes_'][id$='_name']").set(tournament.name)
  find(:css, "select[id^='experience_tournaments_attributes_'][id$='_award_date_1i']").select(tournament.award_date.year)
end

Given(/^I am at my profile's new experience page$/) do
  visit my_profile_path
  click_on I18n.t('experience.add_new')
end

When(/^I fill in an experience$/) do
  fill_experience_fields
  click_on I18n.t('experience.edit.submit')
end

Then(/^I should see a creation success message$/) do
  page.should have_content 'created successfully'
end

When(/^I leave a required field blank for an experience$/) do
  fill_in 'experience_team', with: ''
  click_on I18n.t('experience.edit.submit')
end

When(/^I fill in an experience with a tournament$/) do
  fill_experience_fields
  click_on I18n.t('experience.form.labels.add_more')
  fill_tournament_fields

  # click_button I18n.t('experience.edit.submit')
  #
  # this should work, but doesn't, probably a webkit bug:
  # https://github.com/thoughtbot/capybara-webkit/issues/494
  #
  # workaround below:
  page.execute_script("$('form#new_experience').submit()")
end

Given(/^I have an experience$/) do
  @experience = create(:experience, user_id: @user.id)
end

Given(/^I am at an experience's edit page$/) do
  visit edit_experience_path(@experience)
end

When(/^I edit the experience's sport$/) do
  select(Sport.last.name, from: 'experience_sport_id')
  click_on 'Submit'
end

Then(/^I should see an edit success message$/) do
  page.should have_content 'edited successfully'
end