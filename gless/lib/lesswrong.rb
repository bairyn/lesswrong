require 'uri'
require 'gless'

module LessWrong
  class Application
    include RSpec::Matchers

    attr_accessor :browser
    attr_accessor :session
    attr_accessor :site
    attr_accessor :base_url

    def initialize(logger, config, browser)
      @logger = logger
      @logger.debug "LessWrong Application: initializing with #{browser.inspect}"

      @browser = browser
      @config = config

      @base_url = @config.get :global, :site, :url
      @base_url.should be_true

      # Create the session
      @session = Gless::Session.new @browser, @config, @logger, self

      @session.should be_true

      @logger.info "LessWrong Application: going to the home page"
      @session.enter LessWrong::HomePage
    end
  end
end
