# encoding: utf-8

require 'date'

module Lesswrong
  class NewMeetupPage < Lesswrong::BasePage
    url %r{^:base_url/meetups/new/?$}
    set_entry_url ':base_url/meetups/new/'

    expected_title 'New Meetup - Less Wrong'

    element :newmeetup_form,  :form, id: 'newmeetup', unique: true, cache: false, validator: true
    element :title,           :text_field, id: 'title', unique: true, cache: false, validator: true, parent: :newmeetup_form
    element :location,        :text_field, id: 'location', unique: true, cache: false, validator: true, parent: :newmeetup_form
    element :description,     :textarea, id: 'description', unique: true, cache: false, validator: true, parent: :newmeetup_form
    element :date,            :text_field, cache: false, validator: true, parent: :newmeetup_form, proc: -> parent, page {parent.text_fields(class_name: 'date').last}
    element :submit,          :button, type: 'submit', text: 'Submit Meetup', click_destination: :MeetupPage, cache: false, validator: true, parent: :newmeetup_form

    element :set_date_button, :button, validator: false, cache: false, text: 'Select Date and Time', unique: true

    def add_meetup title, location, description
      self.title.set title
      self.location.set location
      self.description.set description
      set_date (DateTime.now + 7).strftime('%D %T')
      self.submit.click
      sleep 6
    end

    def set_date date
      self.date.set date
      self.date.click
      self.set_date_button.click
    end
  end
end
