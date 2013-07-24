# encoding: utf-8

module Lesswrong
  class WriteArticlePage < Lesswrong::BasePage
    url %r{^:base_url/submit/?$}
    set_entry_url ':base_url/submit/'

    expected_title 'Submit Article - Less Wrong'

    element :title,   :text_field,  id: 'title', validator: true
    element :medium,  :select_list, id: 'sr', validator: true
    element :submit,  :button,      type: 'submit', value: 'Submit', click_destination: :ArticlePage, validator: true
    element :article, :frame,       id: 'article_ifr'

    element :article_body, :body, parent: :article, validator: true

    def create_article title, body, medium
      self.title.set title
      self.article_body.send_keys body
      self.medium.select medium
      self.submit.click_once
    end
  end
end
