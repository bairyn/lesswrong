# encoding: utf-8

module Lesswrong
  class PreferencesPage < Lesswrong::BasePage
    url %r{^:base_url/prefs/?(\?.*)?$}

    expected_title /Preferences - Less Wrong/

    element :location, :text_field, name: 'location', validator: true
    element :submit,   :button,     type: 'submit', value: 'Save options', click_destination: :PreferencesPage, validator: true
    element :delete,   :link,       href: %r{/prefs/delete/?$}, text: 'Delete', click_destination: :DeleteAccountPage

    def update_location location
      self.location.set location
      self.submit.click
      sleep 5
    end
  end
end
