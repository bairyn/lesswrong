# encoding: utf-8

module LessWrong
  class HomePage < LessWrong::BasePage
    url %r{^:base_url/?$}
    set_entry_url ':base_url'

    expected_title 'Welcome to Less Wrong'

    # TODO: more
  end
end
