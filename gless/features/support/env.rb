load 'gless/lib/startup.rb'

require 'rspec/expectations'
World(RSpec::Matchers)
World(RSpec::Expectations)

Env_overrides =
  [ ['GE_SERVER',  :server, :url],
    ['GE_PORT',    :global, :browser, :port],
    ['GE_BROWSER', :global, :browser, :browser],
    ['GE_DEBUG',   :global, :debug]
  ]

def override_config config
  Env_overrides.each do |pair|
    if ENV.has_key? pair[0]
      config.set *pair[1..-1], ENV[pair[0]]
    end
  end

  if ENV.has_key? 'GE_YAML'
    @config.merge YAML::load(ENV['GE_YAML'])
  end

  config
end

After do |scenario|
  if @config.get :global, :debug
    if scenario.failed?
      @logger.debug "Since you're in debug mode, and we've just failed out, here's a debugger. #1"
      debugger
    end
  end
end

# Either start and end the test framework per-suite or per-scenario.

def start_test_framework
  require 'gless'

  # FIXME: the tag entry here will have to change for parallel runs.
  tag = ENV.has_key?('REPLAY_TAG') ? ENV['REPLAY_TAG'] : :test
  @logger, @config, @browser = Gless.setup( tag ) {|config| override_config config}

  if @config.get :global, :debug
    require 'debugger'
  end

  # Start the test application.
  klass = @config.get :global, :site, :class
  @application = Object.const_get(klass)::Application.new  @logger, @config, @browser
  @application.should be_true
end

def close_test_framework
  @browser.close
end

if ENV['GLESS_PER_SCENARIO']
  # Start and close the framework at the beginning and end of each scenario, respectively.

  Before do
    start_test_framework
  end

  After do |scenario|
    close_test_framework
  end
else
  # Only start and close the framework once, at the beginning and end of the
  # entire test suite.
  Before do
    if !$cucumber_Before_start_test_framework
      $cucumber_Before_start_test_framework = true

      at_exit do
        close_test_framework
      end

      start_test_framework
    end
  end
end
