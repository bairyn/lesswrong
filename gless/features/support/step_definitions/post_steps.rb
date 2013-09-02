# Step definitions for the post feature.

Given 'the initial site configuration' do
  include LesswrongUtil::Config

  # Require both categories.
  @application.require_category 'lesswrong', 'Less Wrong', 'restricted', 'blessed'
  @application.require_category 'discussion', 'Less Wrong Discussion', 'public', 'new'

  # Require the about post.
  @application.require_article 'The ABOUT article', about_post_body, 'Less Wrong'

  configure_discussion
end

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
