# encoding: utf-8

module Lesswrong
  class ArticlePage < Lesswrong::BasePage
    url %r{^:base_url/(r/[^/]+/)?lw(/[^/]+)?/([^/]+)/?$}

    expected_title /(.*) - Less Wrong( Discussion)?$/

    #element :content, :div, class_name: 'md', unique: true, cache: false, validator: true
    element :content, :div, class_name: 'md', unique: false, cache: false, validator: false

    #element :post_div, :div, cache: false, validator: true, unique: true, class_name: 'post'
    element :post_div, :div, cache: false, validator: false, unique: true, class_name: 'post'

    # Must be restricted by +post_div+ or +comment+ to access.
    element :upvote,   :link, validator: false, class_name: 'up', cache: false, validator: false, unique: true
    element :downvote, :link, validator: false, class_name: 'down', cache: false, validator: false, unique: true
    element :votes,    :span, validator: false, class_name: /^votes ?$/, id: /^score/, validator: false, unique: true

    def get_content
      content.text
    end

    # Returns either 'Less Wrong' or 'Less Wrong Discussion'
    def get_category
      @session.browser.url =~ %r{/r/discussion/lw/} ? 'Less Wrong Discussion' : 'Less Wrong'
    end

    def upvote_post
      post_div.upvote.click
    end

    def downvote_post
      post_div.upvote.click
    end

    def post_votes
      post_div.votes.text.to_i
    end
  end
end
