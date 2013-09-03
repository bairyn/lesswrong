# encoding: utf-8

module Lesswrong
  class MainPage < Lesswrong::HomePage
    url %r{^:base_url(/(promoted|new|top|saved))?/?(\?.*)?$}
    set_entry_url ':base_url'

    expected_title %r{^(Newest Submissions|Top scoring articles|Saved)?( - )?Less Wrong?$}

    element :subnav,        :ul, id: 'filternav', unique: false, cache: false, validator: true
    element :promoted_link, :link, parent: :subnav, href: %r{/promoted/?$}, text: 'Promoted', validator: true, cache: false, click_destination: :MainPage
    element :new_link,      :link, parent: :subnav, href: %r{/new/?$}, text: 'New', validator: true, cache: false, click_destination: :MainPage
    element :top_link,      :link, parent: :subnav, href: %r{/top/?$}, text: 'Top', validator: true, cache: false, click_destination: :MainPage

    element :saved_link,    :link, parent: :subnav, href: %r{/saved/?$}, text: 'Saved', validator: false, cache: false, click_destination: :MainPage

    element :post_divs,     :divs, class: 'post list', cache: false, validator: false

    Subnavs = [:promoted_link, :new_link, :top_link]
    Subnavs_loggedin = [:saved_link]

    public :poke_subnav, :open_article_sub
  end
end
