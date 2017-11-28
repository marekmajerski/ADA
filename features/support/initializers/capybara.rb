# Default configurations for all the scenarios
Capybara.configure do |config|
  config.default_driver = Ada::Settings.capybara.default_driver.to_sym
  config.current_driver = Ada::Settings.capybara.current_driver.to_sym
  config.default_max_wait_time = Ada::Settings.capybara.default_wait_time.to_i
  config.javascript_driver = Ada::Settings.capybara.javascript_driver.to_sym
  config.default_selector = Ada::Settings.capybara.default_selector.to_sym
  config.automatic_reload = Ada::Settings.capybara.automatic_reload
  config.run_server = Ada::Settings.capybara.run_server

  port_increment = ENV['TEST_ENV_NUMBER'] ? ENV['TEST_ENV_NUMBER'].to_i : 0
  config.server_port = Ada::Settings.capybara.server_port.to_i + port_increment
end
