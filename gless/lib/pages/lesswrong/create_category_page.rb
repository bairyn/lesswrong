# encoding: utf-8

module Lesswrong
  class CreateCategoryPage < Lesswrong::BasePage
    url %r{^:base_url/categories/create/?$}
    set_entry_url ':base_url/categories/create'

    expected_title 'Create a category - Less Wrong'

    element :name,            :text_field,  validator: true,  id: 'name'
    element :title,           :text_field,  validator: true,  id: 'title'
    element :type,            :radio,       validator: false, proc: -> parent, page, value {parent.radio(name: 'type', value: value)}
    element :default_listing, :select_list, validator: true,  id: 'default_listing'
    element :create,          :button,      validator: true,  name: 'create'

    def create_category name, title, type, default_listing
      self.name.set name
      self.title.set title
      self.type(type).click
      self.default_listing.select default_listing
      self.create.click
    end
  end
end
