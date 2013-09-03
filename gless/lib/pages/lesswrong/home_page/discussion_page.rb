# encoding: utf-8

module Lesswrong
  class DiscussionPage < Lesswrong::HomePage
    url %r{^:base_url(/r/discussion/(promoted|new|top|saved))?/?(\?.*)?$}
    set_entry_url ':base_url/r/discussion/new'

    expected_title %r{^(Newest Submissions|Top scoring articles|Saved)?( - )?Less Wrong Discussion$}

    element :subnav,        :ul, id: 'filternav', unique: true, cache: false, validator: true
    element :new_link,      :link, parent: :subnav, href: %r{/r/discussion/new/?$}, text: "What's new", validator: true, cache: false, click_destination: :DiscussionPage
    element :top_link,      :link, parent: :subnav, href: %r{/r/discussion/top/?$}, text: 'Top', validator: true, cache: false, click_destination: :DiscussionPage

    element :saved_link,    :link, parent: :subnav, href: %r{/r/discussion/saved/?$}, text: 'Saved', validator: false, click_destination: :DiscussionPage

    Subnavs = [:new_link, :top_link]
    Subnavs_loggedin = [:saved_link]

    public :poke_subnav, :open_article_sub
  end
end
