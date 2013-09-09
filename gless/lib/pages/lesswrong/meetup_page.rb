# encoding: utf-8

module Lesswrong
  class MeetupPage < Lesswrong::BasePage
    url %r{^:base_url/meetups/(.*)/?$}

    expected_title /^(.*) - Less Wrong$/

    element :meetup_content_div, :div, class: 'meetup-content', cache: false, validator: true
  end
end
