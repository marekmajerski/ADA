Capybara.register_driver :chrome do |app|
  prefs = {
    download: {
      prompt_for_download: false,
      default_directory: Ada::Interactions::Page::FileDownload::PATH.to_s
    }
  }
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    switches: %w( --disable-popup-blocking --test-type --disable-extensions --kiosk),
    prefs: prefs,
    http_client: Selenium::WebDriver::Remote::Http::Default.new
  )
end
