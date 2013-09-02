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
