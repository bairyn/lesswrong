# Step definitions for the post feature.

Given /^the user '(.*)'$/ do |username|
  @application.register username, false
  @application.toggle_admin true if username == 'admin'
end

Given 'the initial site configuration' do
  include LesswrongUtil::Config

  # Require both categories.
  @application.require_category 'lesswrong', 'Less Wrong', 'restricted', 'blessed'
  @application.require_category 'discussion', 'Less Wrong Discussion', 'public', 'new'

  # Require the about post.
  @application.require_article 'The ABOUT article', about_post_body, 'Less Wrong'

  configure_discussion
end
