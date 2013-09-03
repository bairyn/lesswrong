# encoding: utf-8

module Lesswrong
  class HomePage < Lesswrong::BasePage
    url %r{^:base_url((/r/discussion)?/(promoted|new|top|saved))?/?(\?.*)?$}
    set_entry_url ':base_url'

    expected_title %r{^(Newest Submissions|Top scoring articles|Saved)?( - )?Less Wrong( Discussion)?$}

    element :nav,             :ul, id: 'nav', unique: true, cache: false, validator: true
    element :main_link,       :link, parent: :nav, href: %r{/promoted/?$}, text: 'Main', validator: true, cache: false, click_destination: :MainPage
    element :discussion_link, :link, parent: :nav, href: %r{/r/discussion/new/?$}, text: 'Discussion', validator: true, cache: false, click_destination: :DiscussionPage
    element :post_divs,       :divs, cache: false, class: 'post list', validator: false

    def poke_nav
      main_link.click
      @session.poke_subnav
      discussion_link.click
      @session.poke_subnav
    end

    # Does not work for articles on pages other than the first.
    def open_article title, must_open = true
      main_link.click
      return if @session.open_article_sub title
      discussion_link.click
      return if @session.open_article_sub title
      raise "HomePage#open_article: no article found, and must_open is '#{must_open}'." if must_open
    end

    protected

    def poke_subnav
      self.class::Subnavs.each {|sym| send(sym).click}
      self.class::Subnavs_loggedin.each {|sym| send(sym).click} if logged_in?
    end

    def open_article_sub title, must_open = true
      self.class::Subnavs.each {|sym| send(sym).click; break true if open_article_current_category title} ||
        self.class::Subnavs_loggedin.each {|sym| send(sym).click; break true if open_article_current_category title} ||
        false
    end

    def open_article_current_category title
      post_links = post_divs.map {|div| div.as[0]}
      matches = post_links.select {|link| title.kind_of?(String) ? link.text == title : link.text =~ title}
      if matches.empty?
        return false
      else
        matches[0].click
        @session.acceptable_pages = :ArticlePage
        @session.change_pages Lesswrong::ArticlePage
        return true
      end
    end
  end
end
