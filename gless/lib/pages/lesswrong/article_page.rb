# encoding: utf-8

module Lesswrong
  class ArticlePage < Lesswrong::BasePage
    url %r{^:base_url/(r/[^/]+/)?lw(/[^/]+)?/([^/]+)/?$}

    expected_title /(.*) - Less Wrong(| Discussion)$/

    element :content, :div, class_name: 'md', unique: true, validator: true

    def get_content
      content.text
    end

    # Returns either 'Less Wrong' or 'Less Wrong Discussion'
    def get_category
      @session.browser.url =~ %r{/r/discussion/lw/} ? 'Less Wrong Discussion' : 'Less Wrong'
    end
  end
end
