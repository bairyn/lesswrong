# encoding: utf-8

module Lesswrong
  class ArticlePage < Lesswrong::BasePage
    url %r{^:base_url/(|r/[^/]+/)lw/([^/]+)/?$}

    expected_title /(.*) - Less Wrong(| Discussion)$/

    element :content, :div, class_name: 'md', validator: true
  end
end
