# Step definitions shared by all lesswrong tests.

Given 'I go to the home page' do
  @application.session.enter Lesswrong::HomePage
end

Given 'TODO' do
  raise 'TODO invoked.'
end
