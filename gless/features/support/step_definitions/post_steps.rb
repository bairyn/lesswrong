# Step definitions for the post feature.

When /^I post '(.*)' to '(Less Wrong|Less Wrong Discussion)' with content '(.*)'$/ do |title, category, content|
  @application.require_article title, content, category
end

Then /^the article should contain '(.*)'$/ do |content|
  #@application.current_page.should == Lesswrong::ArticlePage
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

Given /^I'm on the post '(.*)'$/ do |title|
  @application.open_article title
end

When 'I up-vote the article' do
  #@application.current_page.should == Lesswrong::ArticlePage
  @application.upvote_post
  sleep 6
end

Then /^the article should have '(\d+)' votes? if unhidden$/ do |votes|
  @application.post_votes.should == votes.to_i if @application.post_div.votes.exists?
end

When /^I comment '(.*)'$/ do |content|
  @application.post_comment content
end

Then /^a comment should contain '(.*)'$/ do |content|
  #@application.current_page.should == Lesswrong::ArticlePage
  @application.comment_bodies.any?(){|body_div| body_div.text =~ Regexp.new(Regexp.escape(content))}.should be_true
end
