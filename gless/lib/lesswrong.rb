require 'uri'
require 'gless'

module Lesswrong
  class Application
    include RSpec::Matchers

    attr_accessor :browser
    attr_accessor :session
    attr_accessor :site
    attr_accessor :base_url

    def initialize(logger, config, browser)
      @logger = logger
      @logger.debug "Lesswrong Application: initializing with #{browser.inspect}"

      @browser = browser
      @config = config

      @base_url = @config.get :global, :site, :url
      @base_url.should be_true

      # Create the session
      @session = Gless::Session.new @browser, @config, @logger, self

      @session.should be_true

      @logger.info "Lesswrong Application: going to the home page"
      @session.enter Lesswrong::HomePage
    end

    # Pass through unhandled messages to the session object.
    def method_missing(m, *args, &block)
      @session.send m, *args, &block
    end

    # Enter the home page if not already on it.
    def on_home
      @session.enter Lesswrong::HomePage unless @session.current_page == Lesswrong::HomePage
    end

    # Create the given category.   If the category has already been created,
    # skip.  The browser should remain on the create_category page after
    # creation.
    def require_category name, title, type, default_listing
      require_with (@categories_created ||= {}), name do
        @session.enter CreateCategoryPage
        @session.create_category name, title, type, default_listing
      end
    end

    # Create an article and submit it to +medium+, unless with the given title
    # has already been created.
    def require_article title, body, medium
      require_with (@articles_created ||= {}), title do
        (@session.create_article_button.exists?) ? @session.create_article_button.click : @session.enter(Lesswrong::WriteArticlePage)
        @session.create_article title, body, medium
      end
    end

    private

    def require_with table, id
      return table[id] if table[id]

      yield

      table[id] = true
    end
  end
end
