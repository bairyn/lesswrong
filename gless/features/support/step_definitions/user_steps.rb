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

  @application.login_div.text.should_not =~ /\<Incorrect Password\>/
  @application.logged_in?.should be_true
end

When 'I delete my account' do
  @application.delete_account! 'Yes, please delete my account.'
end

Then /^logging into '(.*)' fails$/ do |user|
  @application.logout if @application.logged_in?
  @application.login user, user, false

  @application.session.login_div.text.should =~ /\<Incorrect Password\>/
  @application.logged_in?.should be_false
end
