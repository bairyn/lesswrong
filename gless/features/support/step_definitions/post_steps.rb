# Step definitions for the post feature.

When /^I post '(.*)' to '(Less Wrong|Less Wrong Discussion)' with content '(.*)'$/ do |title, category, content|
  @application.require_article title, content, category
end

Then /^the article should contain '(.*)'$/ do |content|
  @application.current_page.should == Lesswrong::ArticlePage
  @application.get_content.should =~ Regexp.new(Regexp.escape(content))
end

Then /^I should be in the category '(.*)'$/ do |category|
  @application.get_category.should == category
end

Given /^the post '(.*)'$/ do |title|
  @application.require_article title
end

Given 'I am logged out' do
  @application.on_home unless [:logout, :logged_in?].all? {|meth| @application.respond_to? meth}
  @application.logout if @application.logged_in?
end

Given 'the categories are available' do
  @application.on_home
  @application.poke_nav
end

When /^I open the post '(.*)'$/ do |title|
  @application.open_article title
end
