# encoding: utf-8

module Lesswrong
  class ArticlePage < Lesswrong::BasePage
    url %r{^:base_url/(r/[^/]+/)?lw(/[^/]+)?/([^/]+)/?$}

    expected_title /(.*) - Less Wrong( Discussion)?$/

    element :content, :div, class_name: 'md', unique: false, cache: false, validator: false

    #
    element :post_div, :div, cache: false, validator: true, unique: true, class_name: 'post'

    # Must be restricted by +post_div+ or +comment+ to access.
    element :upvote,   :link, validator: false, class_name: 'up', cache: false, validator: false, unique: true
    element :downvote, :link, validator: false, class_name: 'down', cache: false, validator: false, unique: true
    element :votes,    :span, validator: false, class_name: /^votes ?$/, id: /^score/, cache: false, validator: false, unique: true

    element :comment_box, :textarea, id: /^comment_reply_t.+$/, name: 'comment', cache: false, validator: false, unique: true

    element :comments_div,   :div, class_name: 'sitetable', id: /^siteTable_t.+$/
    element :comment_bodies, :divs, id: /^body_t.+$/, class_name: 'comment-content', cache: false, validator: false, unique: true
    element :submit_comment, :button, type: 'submit', id: /^comment_submit_t.+$/, text: 'Comment', cache: false, validator: false, unique: true

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

    def post_comment content
      comment_box.set content
      submit_comment.click
      sleep 6
    end
  end
end
