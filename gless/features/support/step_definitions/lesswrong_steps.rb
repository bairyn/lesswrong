# Step definitions shared by all lesswrong tests.

Given 'I go to the home page' do
  @application.session.enter Lesswrong::HomePage
end

Given /^the user '(.*)'$/ do |username|
  @application.register username, false
  @application.toggle_admin true if username == 'admin'
end
