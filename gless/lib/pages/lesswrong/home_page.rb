# encoding: utf-8

module Lesswrong
  class HomePage < Lesswrong::BasePage
    url %r{^:base_url/?(\?.*)?$}
    set_entry_url ':base_url'

    expected_title %r{(Welcome to )?Less Wrong}
  end
end
