# Step definitions for the user feature.

When /^I set my location to '(.*)'$/ do |location|
  @application.goto_preferences

  @application.update_location location
end

Given /^that the extra user info does not contain '(.*)'$/ do |text|
  @application.extra_userinfo_list.text.should_not =~ Regexp.new(Regexp.escape(text))
end

Then /^the extra user info contains '(.*)'$/ do |text|
  @application.extra_userinfo_list.text.should =~ Regexp.new(Regexp.escape(text))
end

Given /^logging into '(.*)' succeeds$/ do |user|
  @application.logout if @application.logged_in?
  @application.login user, user, false

  sleep 5

  @application.user_div.text.should_not =~ /\bIncorrect password\b/
  @application.logged_in?.should be_true
end

Then /^logging into '(.*)' fails$/ do |user|
  @application.logout if @application.logged_in?
  @application.login user, user, false

  sleep 5

  @application.session.login_div.text.should =~ /\bIncorrect password\b/
  @application.logged_in?.should be_false
end

When 'I delete my account' do
  @application.delete_account! 'Yes, please delete my account.'
end
