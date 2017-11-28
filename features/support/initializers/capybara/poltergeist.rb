require 'phantomjs'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    phantomjs: Phantomjs.path, # use phantomjs from gem
    phantomjs_logger: Ada::Logger.instance,
    js_errors: false,
    debug: false,
    window_size: [2000, 2000],
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome,
    http_client: Selenium::WebDriver::Remote::Http::Default.new
  )
end
