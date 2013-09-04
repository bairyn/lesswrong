# encoding: utf-8

module Lesswrong
  class WriteArticlePage < Lesswrong::BasePage
    url %r{^:base_url/submit/?$}
    set_entry_url ':base_url/submit/'

    expected_title 'Submit Article - Less Wrong'

    element :title,   :text_field,  id: 'title', cache:false, validator: true
    element :medium,  :select_list, id: 'sr', cache:false, validator: true
    element :submit,  :button,      type: 'submit', value: 'Submit', click_destination: :ArticlePage, cache: false, validator: true
    element :article, :frame,       id: 'article_ifr', cache: false

    element :_article_body, :body, parent: :article, cache: false, validator: false

    def create_article title, body, medium
      self.title.set title

      with_article_body do |article_body|
        article_body.send_keys body
      end

      begin
        self.medium.select medium
      rescue Watir::Exception::NoValueFoundException => e
        raise "WriteArticlePage#create_article: The post medium was not found.  Is the karma configuration for testing correct?  The available options are '#{self.medium.options.map &:text}'.  #{e.inspect}"
      end
      self.submit.click_once(true) {sleep 1}  # Element no longer exists as modeled after the first click; use click_once(true).
      sleep 6
      if @session.current_page == WriteArticlePage && self.submit.exists?
        self.submit.click_once(true) {sleep 1}
      end
    end

    def with_article_body
      self._article_body.focus
      yield self._article_body
      self.title.focus
    end
  end
end
